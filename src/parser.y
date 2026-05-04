%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char *s);
%}

%union { char *str; }

%token TASK RUN EVERY DAY WEEK ON AT AFTER IF SUCCESS
%token <str> ID STRING TIME

%%

program: task_list { printf("--- EXECUTION COMPLETE ---\n"); } ;

task_list: task_definition | task_definition task_list ;

task_definition: TASK ID '{' run_stmt schedule_stmt '}' { printf("Executing Task: %s\n", $2); } ;

run_stmt: RUN STRING { printf("Script: %s\n", $2); } ;

schedule_stmt: time_sched | dep_sched ;

time_sched: EVERY DAY AT TIME { printf("Schedule: EVERY DAY AT %s\n", $4); }
          | AT TIME { printf("Schedule: AT %s\n", $2); } ;

dep_sched: AFTER ID optional_condition { printf("Depends on: %s\n", $2); } ;

optional_condition: IF SUCCESS { printf("Condition: success\n"); } | ;

%%

void yyerror(const char *s) { fprintf(stderr, "Error: %s\n", s); }

int main() {
    printf("Parsing TaskLang++ input...\n");
    printf("EXECUTION START\n");
    return yyparse();
} 
