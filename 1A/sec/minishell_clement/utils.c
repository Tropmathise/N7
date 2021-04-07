#include "utils.h"

void setUpRedirections(char* in,char* out) {
    if (in != NULL && access(in,R_OK) != -1) {
        freopen(in,"r",stdin);
    }
    if (out != NULL && (access(out,W_OK) != -1 || errno == ENOENT)) {
        freopen(out,"w",stdout);
    }
}

char* mergeString(char** command) {
    char* returnedChar = NULL;
    char* testRealloc = NULL;
    int i = 0;
    int size = 0;
    while (command[i] != NULL) {
        testRealloc = realloc(returnedChar, (size + strlen(command[i]) + 2) * sizeof(char) );
        if (testRealloc != NULL) {
            returnedChar = testRealloc;

            if (i == 0) {
                memset(returnedChar,0,strlen(command[i]));
            }

            strcat(returnedChar,command[i]);
            strcat(returnedChar," ");
            size += strlen(command[i]) + 1;
            i++;
        }
        else
        {
            free(testRealloc);
            exit(EXIT_FAILURE);
        }
        
    }
    testRealloc = NULL;
    free(testRealloc);
    return returnedChar;
}

void printPrompt() {
    char* fullDirName = getcwd(NULL,0);
    char* dirName = strrchr(fullDirName,'/');
    dirName++;
    green();
    printf("[%s@minishell",getenv("USER"));
    white();
    printf(" %s",dirName);
    green();
    printf("]$ ");
    resetColor();
    free(fullDirName);
    fullDirName = NULL;
}