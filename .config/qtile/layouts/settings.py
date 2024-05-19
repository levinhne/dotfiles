from libqtile.layout import floating, max


# Define layouts
def init_layouts(layout_confing: dict):
    max_layout_config = layout_confing
    max_layout_config["border_width"] = 0
    layouts = [
        floating.Floating(**layout_confing),
        max.Max(**max_layout_config),
    ]
    return layouts
