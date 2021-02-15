/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx  = 0;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 0;        /* snap pixel Default: 32 */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "FiraCode Nerd Font Mono:size=10", "monospace:size=10" };
static const char dmenufont[]       = "FiraCode Nerd Font Mono:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	{ "Firefox",  NULL,       NULL,       1 << 8,       0,           -1 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|M|",      centeredmaster },
	{ ">M>",      centeredfloatingmaster },
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
static const char *dmenucmd[] = { "dmenu_run", "-h", "14", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL, "j4-dmenu-desktop", "--dmenu=dmenu", "--term=alacritty", NULL };
static const char *j4cmd[] = { "j4-dmenu-desktop", "--dmenu=dmenu", "--term=alacritty", NULL };
static const char *termcmd[]  = { "alacritty", "-e", "fish", NULL};

static const char *screenshotcmd[] = {"flameshot", "gui", NULL};

static const char *refreshcmd[] = { "/home/callum/.dwm/refreshbar.sh" };

static const char *backlightup[] = {"xbacklight", "-inc", "10", NULL};
static const char *backlightdown[] = {"xbacklight", "-dec", "10", NULL};
static const char *volumeup[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@", "+2%", NULL};
static const char *volumedown[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@", "-2%", NULL};
static const char *volumemute[] = {"pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL};

static const char *suspend[] = {"lockscreen.sh", NULL};
static const char *shutdown[] = {"systemctl", "poweroff", NULL};
static const char *lockscreen[] = {"slock", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = j4cmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[2]} },
        { MODKEY,                       XK_o,      setlayout,      {.v = &layouts[3]} },
        { MODKEY|ShiftMask,             XK_o,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_f,      togglefullscr,  {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
        { MODKEY,                       XK_minus,  setgaps,        {.i = -1 } },
        { MODKEY,                       XK_equal,  setgaps,        {.i = +1 } },
        { MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = 0  } },
        { MODKEY,                       XK_r,      spawn,          {.v = refreshcmd } },
        { 0,                            XK_Print,  spawn,          {.v = screenshotcmd } },
        { 0,             XF86XK_AudioRaiseVolume,  spawn,          {.v = volumeup } },
        { 0,             XF86XK_AudioLowerVolume,  spawn,          {.v = volumedown } },
        { 0,             XF86XK_AudioMute,         spawn,          {.v = volumemute } },
        { 0,             XF86XK_MonBrightnessUp,   spawn,          {.v = backlightup } },
        { 0,             XF86XK_MonBrightnessDown, spawn,          {.v = backlightdown } },
        { 0,             XF86XK_AudioRaiseVolume,  spawn,          {.v = refreshcmd} },
        { 0,             XF86XK_AudioLowerVolume,  spawn,          {.v = refreshcmd} },
        { 0,             XF86XK_AudioMute,         spawn,          {.v = refreshcmd} },
        { 0,             XF86XK_MonBrightnessUp,   spawn,          {.v = refreshcmd} },
        { 0,             XF86XK_MonBrightnessDown, spawn,          {.v = refreshcmd} },
        { MODKEY,                       XK_s,      spawn,          {.v = suspend } },
        { MODKEY|ShiftMask,             XK_s,      spawn,          {.v = shutdown } },
        { MODKEY|ShiftMask,             XK_l,      spawn,          {.v = lockscreen } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_e,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
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

