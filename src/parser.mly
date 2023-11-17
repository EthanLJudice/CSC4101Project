%{
open Ast
%}

%token <int> INT
%token <float> FLOAT
%token <string> ID
%token TRUE
%token FALSE
%token GEQ
%token LEQ
%token TIMES
%token MINUS
%token DIVIDE
%token PLUS
%token FTIMES
%token FMINUS
%token FDIVIDE
%token FPLUS
%token FGEQ
%token FLEQ
%token LPAREN
%token RPAREN
%token LET
%token EQUALS
%token IN
%token IF
%token THEN
%token ELSE
%token COLON
%token INT_TYPE
%token BOOL_TYPE
%token FLOAT_TYPE
%token EOF

%nonassoc IN
%nonassoc ELSE
%left FLEQ
%left FGEQ
%left LEQ
%left GEQ
%left PLUS
%left MINUS
%left DIVIDE
%left TIMES
%left FPLUS
%left FMINUS
%left FDIVIDE
%left FTIMES


%start <Ast.expr> prog

%%

prog:
	| e = expr; EOF { e }
	;
	
expr:
	| i = INT { Int i }
    | f = FLOAT { Float f }
  	| x = ID { Var x }
  	| TRUE { Bool true }
  	| FALSE { Bool false }
  	| e1 = expr; LEQ; e2 = expr { Binop (Leq, e1, e2) }
  	| e1 = expr; TIMES; e2 = expr { Binop (Mult, e1, e2) }
  	| e1 = expr; PLUS; e2 = expr { Binop (Add, e1, e2) }
    | e1 = expr; DIVIDE; e2 = expr { Binop (Divide, e1, e2) }
    | e1 = expr; MINUS; e2 = expr { Binop (Subtract, e1, e2) }
    | e1 = expr; FTIMES; e2 = expr { Binop (FMult, e1, e2) }
  	| e1 = expr; FPLUS; e2 = expr { Binop (FAdd, e1, e2) }
    | e1 = expr; FDIVIDE; e2 = expr { Binop (FDivide, e1, e2) }
    | e1 = expr; FMINUS; e2 = expr { Binop (FSubtract, e1, e2) }
    | e1 = expr; GEQ; e2 = expr { Binop (Geq, e1, e2) }
    | e1 = expr; FLEQ; e2 = expr { Binop (Leq, e1, e2) }
    | e1 = expr; FGEQ; e2 = expr { Binop (Geq, e1, e2) }
  	| LET; x = ID; COLON; t = typ; EQUALS; e1 = expr; IN; e2 = expr 
		{ Let (x, t, e1, e2) }
  	| IF; e1 = expr; THEN; e2 = expr; ELSE; e3 = expr { If (e1, e2, e3) }
  	| LPAREN; e=expr; RPAREN {e}
	;

typ: 
	| INT_TYPE { TInt }
	| FLOAT_TYPE { TFloat }
    | BOOL_TYPE { TBool }
