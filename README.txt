(TaskLang++ Compile Instructions)

Prerequisites:
1. Flex (Lexical Analyzer)
2. Bison (Parser Generator)
3. GCC (C Compiler)

Steps to Compile and Run:
1. Generate the Lexer:
   flex lexer.l

2. Generate the Parser:
   bison -d parser.y

3. Compile the C files:
   gcc lex.yy.c parser.tab.c -o tasklang

4. Run the program with test cases:

   To test a single task (Valid):
   ./tasklang < ../tests/simple_test.tp

   To test a multi-step workflow (Valid):
   ./tasklang < ../tests/workflow_test.tp

   To test circular dependency detection (Error):
   ./tasklang < ../tests/circular_test.tp

   To test duplicate task names (Error):
   ./tasklang < ../tests/duplicate_name_test.tp

   To test syntax errors (Error):
   ./tasklang < ../tests/syntax_error_test.tp
