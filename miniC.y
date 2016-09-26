/* Definitions */
%{
#include <stdio.h>
#include <stdlib.h>
#include "AST.h"
%}

%union {
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
}

%token <intnum> INTNUM <floatnum> FLOATNUM <id> ID
%token <id> INT <id> FLOAT
%token <id> FOR <id> WHILE <id> DO <id> IF <id> ELSE
%token <id> RELA <id> EQLT
%token <id> RETURN
%token <id> UNARY

%type <ptr_program> PROGRAM;
%type <ptr_declaration> DECLARATION;
%type <ptr_identifier> IDENTIFIER;
%type <ptr_function> FUNCTION;
%type <ptr_parameter> PARAMETER;
%type <ptr_compoundstmt> COMPOUNDSTMT;

%type <ptr_stmt> STMT;
%type <ptr_assign> ASSIGN;
%type <ptr_call> CALL;
%type <ptr_arg> ARG;

%type <ptr_while_s> WHILE_S;
%type <ptr_for_s> FOR_S;
%type <ptr_if_s> IF_S;
%type <ptr_expr> EXPR;
%type <ptr_unop> UNOP;
%type <ptr_addiop> ADDIOP;
%type <ptr_multop> MULTOP;
%type <ptr_relaop> RELAOP;
%type <ptr_eqltop> EQLTOP;
%type <ptr_id_s> ID_S;

%%
/* Rules */
PROGRAM : 
DECLARATION FUNCTION{
	struct PROGRAM *program = (struct PROGRAM *) malloc (sizeof (struct PROGRAM));
	program->decl = $1;
	program->func = $2;
	$$ = program;
} 
| 
DECLARATION {
	struct PROGRAM *program = (struct PROGRAM *) malloc (sizeof (struct PROGRAM));
	program->decl = $1;
	$$ = program;
}
| 
FUNCTION {
	struct PROGRAM *program = (struct PROGRAM *) malloc (sizeof (struct PROGRAM));
	program->func = $1;
	$$ = program;
}
;

