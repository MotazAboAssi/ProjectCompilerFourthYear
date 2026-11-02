lexer grammar Lexer;

// ==========================================
// 1. RESERVED KEYWORDS
// ==========================================

VAR       : 'var';
LET       : 'let';
CONST     : 'const';
FUNCTION  : 'function';
RETURN    : 'return';

IF        : 'if';
ELSE      : 'else';
SWITCH    : 'switch';
CASE      : 'case';
DEFAULT   : 'default';
BREAK     : 'break';
CONTINUE  : 'continue';

FOR       : 'for';
WHILE     : 'while';
DO        : 'do';

TRY       : 'try';
CATCH     : 'catch';
FINALLY   : 'finally';
THROW     : 'throw';

CLASS     : 'class';
EXTENDS   : 'extends';
SUPER     : 'super';
NEW       : 'new';
THIS      : 'this';
TYPEOF    : 'typeof';
INSTANCEOF: 'instanceof';
VOID      : 'void';
DELETE    : 'delete';

ASYNC     : 'async';
AWAIT     : 'await';
YIELD     : 'yield';


// ==========================================
// 2. NUMBERS
// ==========================================

BIGINT       : [0-9]+ 'n';
HEX_NUMBER   : '0' [xX] [0-9a-fA-F]+;
OCTAL_NUMBER : '0' [oO] [0-7]+;
BINARY_NUMBER : '0' [bB] [01]+;
FLOAT        : [0-9]+ '.' [0-9]+;
INTEGER      : [0-9]+;


// ==========================================
// 3. BOOLEANS & SPECIAL LITERALS
// ==========================================

BOOLEAN   : 'true' | 'false';
NULL_LIT  : 'null';
UNDEF_LIT : 'undefined';


// ==========================================
// 4. IDENTIFIERS (المعرفات وأسماء المتغيرات)
// ==========================================
ID : IdentifierStart IdentifierPart* ;

fragment IdentifierStart
    : [a-zA-Z_$]
    | '\\' [uU] [0-9a-fA-F][0-9a-fA-F][0-9a-fA-F][0-9a-fA-F]
    ;

fragment IdentifierPart
    : [a-zA-Z0-9_$]
    ;



// ==========================================
// 5. OPERATORS (العمليات)
// ==========================================



// ==========================================
// 6. PUNCTUATION & DELIMITERS
// ==========================================

SEMI          : ';';
COMMA         : ',';
DOT           : '.';
QUESTION      : '?';
COLON         : ':';

LPAREN        : '(';
RPAREN        : ')';
LBRACE        : '{';
RBRACE        : '}';
LBRACK        : '[';
RBRACK        : ']';


// ==========================================
// 7. COMMENTS & WHITESPACE
// ==========================================

SINGLE_LINE_COMMENT
    : '//' (~[\r\n])* -> skip;

MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip;

WS
    : [ \t\r\n]+ -> skip;