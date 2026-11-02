grammar Main;

// --- PARSER RULES ---

// Top-level program rule: a program consists of 0 or more statements
program
    : statement* EOF
    ;

statement
    : varDecl
    | assignment
    | ifStatement
    | whileStatement
    | printStatement
    | block
    ;

block
    : '{' statement* '}'
    ;

varDecl
    : 'let' ID ('=' expr)? ';'
    ;

assignment
    : ID '=' expr ';'
    ;

ifStatement
    : 'if' '(' expr ')' statement ('else' statement)?
    ;

whileStatement
    : 'while' '(' expr ')' statement
    ;

printStatement
    : 'print' '(' expr ')' ';'
    ;

// Expression hierarchy for operator precedence
expr
    : expr op=('&&' | '||') expr    # logicalExpr
    | expr op=('==' | '!=') expr    # equalityExpr
    | expr op=('<' | '<=' | '>' | '>=') expr # relationalExpr
    | expr op=('*' | '/' | '%') expr # multiplicativeExpr
    | expr op=('+' | '-') expr      # additiveExpr
    | '(' expr ')'                  # parenExpr
    | ID                            # idExpr
    | INT                           # intExpr
    | FLOAT                         # floatExpr
    | STRING                        # stringExpr
    | BOOLEAN                       # boolExpr
    ;

// --- LEXER RULES ---

LET     : 'let' ;
IF      : 'if' ;
ELSE    : 'else' ;
WHILE   : 'while' ;
PRINT   : 'print' ;

BOOLEAN : 'true' | 'false' ;
ID      : [a-zA-Z_] [a-zA-Z0-9_]* ;
INT     : [0-9]+ ;
FLOAT   : [0-9]+ '.' [0-9]+ ;
STRING  : '"' .*? '"' ;

// Skip whitespaces and inline/multiline comments
WS      : [ \t\r\n]+ -> skip ;
COMMENT : '//' ~[\r\n]* -> skip ;
BLOCK_COMMENT : '/*' .*? '*/' -> skip ;