DECLARATION : 
INT IDENTIFIER ';' DECLARATION{
	struct DECLARATION *decl = (struct DECLARATION *) malloc (sizeof (struct DECLARATION));
	decl->t = eInt;
	decl->id = $2;
	decl->prev = $4;
	$$ = decl;
}
|
FLOAT IDENTIFIER ';' DECLARATION{
	struct DECLARATION *decl = (struct DECLARATION *) malloc (sizeof (struct DECLARATION));
	decl->t = eFloat;
	decl->id = $2;
	decl->prev = $4;
	$$ = decl;
}
|
INT IDENTIFIER ';' {
	struct DECLARATION *decl = (struct DECLARATION *) malloc (sizeof (struct DECLARATION));
	decl->t = eInt;
	decl->id = $2;
	$$ = decl;
}
|
FLOAT IDENTIFIER ';' {
	struct DECLARATION *decl = (struct DECLARATION *) malloc (sizeof (struct DECLARATION));
	decl->t = eFloat;
	decl->id = $2;
	$$ = decl;
}
;
IDENTIFIER : 
ID '[' INTNUM ']' ',' IDENTIFIER {
	struct IDENTIFIER *ident = (struct IDENTIFIER *) malloc (sizeof (struct IDENTIFIER));
	ident->ID = $1;
	ident->intnum = $3;
	ident->prev = $6;
	$$=ident;
}
|
ID ',' IDENTIFIER{
	struct IDENTIFIER *ident = (struct IDENTIFIER *) malloc (sizeof (struct IDENTIFIER));
	ident->ID = $1;
	ident->prev = $3;
	$$=ident;
}
|
ID '[' INTNUM ']'{
	struct IDENTIFIER *ident = (struct IDENTIFIER *) malloc (sizeof (struct IDENTIFIER));
	ident->ID = $1;
	ident->intnum = $3;
	$$=ident;
}
|
ID{
	struct IDENTIFIER *ident = (struct IDENTIFIER *) malloc (sizeof (struct IDENTIFIER));
	ident->ID = $1;
	$$=ident;
}
;
FUNCTION : 
INT ID '(' PARAMETER ')' COMPOUNDSTMT FUNCTION{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eInt;
	func->ID=$2;
	func->param=$4;
	func->cstmt=$6;
	func->prev=$7;
	$$=func;
}
|
INT ID '(' PARAMETER ')' COMPOUNDSTMT{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eInt;
	func->ID=$2;
	func->param=$4;
	func->cstmt=$6;
	$$=func;
}
|
FLOAT ID '(' PARAMETER ')' COMPOUNDSTMT FUNCTION{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eFloat;
	func->ID=$2;
	func->param=$4;
	func->cstmt=$6;
	func->prev=$7;
	$$=func;
}
|
FLOAT ID '(' PARAMETER ')' COMPOUNDSTMT{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eFloat;
	func->ID=$2;
	func->param=$4;
	func->cstmt=$6;
	$$=func;
}
|
INT ID '(' ')' COMPOUNDSTMT FUNCTION{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eInt;
	func->ID=$2;
	func->cstmt=$5;
	func->prev=$5;
	$$=func;
}
|
INT ID '(' ')' COMPOUNDSTMT{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eInt;
	func->ID=$2;
	func->cstmt=$5;
	$$=func;
}
|
FLOAT ID '(' ')' COMPOUNDSTMT FUNCTION{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eFloat;
	func->ID=$2;
	func->cstmt=$5;
	func->prev=$6;
	$$=func;
}
|
FLOAT ID '(' ')' COMPOUNDSTMT{
	struct FUNCTION *func = (struct FUNCTION *) malloc (sizeof (struct FUNCTION));
	func->t=eFloat;
	func->ID=$2;
	func->cstmt=$5;
	$$=func;
}
;
PARAMETER : 
INT IDENTIFIER PARAMETER{
	struct PARAMETER *para = (struct PARAMETER *) malloc (sizeof (struct PARAMETER));
	para->t = eInt;
	para->id = $2;
	para->prev = $3;
	$$=para;
}
|
INT IDENTIFIER{
	struct PARAMETER *para = (struct PARAMETER *) malloc (sizeof (struct PARAMETER));
	para->t = eInt;
	para->id = $2;
	$$=para;
}
;
COMPOUNDSTMT : 
'{' DECLARATION STMT '}' {
	struct COMPOUNDSTMT *cstmt = (struct COMPOUNDSTMT *) malloc (sizeof (struct COMPOUNDSTMT));
	cstmt->decl=$2;
	cstmt->stmt=$3;
	$$=cstmt;
}
|
'{' STMT '}' {
	struct COMPOUNDSTMT *cstmt = (struct COMPOUNDSTMT *) malloc (sizeof (struct COMPOUNDSTMT));
	cstmt->stmt=$2;
	$$=cstmt;
}
|
'{' DECLARATION '}' {
	struct COMPOUNDSTMT *cstmt = (struct COMPOUNDSTMT *) malloc (sizeof (struct COMPOUNDSTMT));
	cstmt->decl=$2;
	$$=cstmt;
}
|
'{' '}' {
	struct COMPOUNDSTMT *cstmt = (struct COMPOUNDSTMT *) malloc (sizeof (struct COMPOUNDSTMT));
	$$=cstmt;
}
;
STMT : 
ASSIGN ';' STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eAssign;
	stmt->stmt.assign_ = $1;
	stmt->prev = $3;
	$$ = stmt;
}
|
ASSIGN ';' {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eAssign;
	stmt->stmt.assign_ = $1;
	$$ = stmt;
}
|
CALL ';' STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eCall;
	stmt->stmt.call_ = $1;
	stmt->prev = $3;
	$$ = stmt;
}
|
CALL ';' {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eCall;
	stmt->stmt.call_ = $1;
	$$ = stmt;
}
|
RETURN EXPR ';' STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eRet;
	stmt->stmt.return_ = $2;
	stmt->prev = $4;
	$$ = stmt;
}
|
RETURN EXPR ';' {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eRet;
	stmt->stmt.return_ = $2;
	$$ = stmt;
}
|
WHILE_S STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eWhile;
	stmt->stmt.while_ = $1;
	stmt->prev = $2;
	$$ = stmt;
}
|
WHILE_S {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eWhile;
	stmt->stmt.while_ = $1;
	$$ = stmt;
}
|
FOR_S STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eFor;
	stmt->stmt.for_ = $1;
	stmt->prev = $2;
	$$ = stmt;
}
|
FOR_S {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eFor;
	stmt->stmt.for_ = $1;
	$$ = stmt;
}
|
IF_S STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eIf;
	stmt->stmt.if_ = $1;
	stmt->prev = $2;
	$$ = stmt;
}
|
IF_S {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eIf;
	stmt->stmt.if_ = $1;
	$$ = stmt;
}
|
COMPOUNDSTMT STMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eCompound;
	stmt->stmt.cstmt_ = $1;
	stmt->prev = $2;
	$$ = stmt;
}
|
COMPOUNDSTMT {
	struct STMT *stmt = (struct STMT *) malloc (sizeof (struct STMT));
	stmt->s = eCompound;
	stmt->stmt.cstmt_ = $1;
	$$ = stmt;
}
;
ASSIGN : 
ID '[' EXPR ']' '=' EXPR {
	struct ASSIGN *asmt = (struct ASSIGN *) malloc (sizeof (struct ASSIGN));
	asmt->ID = $1;
	asmt->index = $3;
	asmt->expr = $6;
	$$=asmt;
}
|
ID '=' EXPR {
	struct ASSIGN *asmt = (struct ASSIGN *) malloc (sizeof (struct ASSIGN));
	asmt->ID = $1;
	asmt->expr = $3;
	$$=asmt;
}
;
CALL : 
ID '(' ARG ')' ';' {
	struct CALL *cl = (struct CALL *) malloc (sizeof (struct CALL));
	cl->ID=$1;
	cl->arg=$3;
	$$=cl;
}
|
ID '(' ')' ';' {
	struct CALL *cl = (struct CALL *) malloc (sizeof (struct CALL));
	cl->ID=$1;
	$$=cl;
}
;
ARG : 
EXPR ',' ARG{
	struct ARG *ar = (struct ARG *) malloc (sizeof (struct ARG));
	ar->expr=$1;
	ar->prev=$3;
	$$=ar;
}
|
EXPR {
	struct ARG *ar = (struct ARG *) malloc (sizeof (struct ARG));
	ar->expr=$1;
	$$=ar;
}
;

