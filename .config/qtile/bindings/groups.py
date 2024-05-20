from libqtile.config import Key
from libqtile.lazy import lazy

# Modules and Others Config files
from groups.names import init_names
from .vars import mod


def init_groups_keys():
    keys = []
    for i, (name, kwargs) in enumerate(init_names(), 1):
        keys.append(
            Key([mod], str(i), lazy.group[name].toscreen())
        )  # Switch to another group
        keys.append(
            Key([mod, "shift"], str(i), lazy.window.togroup(name))
        )  # Send current window to another group
    return keys