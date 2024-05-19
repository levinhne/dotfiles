from libqtile import widget

from .custom.clock import MouseOverClock


def init_widgets(config: dict):
    widgets = [
        widget.Spacer(length=5),
        # widget.Image(
        #     filename="~/.config/qtile/archlinux.svg",
        #     margin=6,
        # ),
        widget.CurrentLayoutIcon(
            scale=0.5,
            foreground=config["foreground"],
        ),
        widget.CurrentLayout(
            foreground=config["foreground"],
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
            active=config["foreground"],
            inactive=config["foreground"],
            highlight_color=config["foreground"],
            this_current_screen_border=[
                config["foreground"],
            ],
            block_highlight_text_color=[
                config["foreground"],
                config["foreground"],
            ],
            # this_screen_border=config["red"],
            # other_current_screen_border=config[7],
            # other_screen_border=config[4],
        ),
        widget.Spacer(length=5),
        widget.Prompt(),
        widget.Spacer(length=5),
        widget.WindowName(
            max_chars=50,
        ),
        widget.TextBox(
            text="",
            foreground=config["foreground"],
        ),
        widget.Spacer(length=2),
        widget.Volume(
            limit_max_volume=True,
            fmt="{}",
            foreground=config["foreground"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text="󰤨 ",
            foreground=config["foreground"],
        ),
        widget.Net(
            format="{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}",
            foreground=config["foreground"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=config["foreground"],
        ),
        widget.CPU(
            format="{freq_current}GHz {load_percent}%",
            foreground=config["foreground"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=config["foreground"],
        ),
        widget.Memory(
            format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
            foreground=config["foreground"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=config["foreground"],
        ),
        MouseOverClock(
            format="%I:%M %p",
            long_format="%Y-%m-%d %I:%M %p",
            foreground=config["foreground"],
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
    ]
    return widgets
