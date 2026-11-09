lexer grammar LexerKeyword;


// 1. RESERVED KEYWORDS
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

DEBUGGER : 'debugger' ;
EXPORT : 'export' ;
IMPORT : 'import' ;
IN : 'in' ;
WITH : 'with' ;
STATIC : 'static' ;

// Future reserved words
ENUM : 'enum' ;
IMPLEMENT : 'implements' ;
INTERFACE : 'interface' ;
PACKAGE : 'package';
PRIVATE : 'private' ;
PROTECT : 'protected' ;
PUBLIC : 'public';

// Future reserved words in older standards
ABSTRACT : 'abstract' ;
BOOLEAN : 'boolean';
BYTE : 'byte';
CHAR : 'char';
DOUBLE : 'double';
FINAL  : 'final';
FLOAT : 'float';
GOTO : 'goto';
INT : 'int';
LONG : 'long';
NATIVE : 'native';
SHORT : 'short';
SYNCHRNIZED : 'synchronized';
THROWS : 'throws';
TRANSIENT : 'transient';
VOLATILE : 'volatile' ;

// Identifiers with special meanings
GET : 'get' ;
OF : 'of' ;
SET : 'set' ;
ARGUMENTS : 'arguments' ;
FROM : 'from';
AS : 'as' ;


// 3. BOOLEANS & SPECIAL LITERALS
BOOLEAN_LIT : 'true' | 'false';
NULL_LIT  : 'null';
UNDEF_LIT : 'undefined';



// 5. OPERATORS
ASSIGN        : '=';
ADD           : '+';
SUB           : '-';
MUL           : '*';
DIV           : '/';
MOD           : '%';
EXP           : '**';
INC           : '++';
DEC           : '--';

EQ            : '==';
STRICT_EQ     : '===';
NOT_EQ        : '!=';
STRICT_NOT_EQ : '!==';
LT            : '<';
GT            : '>';
LTE           : '<=';
GTE           : '>=';

AND           : '&&';
OR            : '||';
NOT           : '!';

BIT_AND       : '&';
BIT_OR        : '|';
BIT_XOR       : '^';
BIT_NOT       : '~';
LSHIFT        : '<<';
RSHIFT        : '>>';
URSHIFT       : '>>>';

ADD_ASSIGN    : '+=';
SUB_ASSIGN    : '-=';
MUL_ASSIGN    : '*=';
DIV_ASSIGN    : '/=';
EXP_ASSIGN    : '**=';

ARROW         : '=>';
NULLISH       : '??';
OPTIONAL_CHAIN: '?.';
SPREAD        : '...';



// 6. PUNCTUATION & DELIMITERS
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
