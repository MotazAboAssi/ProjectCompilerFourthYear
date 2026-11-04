lexer grammar StringLexer ;

////LET : 'let' ;
////ASSi : '=' ;
////STATMENT: LET ID ASSi STR ;
tokens {STRING}

STRING_START : '"' -> more, mode(STR_MODE) ;
WS           : [ \t\r\n]+ -> skip ;

mode STR_MODE;

STR_ESCAPE : '\\"'  -> more ;
STR_SLASH  : '\\\\' -> more ;
STR_TEXT   : ~["\\] -> more ;
STRING_END : '"' -> type(STRING), mode(DEFAULT_MODE) ;


ID : [a-zA-Z_][a-zA-Z0-9_]* ;

Assign : '=' ;  Equals : '==' ;  StrictEquals : '===' ;
Not : '!' ;  NotEquals : '!=' ;  StrictNotEquals : '!==' ;
Lt : '<' ;  Gt : '>' ;  Le : '<=' ;  Ge : '>=' ;


//
//mode DOUBLEQOAT;
//CLOSE_DOUBLEQOAT : '"' CONTENT_DOUBLEQOAT -> type(STRING), popMode;
//OPEN_SLASH_DOUBLEQOUT : ('\\"'| '\\\\') CONTENT_DOUBLEQOAT-> more, pushMode(SLASH_DOUBLEQOUT),popMode;
//CONTENT_DOUBLEQOAT : ~[\\"\t\r\n]+;
//
//mode SLASH_DOUBLEQOUT;
//CLOSE_SLASH_DOUBLEQOUT : '"' -> type(STRING), popMode;
//
//
////BEGIN_CASE : '\"' -> pushMode(INSIDE);
////
//////ID : [a-zA-Z] [a-zA-Z0-9]*;
//////
//////WS : [ \t\r\n]+ -> skip;
////
////mode INSIDE;
////END_CASE : '\"' -> type(STRING), popMode;
//////CONTENT : ~[\t\r\n]*;
//////WS1 : [ \t\r\n]+ -> skip;
