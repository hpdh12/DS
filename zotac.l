/* definitions */
%{
#include <stdio.h>
#include <stdlib.h>
#include "miniC.tab.h"
%}

num [0-9]
alpha [A-Za-z]

%%
 /* Rules */
[ \t]	;
[ \n]	{ yylineno = yylineno + 1; }
"int" {
	printf("yylineno = %d, token name INT, token is \"%s\"\n",yylineno,yytext);
	return INT;
}
"float" {
	printf("yylineno = %d, token name FLOAT, token is \"%s\"\n",yylineno,yytext);
	return FLOAT;
}
"if" {
	printf("yylineno = %d, token name IF, token is \"%s\"\n",yylineno,yytext);
	return IF;
}
"else" {
	printf("yylineno = %d, token name ELSE, token is \"%s\"\n",yylineno,yytext);
	return ELSE;
}
"for" {
	printf("yylineno = %d, token name FOR, token is \"%s\"\n",yylineno,yytext);
	return FOR;
}
"while" {
	printf("yylineno = %d, token name WHILE, token is \"%s\"\n",yylineno,yytext);
	return WHILE;
}
"do" {
	printf("yylineno = %d, token name DO, token is \"%s\"\n",yylineno,yytext);
	return DO;
}
"return" {
	printf("yylineno = %d, token name RETURN, token is \"%s\"\n",yylineno,yytext);
	return RETURN;
}
^"#include ".+ ;
{num}+ {
	printf("yylineno = %d, token name INTNUM, token is \"%s\"\n",yylineno,yytext);
	yylval.intnum = atoi(yytext);
	return INTNUM;
}
{num}+\.{num}+ {
	printf("yylineno = %d, token name FLOATNUM, token is \"%s\"\n",yylineno,yytext);
	yylval.floatnum = atof(yytext);
	return FLOATNUM;
}
{alpha}+({alpha}|{num})* {
	printf("yylineno = %d, token name ID, token is \"%s\"\n",yylineno,yytext);
	yylval.id = yytext;
	return ID;
}
[\+\-\*\/]\- {
	printf("yylineno = %d, token name UNARY, token is \"%s\"\n",yylineno,yytext);
	return UNARY;
}
^\- {
	printf("yylineno = %d, token name UNARY, token is \"%s\"\n",yylineno,yytext);
	return UNARY;
}
. {
	printf("yylineno = %d, no token name, token is \"%s\"\n",yylineno,yytext);
	return yytext[0];
}
%%
 /* User Code */
