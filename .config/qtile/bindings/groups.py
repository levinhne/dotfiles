from libqtile.config import Key
from libqtile.lazy import lazy

# Modules and Others Config files
from groups.names import init_names
from .vars import mod


def go_to_group(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.groups_map[name].toscreen()
            return

        if name in "123":
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner


def go_to_group_and_move_window(name: str):
    def _inner(qtile):
        if len(qtile.screens) == 1:
            qtile.current_window.togroup(name, switch_group=True)
            return

        if name in "123":
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(0)
            qtile.groups_map[name].toscreen()
        else:
            qtile.current_window.togroup(name, switch_group=False)
            qtile.focus_screen(1)
            qtile.groups_map[name].toscreen()

    return _inner


def init_groups_keys():
    keys = []
    for i, (name, kwargs) in enumerate(init_names(), 1):
        keys.append(
            Key([mod], str(i), lazy.function(go_to_group(name)))
        )  # Switch to another group
        keys.append(
            Key(
                [mod, "shift"], str(i), lazy.function(go_to_group_and_move_window(name))
            )
        )  # Send current window to another group
    return keys
