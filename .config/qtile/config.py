# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS O
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess
from libqtile.log_utils import logger
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal, send_notification
from custom.widgets import MouseOverClock
import colors

colors = colors.Dracula
mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(
        [mod],
        "Tab",
        lazy.layout.next(),
        desc="Move window focus to other window",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
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
    Key([mod], "Space", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    # custom keys
    Key(
        ["mod1"],
        "F1",
        lazy.run_extension(
            extension.DmenuRun(
                dmenu_command="dmenu_run -c -l 10",
                dmenu_prompt=" ",
                dmenu_font="Iosevka Nerd Font:size=11",
                dmenu_height=30,
            )
        ),
        # lazy.spawn('dmenu_run -c -l 20 -h 32 -fn "Iosevka Nerd Font:size=11" -p " "'),
    ),
    Key([mod], "b", lazy.spawn("brave"), desc="Launch brave"),
    KeyChord(
        [mod],
        "s",
        [
            Key([], "s", lazy.spawn("flameshot gui -s -c"), desc="Take a screenshot"),
        ],
    ),
    Key(
        [
            mod,
            "shift",
        ],
        "x",
        lazy.run_extension(
            extension.CommandSet(
                dmenu_command="dmenu -c -l 20",
                dmenu_prompt=" ",
                dmenu_font="Iosevka Nerd Font:size=10",
                dmenu_height=30,
                commands={
                    "Lock screen": "betterlockscreen -l dim",
                },
            )
        ),
        desc="",
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ +1%"),
        desc="Raise volume",
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn("pactl set-sink-volume @DEFAULT_SINK@ -1%"),
        desc="Lower volume",
    ),
]

groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
group_labels = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII"]
# group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX",]
# group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]
# group_labels = ["", "", "", "", "", "", "", "", "",]


group_layouts = [
    "max",
    "max",
    "max",
    "max",
    "max",
    "max",
    "max",
    "max",
]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

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
            # mod1 + shift + letter of group = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Move focused window to group {}".format(i.name),
            ),
        ]
    )

layout_theme = {
    "margin": 5,
    "border_focus": colors[8],
    "border_normal": colors[0],
}

layouts = [
    # layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(**layout_theme),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(
    #     margin=5,
    #     border_width=0,
    # ),
    layout.TreeTab(
        font="Iosevka Nerd Font SemiBold",
        fontsize=13,
        padding_y=4,
    ),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Iosevka Nerd Font SemiBold",
    fontsize=14,
    padding=3,
    background=colors[0],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(length=5),
                # widget.Image(
                #     filename="~/.config/qtile/archlinux.svg",
                #     margin=6,
                # ),
                widget.CurrentLayoutIcon(
                    scale=0.5,
                    foreground=colors[1],
                ),
                widget.CurrentLayout(
                    foreground=colors[1],
                ),
                widget.Spacer(length=5),
                widget.GroupBox(
                    margin_y=5,
                    margin_x=5,
                    padding_y=0,
                    padding_x=3,
                    borderwidth=2,
                    font="Iosevka Nerd Font",
                    disable_drag=True,
                    highlight_method="line",
                    fontsize=16,
                    active=colors[6],
                    inactive=colors[1],
                    highlight_color=colors[8],
                    this_current_screen_border=colors[7],
                    this_screen_border=colors[4],
                    other_current_screen_border=colors[7],
                    other_screen_border=colors[4],
                ),
                widget.Spacer(length=5),
                widget.Prompt(),
                widget.Spacer(length=5),
                widget.WindowName(
                    max_chars=50,
                ),
                widget.TextBox(
                    text="",
                    foreground=colors[6],
                ),
                widget.Spacer(length=2),
                widget.Volume(
                    limit_max_volume=True,
                    fmt="{}",
                    foreground=colors[6],
                ),
                widget.Spacer(length=10),
                widget.TextBox(
                    text="󰤨 ",
                    foreground=colors[5],
                ),
                widget.Net(
                    format="{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}",
                    foreground=colors[5],
                ),
                widget.Spacer(length=10),
                widget.TextBox(
                    text=" ",
                    foreground=colors[4],
                ),
                widget.CPU(
                    format="{freq_current}GHz {load_percent}%",
                    foreground=colors[4],
                ),
                widget.Spacer(length=10),
                widget.TextBox(
                    text=" ",
                    foreground=colors[6],
                ),
                widget.Memory(
                    format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
                    foreground=colors[6],
                ),
                widget.Spacer(length=10),
                widget.TextBox(
                    text=" ",
                    foreground=colors[9],
                ),
                MouseOverClock(
                    format="%I:%M %p",
                    long_format="%Y-%m-%d %I:%M %p",
                    foreground=colors[9],
                ),
                # widget.Spacer(length=8),
                # widget.TextBox(
                #     text="[X]",
                #     fontsize=15,
                #     foreground="#7797b7",
                #     mouse_callbacks={
                #         "Button1": lazy.run_extension(
                #             extension.CommandSet(
                #                 commands={
                #                     "Oh": "1",
                #                 },
                #             )
                #         )
                #     },
                # ),
                # widget.QuickExit(
                #     fontsize=14,
                #     default_text=" ",
                #     foreground="#bf616a",
                #     countdown_format="[{}]",
                # ),
                widget.Spacer(length=5),
            ],
            30,
            # background="#2a313b",
            # border_width=[0, 0, 0, 0],  # Draw top and bottom borders
            # border_color=[
            #     "#2a313b",
            #     "#2a313b",
            #     "#2a313b",
            #     "#2a313b",
            # ],  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    border_focus=colors[8],
    border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="pcmanfm"),  # GPG key password entry
    ],
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
