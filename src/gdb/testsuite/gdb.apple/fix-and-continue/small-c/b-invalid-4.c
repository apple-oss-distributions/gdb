#include <stdio.h>
#include <math.h>

int global_var = (VERSION * 10);
static int static_var = 5;
static int static_bss_int;
int bss_int;

static double a;   /* ERRR: I added a new static variable. */
