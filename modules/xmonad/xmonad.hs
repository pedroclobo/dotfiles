import XMonad
import Data.Monoid
import System.Exit
import Graphics.X11.ExtraTypes.XF86
import XMonad.Actions.NoBorders
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (ToggleStruts(..))
import XMonad.Hooks.WindowSwallowing
import XMonad.Layout.MultiToggle.Instances (StdTransformers(NBFULL))
import XMonad.Util.SpawnOnce
import XMonad.Util.NamedScratchpad

import qualified XMonad.Layout.MultiToggle as MT (Toggle(..))
import qualified XMonad.StackSet as W
import qualified Data.Map as M

------------------------------------------------------------------------

-- Defaults
myFocusFollowsMouse = False
myClickJustFocuses = False
myBorderWidth = 1
myModMask = mod1Mask
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
myNormalBorderColor  = "#3b4252"
myFocusedBorderColor = "#5e81ac"

------------------------------------------------------------------------

-- Keys
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

	[
	  -- programs
	  ((modm,               xK_Return ), spawn "alacritty"              ),
	  ((modm,               xK_space  ), spawn "dmenu_run"              ),
	  ((modm,               xK_b      ), spawn "firefox"                ),

	  -- scripts
	  ((modm,               xK_Escape ), spawn "power"                  ),
	  ((0,                  xK_Print  ), spawn "screen-save"            ),
	  ((shiftMask,          xK_Print  ), spawn "screen-clip"            ),

	  -- layouts
	  ((modm,               xK_Tab    ), sendMessage NextLayout         ),

	  -- window management
	  ((modm,               xK_q      ), kill                           ),
	  ((modm,               xK_j      ), windows W.focusDown            ),
	  ((modm,               xK_k      ), windows W.focusUp              ),
  	  ((modm .|. shiftMask, xK_j      ), windows W.swapDown             ),
	  ((modm .|. shiftMask, xK_k      ), windows W.swapUp               ),
	  ((modm,               xK_n      ), windows W.swapMaster           ),
	  ((modm,               xK_h      ), sendMessage Shrink             ),
	  ((modm,               xK_l      ), sendMessage Expand             ),
	  ((modm,               xK_t      ), withFocused $ windows . W.sink ),
	  ((modm,               xK_f      ), withFocused toggleBorder >>
	                                     sendMessage (MT.Toggle NBFULL) >>
	                                     sendMessage ToggleStruts ),

	  -- xmonad
	  ((modm .|. shiftMask, xK_q      ), spawn "xmonad --restart"       )
	]

	++

	-- mod-[1..9]: switch to workspace N
	-- mod-shift-[1..9]: move client to workspace N
	[
	  ((m .|. modm, k), windows $ f i)
	       | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
	       , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
	]

------------------------------------------------------------------------

-- Mouse
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

	[
	  ((modm, button1), (\w -> focus w >> mouseMoveWindow w
	                                   >> windows W.shiftMaster)),

	  ((modm, button3), (\w -> focus w >> mouseResizeWindow w
	                                   >> windows W.shiftMaster))
	]

------------------------------------------------------------------------

-- Layouts
myLayout = tiled ||| Full
	where
		tiled = Tall nmaster delta ratio
		nmaster = 1
		ratio   = 1/2
		delta   = 2/100

------------------------------------------------------------------------

-- Window Rules
myScratchpads =
	[
	  NS "calc" "alacritty --class calc -e calc" (resource =? "calc") (wp),
	  NS "pulsemixer" "alacritty --class pulsemixer -e pulsemixer" (resource =? "pulsemixer") (wp)
	] where wp = customFloating $ W.RationalRect 0.1 0.1 0.8 0.8

myScratchpadKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
	[
	  ((modm, xK_c), namedScratchpadAction myScratchpads "calc"),
	  ((modm, xK_p), namedScratchpadAction myScratchpads "pulsemixer")
	]

myManageHook = composeAll
	[
	  className =? "pinentry" --> doFloat,
	  className =? "firefox"  --> doShift ( myWorkspaces !! 1 ),
	  className =? "discord"  --> doShift ( myWorkspaces !! 8 )
	] <+> namedScratchpadManageHook myScratchpads

------------------------------------------------------------------------

-- Event Handling
myEventHook = swallowEventHook (className =? "Alacritty") (return True)

------------------------------------------------------------------------

-- Status bars and logging
myBar = "xmobar"
myPP = xmobarPP {
	ppCurrent = xmobarColor "#e5e9f0" "" . wrap "<box type=Bottom width=2 mb=2 color=#5e81ac>" "</box>",
	ppVisible = xmobarColor "#d8dee9" "",
	ppHidden = xmobarColor "#d8dee9" "",
	ppTitle = xmobarColor "#d8dee9" "" . shorten 50,
	ppLayout = xmobarColor "#d8dee9" "",
	ppSep = " | ",
	ppWsSep = "  "
}
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_o)
myLogHook = return ()

------------------------------------------------------------------------

-- Startup hook
myStartupHook = do
	spawnOnce "xset s off -dpms"

------------------------------------------------------------------------

main = xmonad =<< statusBar myBar myPP toggleStrutsKey defaults

defaults = def {
	focusFollowsMouse  = myFocusFollowsMouse,
	clickJustFocuses   = myClickJustFocuses,
	borderWidth        = myBorderWidth,
	modMask            = myModMask,
	workspaces         = myWorkspaces,
	normalBorderColor  = myNormalBorderColor,
	focusedBorderColor = myFocusedBorderColor,
	keys               = myKeys <+> myScratchpadKeys,
	mouseBindings      = myMouseBindings,
	layoutHook         = myLayout,
	manageHook         = myManageHook,
	handleEventHook    = myEventHook,
	logHook            = myLogHook,
	startupHook        = myStartupHook
}
