#include <stdio.h> 
#include <stdlib.h>
extern int yylex();
extern char *yytext;
extern FILE *yyin;

/*
    //> Sirve para la entrega final de la práctica. Solo hay que añadir lo de gramatica
*/

int main(int argc, char *argv[]){
    if (argc != 2)
    {
        printf("Uso: %s fichero.txt\n", argv[0]);
        exit(1);
    }

    yyin = fopen(argv[1], "r");
    if (yyin == NULL)
    {
        printf("No se puede abrir %s\n", argv[1]);
        exit(2);
    }
    int token;
    while ((token = yylex())!= 0){
        printf("Token %d: %s\n", token, yytext);
    }
        
}


//>      <<EOF>> : REGEX para detectar el final del archivo



