from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
cmd_terminal = "alacritty"
cmd_menu = "rofi -show drun -show-icons"
cmd_web = "google-chrome"
cmd_volumeup = "pactl set-sink-volume @DEFAULT_SINK@ +5%"
cmd_volumedown = "pactl set-sink-volume @DEFAULT_SINK@ -5%"
cmd_volumemute = "pactl set-sink-mute @DEFAULT_SINK@ toggle"
cmd_volumemicmute  = "pactl set-source-mute @DEFAULT_SOURCE@ toggle"
cmd_brigdown = "light -U 5"
cmd_brigup = "light -A 5"
cmd_take_ss_select = "maim --select | xclip -selection clipboard -t image/png"
cmd_take_ss_full = "maim | xclip -selection clipboard -t image/png"
cmd_take_ss_window = "maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png"

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
    Key(["shift"], "Print", lazy.spawn(cmd_take_ss_select), desc="Screenshot selection"),
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
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
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
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "e", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "space", lazy.spawn(cmd_menu), desc="Spawn Rofi menu"),
]

groups = [
    Group("1", label=""),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label=""),
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
                lazy.window.togroup(i.name, switch_group=True),
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
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Cousine Nerd Font",
    fontsize=14,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        bottom=bar.Bar(
           [
                widget.CurrentLayout(),
                widget.GroupBox(),
                # widget.Prompt(),
                widget.TaskList(title_width_method='uniform'),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                # widget.cpu.Cpu(),
                # widget.TextBox("default config", name="default"),
                # widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
                # widget.StatusNotifier(),
                widget.Battery(),
                # widget.battery.Battery(),
                widget.ThermalZone(fmt=' :{}'),
                widget.Volume(fmt=' 墳:{} '),
                widget.Systray(),
                widget.Clock(format="%Y-%m-%d %H:%M"),
                # widget.QuickExit(),
            ],
            27,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
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
follow_mouse_focus = True
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
