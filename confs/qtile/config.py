from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

def bash_cmd(cmd):
    return f"""bash -c '{cmd}' """


mod = "mod4"
cmd_terminal = "alacritty"
cmd_menu = "rofi -show drun -show-icons"
cmd_web = "google-chrome"
cmd_volumeup = "pactl set-sink-volume @DEFAULT_SINK@ +5%"
cmd_volumedown = "pactl set-sink-volume @DEFAULT_SINK@ -5%"
cmd_volumemute = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
cmd_volumemicmute = "pactl set-source-mute @DEFAULT_SOURCE@ toggle"
cmd_brigdown = "light -U 5"
cmd_brigup = "light -A 5"
cmd_take_ss_select = bash_cmd("maim --select | xclip -selection clipboard -t image/png")
cmd_take_ss_full = bash_cmd("maim | xclip -selection clipboard -t image/png")
cmd_take_ss_window = bash_cmd(
    "maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png"
)

keys = [
    # My apps
    Key([mod, "shift"], "u", lazy.spawn("moz_emoji"), desc="Emoji selector"),
    Key([mod, "shift"], "p", lazy.spawn("moz_power"), desc="Power Menu"),
    Key([mod, "shift"], "Return", lazy.spawn("google-chrome"), desc="Web Browser"),
    Key([mod], "c", lazy.spawn("passmenu"), desc="Passmenu"),
    Key([mod], "e", lazy.spawn("pcmanfm"), desc="File Manager"),
    # Tools
    Key([], "XF86MonBrightnessUp", lazy.spawn(cmd_brigup), desc="Brightness up"),
    Key([], "XF86MonBrightnessDown", lazy.spawn(cmd_brigdown), desc="Brightness down"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn(cmd_volumeup), desc="Volume up"),
    Key([], "XF86AudioLowerVolume", lazy.spawn(cmd_volumedown), desc="Volume down"),
    Key([], "XF86AudioMute", lazy.spawn(cmd_volumemute), desc="Volume mute"),
    Key([], "XF86AudioMicMute", lazy.spawn(cmd_volumemicmute), desc="Volume mute"),
    Key(
        [mod, "shift"], "s", lazy.spawn(cmd_take_ss_select), desc="Screenshot selection"
    ),
    Key(
        ["shift"], "Print", lazy.spawn(cmd_take_ss_select), desc="Screenshot selection"
    ),
    Key([], "Print", lazy.spawn(cmd_take_ss_full), desc="Screenshot full screen"),
    Key(["control"], "Print", lazy.spawn(cmd_take_ss_window), desc="Screenshot window"),
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key(["mod1"], "tab", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        ["mod1", "shift"],
        "tab",
        lazy.layout.prev(),
        desc="Move window focus to other window",
    ),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod], "Left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod], "Right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod], "Down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod], "Up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "r", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    Key([mod], "Return", lazy.spawn(cmd_terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "o", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "s", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "r", lazy.restart(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn(cmd_menu), desc="Spawn Rofi menu"),
]

groups = [
    Group("1", label=""),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label=""),
    Group("6", label=""),
    Group("7", label=""),
    Group("8", label=""),
    Group("9", label=""),
]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=False),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    layout.MonadTall(),
    layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

wallpaper = "/usr/share/backgrounds/moz/tetris.png"
wallpaper_mode = "fill"

widget_defaults = dict(
    font="Cousine Nerd Font",
    fontsize=16,
    padding=2,
)
extension_defaults = widget_defaults.copy()

widgets_screen_1 = [
    widget.CurrentLayoutIcon(),
    widget.GroupBox(highlight_method="line", fontsize=18, disable_drag=True),
    # widget.Prompt(),
    widget.TaskList(title_width_method="uniform"),
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    widget.Battery(),
    widget.ThermalZone(fmt=" :{}"),
    widget.Volume(fmt=" 墳:{} "),
    widget.Systray(),
    widget.Clock(format="%Y-%m-%d %H:%M"),
]

widgets_screen_2 = [
    widget.CurrentLayoutIcon(),
    widget.GroupBox(highlight_method="line", fontsize=18, disable_drag=True),
    # widget.Prompt(),
    widget.TaskList(title_width_method="uniform"),
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    widget.Battery(),
    widget.ThermalZone(fmt=" :{}"),
    widget.Volume(fmt=" 墳:{} "),
    widget.Clock(format="%Y-%m-%d %H:%M"),
]

screens = [
    Screen(
        bottom=bar.Bar(widgets_screen_1, 27),
        wallpaper=wallpaper,
        wallpaper_mode=wallpaper_mode,
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        bottom=bar.Bar(widgets_screen_2, 27),
        wallpaper=wallpaper,
        wallpaper_mode=wallpaper_mode,
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True
auto_minimize = True
wl_input_rules = None
wmname = "LG3D"
