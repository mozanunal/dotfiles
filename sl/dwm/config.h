/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>
#include "selfrestart.c"

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;    /* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static const int showsystray        = 1;        /* 0 means no systray */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Cousine:size=12", "Symbols Nerd Font:size=14" };
static const char dmenufont[]       = "Cousine:size=14";
#define ICONSIZE 16   /* icon size */
#define ICONSPACING 5 /* space between icon and title */

static char normbgcolor[] = "#1e1e2e";
static char normbordercolor[] = "#3B4252";
static char normfgcolor[] = "#cdd6f4";
static char selfgcolor[] = "#D8DEE9";
static char selbordercolor[] = "#74c7ec";
static char selbgcolor[] = "#626880";
static char const *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor},
    // [SchemeHid] = {selbgcolor, normbgcolor, selbordercolor},
};

/* tagging */
static const char *tags[] = { "", "", "", "", "", "6", "7", "8", "9" };


static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
	{ NULL,       NULL,       "stfloat",  0,            1,           -1 },


};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "﩯 ",      tile },    /* first entry is default */
	{ " ",      NULL },    /* no layout function means floating behavior */
	{ " ",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
// 	"-m", dmenumon, 
static const char *dmenucmd[] = { "dmenu_run_i", "-f", "-p", "Run:","-l", "20", NULL };
static const char *roficmd[] = { "rofi", "-show", "drun", "-show-icons", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *webcmd[]  = { "google-chrome", NULL };
static const char volumeup[]  = "pactl set-sink-volume @DEFAULT_SINK@ +5% && killall -SIGUSR1 slstatus";
static const char volumedown[]  = "pactl set-sink-volume @DEFAULT_SINK@ -5% && killall -SIGUSR1 slstatus";
static const char volumemute[]  = "pactl set-sink-mute @DEFAULT_SINK@ toggle && killall -SIGUSR1 slstatus";
static const char volumemicmute[]  = "pactl set-source-mute @DEFAULT_SOURCE@ toggle && killall -SIGUSR1 slstatus";
static const char brigdown[] = "light -U 5 && killall -SIGUSR1 slstatus";
static const char brigup[]  = "light -A 5 && killall -SIGUSR1 slstatus";
static const char take_ss_select[]  = "maim --select | xclip -selection clipboard -t image/png";
static const char take_ss_full[]  = "maim | xclip -selection clipboard -t image/png";
static const char take_ss_window[]  = "maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png";
static const char scratchpadname[] = "scratchpad";
static const char *scratchpadcmd[] = { "st", "-t", scratchpadname, "-g", "100x30", NULL };

static const Key keys[] = {
	// Volume
	{ 0, XF86XK_AudioRaiseVolume,    spawn, SHCMD(volumeup)}, 
	{ 0, XF86XK_AudioLowerVolume,    spawn, SHCMD(volumedown)}, 
	{ 0, XF86XK_AudioMute,           spawn, SHCMD(volumemute)}, 
	{ 0, XF86XK_AudioMicMute,        spawn, SHCMD(volumemicmute)}, 
	{ 0, XF86XK_MonBrightnessUp,     spawn, SHCMD(brigup)}, 
	{ 0, XF86XK_MonBrightnessDown,   spawn, SHCMD(brigdown)}, 
	{ 0, XK_Print,                   spawn, SHCMD(take_ss_full)},
	{ ShiftMask, XK_Print,           spawn, SHCMD(take_ss_select)},
	{ ControlMask, XK_Print,         spawn, SHCMD(take_ss_window)},
	{ MODKEY, XK_x,                  togglescratch,  {.v = scratchpadcmd } },
	{ MODKEY, XK_r,                  spawn, {.v = dmenucmd} },
	{ MODKEY, XK_space,              spawn, {.v = roficmd} },
	{ MODKEY, XK_Return,             spawn, {.v = termcmd} },
	{ MODKEY|ShiftMask, XK_Return,   spawn, {.v = webcmd} },
	{ MODKEY|ShiftMask, XK_u,        spawn, SHCMD("moz_emoji") },
	{ MODKEY|ShiftMask, XK_p,        spawn, SHCMD("moz_power") },
	{ MODKEY, XK_c,                  spawn, SHCMD("passmenu") },
	{ MODKEY, XK_e,                  spawn, SHCMD("pcmanfm") },
	{ MODKEY, XK_b,                  togglebar, {0} },
	{ MODKEY, XK_Down,               focusstack, {.i = +1 } },
	{ MODKEY, XK_Up,                 focusstack, {.i = -1 } }, 
	{ MODKEY, XK_Right,              focusstack, {.i = 0} },
	{ MODKEY, XK_Left,               focusmaster, {0} },
	{ MODKEY, XK_j,                  focusstack, {.i = +1 } },
	{ MODKEY, XK_k,                  focusstack, {.i = -1 } },
	{ MODKEY, XK_i,                  incnmaster, {.i = +1 } },
	{ MODKEY, XK_d,                  incnmaster, {.i = -1 } },
	{ MODKEY, XK_h,                  setmfact, {.f = -0.05} },
	{ MODKEY, XK_minus,              setmfact, {.f = -0.05} },
	{ MODKEY, XK_l,                  setmfact, {.f = +0.05} },
	{ MODKEY, XK_equal,              setmfact, {.f = +0.05} },
	{ MODKEY, XK_z,                  zoom, {0} },
	{ MODKEY|ShiftMask, XK_Left,     zoom, {0} },
	{ MODKEY|ShiftMask, XK_Right,    zoom, {0} },
	{ MODKEY, XK_Tab,                view, {0} },
	{ MODKEY|ShiftMask, XK_q,        killclient, {0} },
	{ MODKEY, XK_o,                  setlayout, {.v = &layouts[0]} },
	{ MODKEY, XK_t,                  setlayout, {.v = &layouts[0]} },
	{ MODKEY, XK_s,                  setlayout, {.v = &layouts[2]} },
	{ MODKEY, XK_f,                  togglefloating, {0} },
	{ MODKEY, XK_0,                  view, {.ui = ~0 } },
	{ MODKEY|ShiftMask, XK_0,        tag, {.ui = ~0 } },
	{ MODKEY, XK_comma,              focusmon, {.i = -1 } },
	{ MODKEY, XK_m,                  focusmon, {.i = -1 } },
	{ MODKEY, XK_period,             focusmon, {.i = +1 } },
	{ MODKEY|ShiftMask, XK_comma,    tagmon, {.i = -1 } },
	{ MODKEY|ShiftMask, XK_period,   tagmon, {.i = +1 } },
	{ MODKEY|ShiftMask, XK_m,        tagmon, {.i = +1 } },
	{ MODKEY|ShiftMask, XK_r,        self_restart,   {0} },
	{ MODKEY|ShiftMask, XK_e,        quit, {0} },
	TAGKEYS(XK_1,0)
	TAGKEYS(XK_2,1)
	TAGKEYS(XK_3,2)
	TAGKEYS(XK_4,3)
	TAGKEYS(XK_5,4)
	TAGKEYS(XK_6,5)
	TAGKEYS(XK_7,6)
	TAGKEYS(XK_8,7)
	TAGKEYS(XK_9,8)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

static const char *const autostart[] = {
	"feh", "--bg-scale", "~/dotfiles/dev/data/tetris.png", NULL,
	"slstatus", NULL,
	NULL /* terminate */
};

