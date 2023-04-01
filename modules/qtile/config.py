from libqtile import bar, layout, widget, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

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
	Key([mod], "b", lazy.spawn("firefox")),
	Key([mod], "Escape", lazy.spawn("sh power")),
	Key([mod], "f", lazy.window.toggle_fullscreen()),

	Key([mod], "Tab", lazy.next_layout()),
	Key([mod], "q", lazy.window.kill()),
	Key([mod], "r", lazy.reload_config()),

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
		  Group("9")]

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
