/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_MINIC_TAB_H_INCLUDED
# define YY_YY_MINIC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INTNUM = 258,
    FLOATNUM = 259,
    ID = 260,
    INT = 261,
    FLOAT = 262,
    FOR = 263,
    WHILE = 264,
    DO = 265,
    IF = 266,
    ELSE = 267,
    RELA = 268,
    EQLT = 269,
    RETURN = 270,
    UNARY = 271
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 8 "miniC.y" /* yacc.c:1909  */

	struct PROGRAM *ptr_program;
	struct DECLARATION *ptr_declaration;
	struct IDENTIFIER *ptr_identifier;
	struct FUNCTION *ptr_function;
	struct PARAMETER *ptr_parameter;
	struct COMPOUNDSTMT *ptr_compoundstmt;

	struct STMT *ptr_stmt;
	struct ASSIGN *ptr_assign;
	struct CALL *ptr_call;
	struct ARG *ptr_arg;

	struct WHILE_S *ptr_while_s;
	struct FOR_S *ptr_for_s;
	struct IF_S *ptr_if_s;
	struct EXPR *ptr_expr;
	struct UNOP *ptr_unop;
	struct ADDIOP *ptr_addiop;
	struct MULTOP *ptr_multop;
	struct RELAOP *ptr_relaop;
	struct EQLTOP *ptr_eqltop;
	struct ID_S *ptr_id_s;

	int intnum;
	float floatnum;
	char* id;

#line 100 "miniC.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_MINIC_TAB_H_INCLUDED  */
