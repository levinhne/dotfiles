from libqtile import widget

from .custom.clock import MouseOverClock


def init_widgets(config: dict):
    colors = config["colors"]
    widgets = [
        widget.Spacer(length=5),
        # widget.Image(
        #     filename="~/.config/qtile/archlinux.svg",
        #     margin=6,
        # ),
        widget.CurrentLayoutIcon(
            scale=0.5,
            foreground=colors["base00"],
        ),
        widget.CurrentLayout(
            foreground=colors["base05"],
        ),
        widget.Spacer(length=5),
        widget.GroupBox(
            margin_y=5,
            padding_y=0,
            padding_x=3,
            borderwidth=0,
            disable_drag=True,
            highlight_method="line",
            fontsize=15,
            active=colors["base03"],
            inactive=colors["base01"],
            highlight_color=colors["base00"],
            this_current_screen_border=colors["base00"],
            block_highlight_text_color=colors["base09"],
        ),
        widget.Spacer(length=5),
        widget.Prompt(),
        widget.Spacer(length=5),
        widget.WindowName(
            max_chars=50,
            foreground=colors["base05"],
        ),
        widget.TextBox(
            text="",
            foreground=colors["base05"],
        ),
        widget.Spacer(length=2),
        widget.Volume(
            limit_max_volume=True,
            fmt="{}",
            foreground=colors["base05"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text="󰤨 ",
            foreground=colors["base05"],
        ),
        widget.Net(
            format="{down:.0f}{down_suffix} ↓↑ {up:.0f}{up_suffix}",
            foreground=colors["base05"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=colors["base05"],
        ),
        widget.CPU(
            format="{freq_current}GHz {load_percent}%",
            foreground=colors["base05"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=colors["base05"],
        ),
        widget.Memory(
            format="{MemUsed:.0f}{mm}/{MemTotal:.0f}{mm}",
            foreground=colors["base05"],
        ),
        widget.Spacer(length=10),
        widget.TextBox(
            text=" ",
            foreground=colors["base05"],
        ),
        MouseOverClock(
            format="%I:%M %p",
            long_format="%Y-%m-%d %I:%M %p",
            foreground=colors["base05"],
        ),
        widget.Spacer(length=5),
    ]
    return widgets
