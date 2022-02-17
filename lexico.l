/* Código literal y macros de ER */

%{
 #include <stdio.h>
 #include "lexico.h"
 #define MAXNUM 2147483648
 void error_lexico();
 void error_comment();
 int is_rango(char* s);
 int yylinecomm;
%}

digito [0-9]
letra  [a-zA-Z]
panico [^ \n\s\ta-zA-Z_0-9+\-*/();=,{}]+

%option yylineno

%x comentario

%%

 /* Expresiones regulares de comentarios y blancos */
"//".*                         { }
[ \t\r\n]+                     { }
"/*"                           { BEGIN(comentario);
                                    yylinecomm = yylineno;
                                 }
<comentario>"*/"               { BEGIN(INITIAL); }
<comentario>(.|\n)             { }
<comentario><<EOF>>            { 
                                    error_comment();
                                    return 0 ; }


 /* Expresiones regulares de tokens */ 


 /* Esta segunda sección contiene las expresiones regulares de tokens */ 
 /* La sustitucción de la macro se hace con las {} */
 /* El código C de después devuelve el código entero del token (los tokens estan simbolizados por enteros)*/
 /* Se desambigua por orden de aparición */
 
"void"                                { return VOID;    }
"var"                                 { return VAR;     }
"const"                               { return CONST;   }
"if"                                  { return IF;      }
"else"                                { return ELSE;    }
"while"                               { return WHILE;   }
"print"                               { return PRINT;   }
"read"                                { return READ;    }
{letra}({letra}|{digito}|_){0,15}     { return IDEN;    }
"+"                                   { return MAS;     }
"-"                                   { return MENOS;   }
"*"                                   { return POR;     }
"/"                                   { return DIV;     }
"("                                   { return PARI;    }
")"                                   { return PARD;    }
","                                   { return COMA;    }
";"                                   { return PYC;     }
{digito}+                             { if (is_rango(yytext))
                                            return ENTERO;
                                        else
                                            error_lexico();  }
"="                                   { return IGUAL;   }
"{"                                   { return LLAVEI;  }
"}"                                   { return LLAVED;  }
\"([^"\n]|\\\")*\"                    { return STRING;  }
\"([^"\n]|\\\")*                      { error_lexico(); }
{panico}                              { error_lexico(); }

%%


void error_lexico()
{
    printf("Error lexico en la linea %d: %s\n", 
            yylineno, yytext);
}

void error_comment()
{
    printf("Error lexico en la linea %d: Comentario sin cerrar\n", yylinecomm);
}

int is_rango(char* s){
    long l = atol(s);
    return (l < MAXNUM) && (l > -MAXNUM);
}