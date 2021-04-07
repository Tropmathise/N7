#ifndef UTILS_H
#define UTILS_H
#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include "color.h"
#include "list_process.h"


void setUpRedirections(char* in,char* out);

char* mergeString(char** command);

void printPrompt();
#endif