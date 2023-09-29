/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */
static int fuzzy = 1;
static int topbar = 1;       /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;     /* -c option; centers dmenu on screen */
static int min_width = 1000; /* minimum width when centered */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"Cousine:size=14", "Symbols Nerd Font:size=16"};
static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = {"#cdd6f4", "#1e1e2e"},
    [SchemeSel] = {"#D8DEE9", "#626880"},
    [SchemeOut] = {"#D8DEE9", "#626880"},
    [SchemeBorder] = {"#cccccc", NULL},
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 20;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 5;
