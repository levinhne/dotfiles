from libqtile.layout import max, xmonad, tree, columns


# Define layouts
def init_layouts(layout_config: dict):
    max_layout_config = layout_config.copy()
    max_layout_config.update({"border_width": 0})
    layouts = [
        max.Max(**max_layout_config),
        xmonad.MonadWide(**layout_config),
        xmonad.MonadTall(**layout_config),
    ]
    return layouts
