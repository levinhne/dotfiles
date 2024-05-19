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
import colors

from layouts.settings import init_layouts
from widgets.top import init_widgets

from bindings.cores import init_keys
from bindings.groups import init_groups_keys, init_groups_keys
from bindings.apps import init_apps_run
from bindings.mouse import init_mouse_keys

from themes.dracula import Dracula

colors2 = Dracula()

# colors
colors = colors.Catppuccin

BAR_BACKGROUND_COLOR = "surface0"
BAR_TEXT_COLOR = "text"
BAR_GROUP_BOX_ACTIVE_COLOR = "lavender"
BAR_GROUP_BOX_INACTIVE_COLOR = "overlay2"
BAR_GROUP_BOX_HIGHLIGHT_COLOR = "surface2"
BAR_VOLUME_ICON_COLOR = "mauve"
BAR_WIFI_ICON_COLOR = "mauve"
BAR_CPU_ICON_COLOR = "mauve"
BAR_MEM_ICON_COLOR = "mauve"
BAR_CLOCK_ICON_COLOR = "darkblue"

ACTIVE_BODER_COLOR = "lavender"
INACTIVE_BORDER_COLOR = "overlay0"


# groups = []
# group_names = ["1", "2", "3", "4", "5", "6", "7", "8"]
# group_labels = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII"]
# # group_labels = ["DEV", "WWW", "SYS", "DOC", "VBOX", "CHAT", "MUS", "VID", "GFX",]
# # group_labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9",]
# # group_labels = ["", "", "", "", "", "", "", "", "",]
#
#
# group_layouts = [
#     "max",
#     "max",
#     "max",
#     "max",
#     "max",
#     "max",
#     "max",
#     "max",
# ]
#
# for i in range(len(group_names)):
#     groups.append(
#         Group(
#             name=group_names[i],
#             layout=group_layouts[i].lower(),
#             label=group_labels[i],
#         )
#     )
#
# for i in groups:
#     keys.extend(
#         [
#             # mod1 + letter of group = switch to group
#             Key(
#                 [mod],
#                 i.name,
#                 lazy.group[i.name].toscreen(),
#                 desc="Switch to group {}".format(i.name),
#             ),
#             # mod1 + shift + letter of group = move focused window to group
#             Key(
#                 [mod, "shift"],
#                 i.name,
#                 lazy.window.togroup(i.name, switch_group=False),
#                 desc="Move focused window to group {}".format(i.name),
#             ),
#         ]
#     )
#
layout_theme = dict(
    margin=5,
    border_width=2,
    border_focus=colors2["pink"],
    border_normal=colors2["cyan"],
)


layouts = init_layouts(layout_theme)
keys = init_keys()
groups = init_groups_keys()
keys.extend(groups)
apps = init_apps_run()
keys.extend(apps)

widget_defaults = dict(
    font="Iosevka Nerd Font SemiBold",
    fontsize=14,
    padding=3,
    background=colors2["background"],
)
extension_defaults = widget_defaults.copy()
widgets_theme = widget_defaults.copy()
widgets_theme.update(colors2)


def init_bar():
    return bar.Bar(
        init_widgets(widgets_theme),
        30,
    )


screens = [
    Screen(
        top=init_bar(),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = init_mouse_keys()

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
# floating_layout = layout.Floating(
#     border_focus=colors2["pink"],
#     border_normal=colors[INACTIVE_BORDER_COLOR],
#     border_width=2,
#     float_rules=[
#         # Run the utility of `xprop` to see the wm class and name of an X client.
#         *layout.Floating.default_float_rules,
#         Match(wm_class="confirmreset"),  # gitk
#         Match(wm_class="makebranch"),  # gitk
#         Match(wm_class="maketag"),  # gitk
#         Match(wm_class="ssh-askpass"),  # ssh-askpass
#         Match(wm_class="Pcmanfm"),
#         Match(title="branchdialog"),  # gitk
#         Match(title="pinentry"),  # GPG key password entry
#     ],
# )
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
