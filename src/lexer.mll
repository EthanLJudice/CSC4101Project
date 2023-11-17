{
open Parser
}

let white = [' ' '\t']+
let digit = ['0'-'9']
let int = '-'? digit+
(*add float one???*)
let frac = '.' digit*
let exp = ['e' 'E'] ['-' '+']? digit+
let float = digit* frac? exp?
let letter = ['a'-'z' 'A'-'Z']
let id = letter+

rule read = 
  parse
  | white { read lexbuf }
  | "true" { TRUE }
  | "false" { FALSE }
  | "<=" { LEQ }
  | ">=" { GEQ }
  | "*" { TIMES }
  | "/" { DIVIDE }
  | "+" { PLUS }
  | "-" { MINUS }
  | "*." { FTIMES }
  | "/." { FDIVIDE }
  | "+." { FPLUS }
  | "-." { FMINUS }
  | "(" { LPAREN }
  | ")" { RPAREN }
  | "let" { LET }
  | "=" { EQUALS }
  | "in" { IN }
  | "if" { IF }
  | "then" { THEN }
  | "else" { ELSE }
  | ":" {COLON}
  | "int" {INT_TYPE}
  | "bool" {BOOL_TYPE}
  | "float" {FLOAT_TYPE}
  | id { ID (Lexing.lexeme lexbuf) }
  | int { INT (int_of_string (Lexing.lexeme lexbuf)) }
  | float { FLOAT (float_of_string (Lexing.lexeme lexbuf)) }
  | eof { EOF }
