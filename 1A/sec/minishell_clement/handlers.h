#ifndef HANDLERS_H
#define HANDLERS_H
#include <signal.h>
#include <sys/wait.h>
#include <errno.h>
#include "list_process.h"
#include "color.h"

extern processList process_list;
extern int proc_avant_plan;

void handler_SIGTSTP(int sig_num);

void handler_SIGINT(int sig_num);

void handler_SIGCHLD(int sig_num);
#endif