WHILE_S : 
WHILE '(' EXPR ')' STMT {
	struct WHILE_S *wh_s = (struct WHILE_S *) malloc (sizeof (struct WHILE_S));
	wh_s->do_while = false;
	wh_s->cond = $3;
	wh_s->stmt = $5;
	$$=wh_s;
}
|
DO STMT WHILE '(' EXPR ')' ';'{
	struct WHILE_S *wh_s = (struct WHILE_S *) malloc (sizeof (struct WHILE_S));
	wh_s->do_while = true;
	wh_s->cond = $5;
	wh_s->stmt = $2;
	$$=wh_s;
}
;
FOR_S : 
FOR '(' ASSIGN ';' EXPR ';' ASSIGN ')' STMT {
	struct FOR_S *f_s = (struct FOR_S *) malloc (sizeof (struct FOR_S));
	f_s->init = $3;
	f_s->cond = $5;
	f_s->inc = $7;
	f_s->stmt = $9;
	$$ = f_s;
}
;
IF_S : 
IF '(' EXPR ')' STMT ELSE STMT {
	struct IF_S *i_s = (struct IF_S *) malloc (sizeof (struct IF_S));
	i_s->cond = $3;
	i_s->if_ = $5;
	i_s->else_ = $7;
	$$ = i_s;
}
|
IF '(' EXPR ')' STMT {
	struct IF_S *i_s = (struct IF_S *) malloc (sizeof (struct IF_S));
	i_s->cond = $3;
	i_s->if_ = $5;
	$$ = i_s;
}
;

