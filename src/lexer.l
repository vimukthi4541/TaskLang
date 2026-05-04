%{
#include "parser.tab.h"
#include <string.h>
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

[0-9]{2}:[0-9]{2}           { yylval.str = strdup(yytext); return TIME; }
\"[^\"]*\"                  { yylval.str = strdup(yytext); return STRING; }
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return ID; }

"{"             { return '{'; }
"}"             { return '}'; }
[ \t\n]         ; 
.               { printf("Unknown character: %s\n", yytext); }

%%

int yywrap() { return 1; }
