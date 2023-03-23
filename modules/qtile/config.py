from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod1"
terminal = "alacritty"

colors = [
	"2E3440",
	"3B4252",
	"434C5E",
	"4C566A",
	"D8DEE9",
	"E5E9F0",
	"ECEFF4",
	"8FBCBB",
	"88C0D0",
	"81A1C1",
	"#5E81AC",
	"#BF616A",
	"#D08770",
	"#EBCB8B",
	"#A3BE8C",
	"#B48EAD"
]

keys = [
	# A list of available commands that can be bound to keys can be found
	# at https://docs.qtile.org/en/latest/manual/config/lazy.html
	# Switch between windows
	Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
	Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
	Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
	Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
	Key([mod], "space", lazy.spawn("dmenu_run"), desc="Spawm dmenu"),
	# Move windows between left/right columns or move up/down in current stack.
	# Moving out of range in Columns layout will create new column.
	Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
	Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
	Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
	Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
	# Grow windows. If current window is on the edge of screen and direction
	# will be to screen edge - window would shrink.
	Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
	Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
	Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
	Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
	Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
	Key([mod], "g", lambda qtile: print_current_group(qtile)),
	# Toggle between split and unsplit sides of stack.
	# Split = all windows displayed
	# Unsplit = 1 window displayed, like Max layout, but still with
	# multiple stack panes
	Key(
		[mod, "shift"],
		"Return",
		lazy.layout.toggle_split(),
		desc="Toggle between split and unsplit sides of stack",
	),
	Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
	# Toggle between different layouts as defined below
	Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
	Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
	Key([mod], "r", lazy.reload_config(), desc="Reload the config"),
	Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
]

groups = [Group("1"),
		  Group("2", matches=[Match(wm_class=["firefox"])]),
		  Group("3"),
		  Group("4"),
		  Group("5"),
		  Group("6"),
		  Group("7"),
		  Group("8"),
		  Group("9")]

for i in groups:
	keys.extend(
		[
			# mod1 + letter of group = switch to group
			Key(
				[mod],
				i.name,
				lazy.group[i.name].toscreen(),
				desc="Switch to group {}".format(i.name),
			),
			# mod1 + shift + letter of group = switch to & move focused window to group
			Key(
				[mod, "shift"],
				i.name,
				lazy.window.togroup(i.name, switch_group=True),
				desc="Switch to & move focused window to group {}".format(i.name),
			),
			# Or, use below if you prefer not to switch to that group.
			# # mod1 + shift + letter of group = move focused window to group
			# Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
			#	 desc="move focused window to group {}".format(i.name)),
		]
	)

layouts = [
	layout.Columns(border_focus_stack=[colors[1], colors[10]], border_width=2),
	layout.Max(),
	# Try more layouts by unleashing below layouts.
	# layout.Stack(num_stacks=2),
	# layout.Bsp(),
	# layout.Matrix(),
	# layout.MonadTall(),
	# layout.MonadWide(),
	# layout.RatioTile(),
	# layout.Tile(),
	# layout.TreeTab(),
	# layout.VerticalTile(),
	# layout.Zoomy(),
]

widget_defaults = dict(
	font="UbuntuMono Nerd Font",
	fontsize=16,
	padding=2,
	background=colors[0],
	foreground=colors[4]
)
extension_defaults = widget_defaults.copy()

screens = [
	Screen(
		bottom=bar.Bar(
			[
				widget.GroupBox(hide_unused=True,
								highlight_method="block",
								active=colors[5],
								inactive=colors[4],
								this_current_screen_border=colors[10],
								rounded=False,
								padding=4,
								this_screen_border=colors[1]),
				widget.CurrentLayoutIcon(scale=0.5),
				widget.Spacer(length=2),
				widget.WindowName(fmt=" {}", background=colors[10]),
				#widget.Chord(
				#	chords_colors={
				#		"launch": ("#ff0000", "#ffffff"),
				#	},
				#	name_transform=lambda name: name.upper(),
				#),
				widget.Clock(format="   %d-%b-%Y - %H:%M:%S"),
			],
			24,
			# border_width=[2, 0, 2, 0],  # Draw top and bottom borders
			# border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
		),
	),
]

# Drag floating layouts.
mouse = [
	Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
	Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
	Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
	float_rules=[
		*layout.Floating.default_float_rules,
		#Match(wm_class="confirmreset"),  # gitk
	]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True
