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

%x comentario

%%

 /* Expresiones regulares de comentarios y blancos */
"//".*                         { }
[ \t\r\n]+                     { }
"/*"                           { BEGIN(comentario); }
<comentario>"*/"               { BEGIN(INITIAL); }
<comentario>(.|\n)             { }


 /* Expresiones regulares de tokens */ 


 /* Esta segunda sección contiene las expresiones regulares de tokens */ 
 /* La sustitucción de la macro se hace con las {} */
 /* El código C de después devuelve el código entero del token (los tokens estan simbolizados por enteros)*/
 /* Se desambigua por orden de aparición */
 
"print"                        { return PRINT; }
{letra}({letra}|{digito})*     { return IDEN; }
"+"                            { return MAS; }
"-"                            { return MENOS; }
"*"                            { return POR;   }
"/"                            { return DIV;   }
"("                            { return PARI;  }
")"                            { return PARD;  }
","                            { return COMA;}
";"                            { return PYC;   }
{digito}+                      { return ENTERO;}
"="                            { return IGUAL; }
\"([^"\n]|\\\")*\"             { return STRING; }
\"([^"\n]|\\\")*               { error_lexico(); }
{panico}                       { error_lexico(); }

%%


void error_lexico()
{
    printf("Error lexico en la linea %d: %s\n", 
            yylineno, yytext);
}