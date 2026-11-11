lexer grammar LexerVariable ;
import LexerKeyword, StringLexer ;


// 2. NUMBERS
BIGINT
    : (HEX_NUMBER | OCTAL_NUMBER | BINARY_NUMBER | DECIMAL_WITH_SEP) 'n';

HEX_NUMBER
    : '0' [xX] [0-9a-fA-F] [0-9a-fA-F_]*;


OCTAL_NUMBER
    : '0' [oO] [0-7] [0-7_]*
    | '0' [0-7]+   ;

BINARY_NUMBER
    : '0' [bB] [01] [01_]* ;

FLOAT
    : [0-9] [0-9_]* '.' [0-9] [0-9_]* (('e' | 'E') ('+' | '-')? [0-9] [0-9_]*)?
    | '.' [0-9] [0-9_]* (('e' | 'E') ('+' | '-')? [0-9] [0-9_]*)?
    | [0-9] [0-9_]* (('e' | 'E') ('+' | '-')? [0-9] [0-9_]*) ;

INTEGER
    : [0-9] [0-9_]* ;

fragment DECIMAL_WITH_SEP
    : [0-9] [0-9_]*
    ;



// 7. COMMENTS & WHITESPACE
HASHBANG_COMMENT
    : '#!' ~[\r\n]* -> skip;

SINGLE_LINE_COMMENT
    : '//' (~[\r\n])* -> skip;

MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip;

  WS
     : [ \t\u000B\f\u00A0\uFEFF] -> skip
         ;

     LINE_TERMINATOR
         : [\r\n\u2028\u2029] -> skip
         ;


