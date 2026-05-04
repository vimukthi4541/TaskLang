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

4. Run the program with an input file:
   ./tasklang < input.txt
