
lexer grammar LexerRegex;


// 1. REGULAR EXPRESSION LITERAL

REGEX_LITERAL
    : '/' RegularExpressionBody '/' RegularExpressionFlags
    ;


// 2. REGULAR EXPRESSION BODY

fragment RegularExpressionBody
    : RegularExpressionFirstChar RegularExpressionChar*
    ;


// 3. FIRST CHARACTER

fragment RegularExpressionFirstChar
    : ~[\r\n\u2028\u2029*/\\[]
    | RegularExpressionBackslashSequence
    | RegularExpressionClass
    ;



// 4. REGULAR EXPRESSION CHARACTERS


fragment RegularExpressionChar
    : ~[\r\n\u2028\u2029/\\[]
    | RegularExpressionBackslashSequence
    | RegularExpressionClass
    ;


// 5. CHARACTER CLASS

fragment RegularExpressionClass
    : '[' RegularExpressionClassChar* ']'
    ;

fragment RegularExpressionClassChar
    : ~[\r\n\u2028\u2029\]\\]
    | RegularExpressionBackslashSequence
    ;


// 6. ESCAPE SEQUENCE

fragment RegularExpressionBackslashSequence
    : '\\' ~[\r\n\u2028\u2029]
    ;


// 7. REGULAR EXPRESSION FLAGS

fragment RegularExpressionFlags
    : [a-zA-Z]*
    ;
