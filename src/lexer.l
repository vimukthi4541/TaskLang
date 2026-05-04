%{
#include <stdio.h>
#include <string.h>
#include "parser.tab.h"
%}

%%

"TASK"          { return TASK; }
"RUN"           { return RUN; }
"EVERY"         { return EVERY; }
"DAY"           { return DAY; }
"WEEK"          { return WEEK; }
"ON"            { return ON; }
"AT"            { return AT; }
"AFTER"         { return AFTER; }
"IF"            { return IF; }
"success"       { return SUCCESS; }
"failure"       { return FAILURE; }

[0-9]{2}:[0-9]{2}           { yylval.str = strdup(yytext); return TIME; }
\"[^\"]*\"                  { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z_][a-zA-Z0-9_]* { yylval.str = strdup(yytext); return ID; }

"{"             { return '{'; }
"}"             { return '}'; }

[ \t\n\r]+      ; /* Skip whitespace */
.               { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
