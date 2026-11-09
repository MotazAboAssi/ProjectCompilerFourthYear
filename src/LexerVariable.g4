lexer grammar LexerVariable ;

// 2. NUMBERS
//BIGINT       : [0-9]+ 'n';
 fragment BIGINT_DECIML : BIT_INTEGER_WITHOUT_ZERO INTEGER ;
BIGINT : (OCTAL_NUMBER |BINARY_NUMBER  |HEX_NUMBER ) 'n' ;
BIT_INTEGER_WITHOUT_ZERO : [1-9] ;
INTEGER      : [0-9]+;
HEX_NUMBER   : '0' [xX] [0-9a-fA-F]+;
OCTAL_NUMBER : '0' [oO]? [0-7]+;
BINARY_NUMBER : '0' [bB] [01]+;
FLOAT        : [0-9]+ '.' [0-9]+;
NUMBER : (FLOAT | INTEGER) [eE] [-+]?[0-9]+ ;

// 4. IDENTIFIERS
ID : IdentifierStart IdentifierPart* ;

fragment IdentifierStart
    : [a-zA-Z_$]
    | '\\' [uU] [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]
    ;

fragment IdentifierPart
    : [a-zA-Z0-9_$]
    ;

// 7. COMMENTS & WHITESPACE
SINGLE_LINE_COMMENT
    : '//' (~[\r\n])* -> skip;

MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip;

HASHBANG_COMMENT : '#!'('/'[a-zA-Z ]+)+ -> skip ;

WS
    : [ \t\r\n]+ -> skip;


