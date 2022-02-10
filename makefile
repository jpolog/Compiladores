# Instrucciones de compilación de lexico

lexico : lex.yy.c main.c
	gcc main.c lex.yy.c -lfl -o lexico

lex.yy.c : lexico.l lexico.h
	flex lexico.l

clean : 
	rm -f lexico lex.yy.c

run : lexico miniC.txt
	./lexico miniC.txt