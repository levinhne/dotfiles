from libqtile import widget

from .custom.clock import MouseOverClock


def func_test():
    return "ok"


def init_widgets(config: dict):
    widgets = [
        widget.Spacer(length=5),
        # widget.Image(
        #     filename="~/.config/qtile/archlinux.svg",
        #     margin=6,
        # ),
        widget.CurrentLayoutIcon(
            scale=0.5,
            foreground=config["bar_text_color"],
        ),
        widget.CurrentLayout(
            foreground=config["bar_text_color"],
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
            active=config["bar_group_box_active"],
            inactive=config["bar_group_box_inactive"],
            highlight_color=config["background"],
            this_current_screen_border=config["comment"],
            block_highlight_text_color=config["bar_group_box_active"],
        ),
        widget.Spacer(length=5),
        widget.Prompt(),
        widget.Spacer(length=5),
        widget.WindowName(
            max_chars=50,
            foreground=config["bar_text_color"],
        ),
        widget.GenPollText(
            func=func_test,
            update_interval=5,
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text="",
            foreground=config["bar_text_color"],
        ),
        widget.Spacer(length=2),
        widget.Volume(
            limit_max_volume=True,
            fmt="{}",
            foreground=config["bar_text_color"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text="󰤨 ",
            foreground=config["bar_text_color"],
        ),
        widget.Net(
            format="{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}",
            foreground=config["bar_text_color"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=config["bar_text_color"],
        ),
        widget.CPU(
            format="{freq_current}GHz {load_percent}%",
            foreground=config["bar_text_color"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=config["bar_text_color"],
        ),
        widget.Memory(
            format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
            foreground=config["bar_text_color"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=config["bar_text_color"],
        ),
        MouseOverClock(
            format="%I:%M %p",
            long_format="%Y-%m-%d %I:%M %p",
            foreground=config["bar_text_color"],
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