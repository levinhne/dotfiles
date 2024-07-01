from libqtile.config import Key
from libqtile.lazy import lazy
from libqtile import extension

# Modules and Others Config files
from .vars import (
    browser,
    file_manager,
    mod,
    term,
    dmenu,
    dmenu_run,
    maim,
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
                    dmenu_command=dmenu_run,
                    dmenu_prompt=" ",
                    dmenu_font="Iosevka Nerd Font:size=10",
                )
            ),
        ),
        Key(
            [
                mod,
                "shift",
            ],
            "x",
            lazy.run_extension(
                extension.CommandSet(
                    dmenu_command=dmenu,
                    dmenu_prompt=" ",
                    dmenu_font="Iosevka Nerd Font:size=10",
                    commands={
                        "Lock screen": "betterlockscreen -l dim",
                    },
                )
            ),
            desc="",
        ),
        Key(
            [
                mod,
                "shift",
            ],
            "x",
            lazy.run_extension(
                extension.CommandSet(
                    dmenu_command=dmenu,
                    dmenu_prompt=" ",
                    dmenu_font="Iosevka Nerd Font:size=10",
                    commands={
                        "Lock screen": "betterlockscreen -l dim",
                    },
                )
            ),
            desc="",
        ),
        Key([mod], "s", lazy.spawn(maim, shell=True))
    ]

    return keys
