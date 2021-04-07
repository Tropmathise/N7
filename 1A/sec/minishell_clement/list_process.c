#include "list_process.h"

processList empty_process_list() {
    processList list;
    list.size = 0;
    list.list = NULL;
    return list;
}

void add(processList* process_list, process process_add) {
    process_list->list = realloc(process_list->list,(process_list->size + 1)*sizeof(process*));
    process_list->list[process_list->size] = malloc(sizeof(process));
    process_list->list[process_list->size]->id = process_add.id;
    process_list->list[process_list->size]->pid = process_add.pid;
    process_list->list[process_list->size]->state = process_add.state;
    process_list->list[process_list->size]->foreground = process_add.foreground;
    process_list->list[process_list->size]->command = malloc(strlen(process_add.command) +1);
    strcpy(process_list->list[process_list->size]->command,process_add.command);
    process_list->size++;
}

void delete_id(processList* process_list, int id) {
    for (int i = id + 1; i < process_list->size; i++) {
        process_list->list[i-1] = process_list->list[i];
    }
    process_list->size--;
    free(process_list->list[process_list->size]->command);
    free(process_list->list[process_list->size]);
    process_list->list[process_list->size] = NULL;
    process_list->list = realloc(process_list->list, process_list->size*sizeof(process*));
}

void delete_pid(processList* process_list, pid_t pid) {
    for (int i = 0; i < process_list->size; i++) {
        if (process_list->list[i]->pid == pid) {
            delete_id(process_list,process_list->list[i]->id);
            break;
        }
    }
}

pid_t pid_from_id(processList* process_list,int id) {
    for (int i = 0; i < process_list->size; i++) {
        if (process_list->list[i]->id == id) {
            return process_list->list[i]->pid;
        }
    }
}

int id_from_pid(processList* process_list,pid_t pid) {
    for (int i = 0; i < process_list->size; i++) {
        if (process_list->list[i]->pid == pid) {
            return i;
        }
    }
}

char* printState(int state) {
    if (state == 0) {
        return " ACTIVE  ";
    }
    else
    {
        return "SUSPENDED";
    }
    
}

void freePList(processList* process_list) {
    for (int i = 0; i < process_list->size; i++) {
        free(process_list->list[i]->command);
        process_list->list[i]->command = NULL;
        free(process_list->list[i]);
        process_list->list[i];
    }
    free(process_list->list);
    process_list->list = NULL;
}