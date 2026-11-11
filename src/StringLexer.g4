lexer grammar StringLexer;

// يُعرّف نوع التوكن النهائي. يجب أن يكون قبل القواعد.
tokens { STRING }

// ---------- DEFAULT MODE : بداية النص فقط ----------
// more  = لا تُصدر توكن الآن، احتفظ بالنص المطابق وكمّل
// pushMode = ادخل وضع قراءة داخل النص
STRING_START_DQ : '"'  -> more, pushMode(DQ_STR) ;
STRING_START_SQ : '\'' -> more, pushMode(SQ_STR) ;

// ---------- داخل نص "..." ----------
mode DQ_STR;

// \ ثم سطر جديد  => استمرار السطر (هذه هي حالة ملفك)
DQ_LINE_CONT : '\\' ( '\r\n' | '\r' | '\n' | '\u2028' | '\u2029' ) -> more ;
// أي escape آخر: \"  \\  \n  \t  \u0041 ...
DQ_ESCAPE    : '\\' ~[\r\n] -> more ;
// أي محارف عادية (ليس " ولا \ ولا سطر جديد)
DQ_TEXT      : ~["\\\r\n]+ -> more ;
// النهاية: يصبح نوع التوكن STRING ونرجع للوضع الأصلي
DQ_END       : '"' -> type(STRING), popMode ;

// ---------- داخل نص '...' ----------
mode SQ_STR;

SQ_LINE_CONT : '\\' ( '\r\n' | '\r' | '\n' | '\u2028' | '\u2029' ) -> more ;
SQ_ESCAPE    : '\\' ~[\r\n] -> more ;
SQ_TEXT      : ~['\\\r\n]+ -> more ;
SQ_END       : '\'' -> type(STRING), popMode ;
