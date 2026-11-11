lexer grammar StringLexer ;
//import LexerVariable ;

tokens {STRING}


STRING_DOUBLEQOAT_START : '"' -> more, pushMode(DOUBLEQOAT) ;
STRING_SINGLEQOAT_START : '\'' -> more, pushMode(SINGLEQOAT) ;
WS           : [ \t\r\n]+ -> skip ;

mode DOUBLEQOAT;
STR_ESCAPE1 : '\\'(.|[\n])  -> more ;
STR_TEXT1   : ~["\n] -> more ;
STRING_DOUBLEQOAT_END : '"' -> type(STRING), popMode ;

mode SINGLEQOAT;
STR_ESCAPE2 : '\\' (.|[\n])  -> more ;
STR_TEXT2   : ~['\n] -> more ;
STRING_SINGLEQOAT_END : '\'' -> type(STRING), popMode ;