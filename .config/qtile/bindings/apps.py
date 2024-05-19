from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile import extension

# Modules and Others Config files
from .vars import (
    browser,
    file_manager,
    mod,
    term,
)


def init_apps_run():
    keys = [
        Key([mod], "Return", lazy.spawn(term)),
        Key([mod], "b", lazy.spawn(browser)),
        Key([mod], "e", lazy.spawn(file_manager)),
        Key(
            ["mod1"],
            "F1",
            lazy.run_extension(
                extension.DmenuRun(
                    dmenu_command="dmenu_run -l 10",
                    dmenu_prompt=" ",
                    dmenu_font="Iosevka Nerd Font:size=10",
                    dmenu_height=26,
                )
            ),
        ),
        Key([mod], "b", lazy.spawn("brave"), desc="Launch brave"),
        Key(
            [
                mod,
                "shift",
            ],
            "x",
            lazy.run_extension(
                extension.CommandSet(
                    dmenu_command="dmenu -l 5",
                    dmenu_prompt=" ",
                    dmenu_font="Iosevka Nerd Font:size=10",
                    dmenu_height=26,
                    commands={
                        "Lock screen": "betterlockscreen -l dim",
                    },
                )
            ),
            desc="",
        ),
    ]

    return keys
