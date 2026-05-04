%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int yylex();
void yyerror(const char *s);

typedef struct {
    char name[50];
    char dependency[50];
} Task;

Task task_list_arr[100];
int task_count = 0;
int adj[100][100];
int visited[100];
int stack[100];

int find_task(char *name) {
    for (int i = 0; i < task_count; i++) {
        if (strcmp(task_list_arr[i].name, name) == 0) return i;
    }
    return -1;
}

int has_cycle(int v) {
    visited[v] = 1;
    stack[v] = 1;
    for (int i = 0; i < task_count; i++) {
        if (adj[v][i]) {
            if (stack[i]) return 1;
            if (!visited[i] && has_cycle(i)) return 1;
        }
    }
    stack[v] = 0;
    return 0;
}
%}

%union { char *str; }

%token TASK RUN EVERY DAY WEEK ON AT AFTER IF SUCCESS FAILURE
%token <str> ID STRING TIME

%%

program: task_list {
    for (int i = 0; i < task_count; i++) {
        if (strlen(task_list_arr[i].dependency) > 0) {
            int dep_idx = find_task(task_list_arr[i].dependency);
            if (dep_idx != -1) adj[i][dep_idx] = 1;
        }
    }
    for (int i = 0; i < task_count; i++) {
        if (has_cycle(i)) {
            printf("[ERROR] Circular dependency detected!\n");
            exit(1);
        }
    }
    printf("--- EXECUTION COMPLETE ---\n");
};

task_list: task_definition | task_definition task_list ;

task_definition: TASK ID '{' run_stmt schedule_stmt '}' {
    if (find_task($2) != -1) {
        printf("[ERROR] Duplicate task name detected: %s\n", $2);
        exit(1);
    }
    strcpy(task_list_arr[task_count].name, $2);
    printf("Executing Task: %s\n", $2);
    task_count++;
};

run_stmt: RUN STRING { printf("Script: %s\n", $2); } ;

schedule_stmt: time_sched | dep_sched ;

time_sched: EVERY DAY AT TIME { printf("Schedule: EVERY DAY AT %s\n", $4); }
          | EVERY WEEK ON ID AT TIME { printf("Schedule: EVERY WEEK ON %s AT %s\n", $4, $6); }
          | AT TIME { printf("Schedule: AT %s\n", $2); } ;

dep_sched: AFTER ID optional_condition {
    strcpy(task_list_arr[task_count].dependency, $2);
    printf("Depends on: %s\n", $2);
};

optional_condition: IF SUCCESS { printf("Condition: success\n"); } 
                  | IF FAILURE { printf("Condition: failure\n"); }
                  | ;

%%

void yyerror(const char *s) { fprintf(stderr, "Error: %s\n", s); }

int main() {
    printf("Parsing TaskLang++ input...\n");
    printf("EXECUTION START\n");
    return yyparse();
}
