from libqtile import bar, layout, widget, qtile, hook
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

import psutil
import os

mod = "mod1"

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
	Key([mod], "space", lazy.spawn("dmenu_run")),
	Key([mod], "Return", lazy.spawn(os.environ.get("TERMINAL"))),
	Key([mod], "b", lazy.spawn(os.environ.get("BROWSER"))),
	Key([mod], "Escape", lazy.spawn("sh power")),
	Key([mod], "f", lazy.window.toggle_fullscreen()),

	Key([mod], "Tab", lazy.next_layout()),
	Key([mod], "q", lazy.window.kill()),
	Key([mod], "r", lazy.reload_config()),

	Key([], "Print", lazy.spawn("sh screen-save")),
	Key(["shift"], "Print", lazy.spawn("sh screen-clip")),

	# Switch between windows
	Key([mod], "j", lazy.layout.down()),
	Key([mod], "k", lazy.layout.up()),

	# Grow windows
	Key([mod], "h", lazy.layout.grow(), lazy.layout.increase_nmaster()),
	Key([mod], "l", lazy.layout.shrink(), lazy.layout.decrease_nmaster()),
	Key([mod], "n", lazy.layout.flip()),
]

groups = [Group("1"),
		  Group("2", matches=[Match(wm_class=["firefox"])]),
		  Group("3"),
		  Group("4"),
		  Group("5"),
		  Group("6"),
		  Group("7"),
		  Group("8"),
		  Group("9", matches=[Match(wm_class=["discord"])])]

for i in groups:
	keys.extend(
		[
			Key([mod], i.name, lazy.group[i.name].toscreen()),
			Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
		]
	)

layouts = [
	layout.MonadTall(border_focus=colors[10], border_normal=colors[1])
]

widget_defaults = dict(
	font="UbuntuMono Nerd Font",
	fontsize=14,
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
				widget.WindowName(fmt=" {}", background=colors[10]),
				widget.Volume(fmt=" Vol: {} "),
				widget.Sep(height_percent=100, padding=4),
				widget.Clock(format=" %d-%b-%Y - %H:%M:%S"),
			],
			24,
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
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
	float_rules=[
		*layout.Floating.default_float_rules,
		Match(wm_class="pinentry"),
	]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

@hook.subscribe.client_new
def _swallow(window):
	pid = window.window.get_net_wm_pid()
	ppid = psutil.Process(pid).ppid()
	cpids = {c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()}
	for i in range(5):
		if not ppid:
			return
		if ppid in cpids:
			parent = window.qtile.windows_map.get(cpids[ppid])
			parent.minimized = True
			window.parent = parent
			return
		ppid = psutil.Process(ppid).ppid()

@hook.subscribe.client_killed
def _unswallow(window):
	if hasattr(window, 'parent'):
		window.parent.minimized = False
