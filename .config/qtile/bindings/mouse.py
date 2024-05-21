# built in libs
from libqtile.config import Click, Drag
from libqtile.lazy import lazy

from .vars import mod


def init_mouse_keys():
    mouse = [
        # other mouse bindings
        Drag(
            [mod],
            "Button1",
            lazy.window.set_position_floating(),
            start=lazy.window.get_position(),
        ),
        Drag(
            [mod],
            "Button3",
            lazy.window.set_size_floating(),
            start=lazy.window.get_size(),
        ),
        Click([mod], "Button2", lazy.window.bring_to_front()),
        # replace modkey with your preferred modifier key
    ]
    return mouse
