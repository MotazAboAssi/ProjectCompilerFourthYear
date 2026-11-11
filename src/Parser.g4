parser grammar Parser;

options { tokenVocab=MainLexer; }

program
    : statement* EOF
    ;

statement
    : variableDeclaration
    ;

variableDeclaration
    : (VAR | LET | CONST) variableDeclarator (',' variableDeclarator)* SEMI
    ;

variableDeclarator
    : ID (ASSIGN expr)?
    ;

expr
    : expr op=('&&' | '||') expr    # logicalExpr
    | expr op=('==' | '!=') expr    # equalityExpr
    | expr op=('<' | '<=' | '>' | '>=') expr # relationalExpr
    | expr op=('*' | '/' | '%') expr # multiplicativeExpr
    | expr op=('+' | '-') expr      # additiveExpr
    | '(' expr ')'                  # parenExpr
    | ID                            # idExpr
    | INTEGER                       # intExpr
    | FLOAT                         # floatExpr
    | STRING                        # stringExpr
    | BOOLEAN_LIT                   # boolExpr
    ;
