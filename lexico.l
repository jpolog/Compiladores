/* Código literal y macros de ER */

%{
 #include <stdio.h>
 #include "lexico.h"
 void error_lexico();
%}

digito [0-9]
letra  [a-zA-Z]
panico [^ \n\s\ta-zA-Z_0-9+\-*/();=]+

%option yylineno

%%

 /* Expresiones regulares de comentarios y blancos */
"//".*                         { }
[ \t\r\n]+                     { }


 /* Esta segunda sección contiene las expresiones regulares de tokens */ 
 /* La sustitucción de la macro se hace con las {} */
 /* El código C de después devuelve el código entero del token (los tokens estan simbolizados por enteros)*/
 /* Se desambigua (porfis RAE añade esto al diccionario) por orden de aparición */
 
"print"                        { return PRINT; }
{letra}({letra}|{digito})*     { return IDEN; }
"+"                            { return MAS; }
"-"                            { return MENOS; }
"*"                            { return POR;   }
"/"                            { return DIV;   }
"("                            { return PARI;  }
")"                            { return PARD;  }
";"                            { return PYC;   }
{digito}+                      { return ENTERO;}
"="                            { return IGUAL; }
{panico}                       { error_lexico(); }

%%

int main(int argc, char *argv[]){
    
    int token;
    while ( (token = yylex()) != 0){
        printf("Token %d: %s\n", token, yytext);
    }
}


void error_lexico()
{
    printf("Error lexico en la linea %d: %s\n", 
            yylineno, yytext);
}