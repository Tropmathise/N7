#ifndef LIST_PROCESS_H
#define LIST_PROCESS_H
#include <stdlib.h>
#include <assert.h>
#include <stdio.h>
#include <string.h>
#include <stdbool.h>

enum p_state {ACTIVE, SUSPENDED};
typedef enum p_state p_state;

struct process {
    int id;
    pid_t pid;
    p_state state;
    bool foreground;
    char* command;
}; typedef struct process process;

struct processList {
    int size;
    process** list;
}; typedef struct processList processList;

processList empty_process_list();

void add(processList* process_list, process process_add);

void delete_id(processList* process_list, int id);

void delete_pid(processList* process_list, pid_t pid);

pid_t pid_from_id(processList* process_list,int id);

int id_from_pid(processList* process_list,pid_t pid);

char* printState(int state);

void freePList(processList* process_list);
#endif