EXPR : 
UNOP {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eUnop;
	exp->expression.unop_=$1;
	$$=exp;
}
|
ADDIOP {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eAddi;
	exp->expression.addiop_=$1;
	$$=exp;
}
|
MULTOP {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eMulti;
	exp->expression.multop_=$1;
	$$=exp;
}
|
RELAOP {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eRela;
	exp->expression.relaop_=$1;
	$$=exp;
}
|
EQLTOP {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eEqlt;
	exp->expression.eqltop_=$1;
	$$=exp;
}
|
CALL {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eCallExpr;
	exp->expression.call_=$1;
	$$=exp;
}
|
'(' EXPR ')' {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eExpr;
	exp->expression.bracket=$2;
	$$=exp;
}
|
ID_S {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eId;
	exp->expression.ID_=$1;
	$$=exp;
}
|
INTNUM {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eIntnum;
	exp->expression.intnum=$1;
	$$=exp;
}
|
FLOATNUM {
	struct EXPR *exp = (struct EXPR *) malloc (sizeof (struct EXPR));
	exp->e = eFloatnum;
	exp->expression.floatnum=$1;
	$$=exp;
}
;
UNOP : 
UNARY EXPR {
	struct UNOP *uo = (struct UNOP *) malloc (sizeof (struct UNOP));
	uo->u = eNegative;
	uo->expr = $2;
	$$=uo;
}
;
ADDIOP : 
EXPR '+' EXPR {
	struct ADDIOP *ado = (struct ADDIOP *) malloc (sizeof (struct ADDIOP));
	ado->a = ePlus;
	ado->lhs = $1;
	ado->rhs = $3;
	$$=ado;
}
|
EXPR '-' EXPR {
	struct ADDIOP *ado = (struct ADDIOP *) malloc (sizeof (struct ADDIOP));
	ado->a = eMinus;
	ado->lhs = $1;
	ado->rhs = $3;
	$$=ado;
}
;
MULTOP : 
EXPR '*' EXPR {
	struct MULTOP *mto = (struct MULTOP *) malloc (sizeof (struct MULTOP));
	mto->m = eMult;
	mto->lhs = $1;
	mto->rhs = $3;
	$$=mto;
}
|
EXPR '/' EXPR {
	struct MULTOP *mto = (struct MULTOP *) malloc (sizeof (struct MULTOP));
	mto->m = eDiv;
	mto->lhs = $1;
	mto->rhs = $3;
	$$=mto;
}
;
RELAOP :
EXPR '>' EXPR {
	struct RELAOP *rlo = (struct RELAOP *) malloc (sizeof (struct RELAOP));
	rlo->r = eGT;
	rlo->lhs = $1;
	rlo->rhs = $3;
	$$=rlo;
}
|
EXPR '<' EXPR {
	struct RELAOP *rlo = (struct RELAOP *) malloc (sizeof (struct RELAOP));
	rlo->r = eLT;
	rlo->lhs = $1;
	rlo->rhs = $3;
	$$=rlo;
}
|
EXPR ">=" EXPR {
	struct RELAOP *rlo = (struct RELAOP *) malloc (sizeof (struct RELAOP));
	rlo->r = eGE;
	rlo->lhs = $1;
	rlo->rhs = $3;
	$$=rlo;
}
|
EXPR "<=" EXPR {
	struct RELAOP *rlo = (struct RELAOP *) malloc (sizeof (struct RELAOP));
	rlo->r = eLE;
	rlo->lhs = $1;
	rlo->rhs = $3;
	$$=rlo;
}
;
EQLTOP :
EXPR "==" EXPR {
	struct EQLTOP *eqo = (struct EQLTOP *) malloc (sizeof (struct EQLTOP));
	eqo->e = eEQ;
	eqo->lhs = $1;
	eqo->rhs = $3;
	$$=eqo;
}
|
EXPR "!=" EXPR {
	struct EQLTOP *eqo = (struct EQLTOP *) malloc (sizeof (struct EQLTOP));
	eqo->e = eNE;
	eqo->lhs = $1;
	eqo->rhs = $3;
	$$=eqo;
}
;
ID_S : 
ID EXPR {
	struct ID_S *is = (struct ID_S *) malloc (sizeof (struct ID_S));
	is->ID = $1;
	is->expr = $2;
	$$=is;
}
|
ID{
	struct ID_S *is = (struct ID_S *) malloc (sizeof (struct ID_S));
	is->ID = $1;
	$$=is;
}
;
%%
/* USER CODE */
int yyerror(char const *str) {
    extern char *yytext;
    extern char *yylineno;
    printf("parser error near line : %d, error token is \"%s\"\n", yylineno, yytext);
    return 0;
}
