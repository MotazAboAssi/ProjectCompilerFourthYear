lexer grammar MainLexer;

// الترتيب مهم: الكلمات المحجوزة أولاً حتى يربح let/const على ID
import LexerKeyword, LexerVariable, StringLexer;
