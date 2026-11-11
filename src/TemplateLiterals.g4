lexer grammar TemplateLiterals;

import LexerVariable;

tokens {
    INTERPOLATION_END,
    UNTERMINATED_TEMPLATE,
    UNTERMINATED_INTERPOLATION,
    UNTERMINATED_STRING,
    UNTERMINATED_COMMENT,
    EXPR_NUMBER,
    INVALID_ESCAPE
}

@members {
    private final java.util.Deque<Integer> braceStack =
        new java.util.ArrayDeque<>();

    private boolean regexAllowed = true;

    private void updateRegexState(int tokenType) {
        if (tokenType == EXPR_ID) {
            String text = getText();
            switch (text) {
                case "return":
                case "throw":
                case "case":
                case "delete":
                case "void":
                case "typeof":
                case "new":
                case "in":
                case "instanceof":
                case "yield":
                case "await":
                case "else":
                case "do":
                case "of":
                    regexAllowed = true;
                    return;
                default:
                    regexAllowed = false;
                    return;
            }
        }

        switch (tokenType) {
            case EXPR_OPERATOR:
            case EXPR_LPAREN:
            case EXPR_LBRACKET:
            case EXPR_LBRACE:
            case INTERPOLATION_START:
                regexAllowed = true;
                break;

            case EXPR_ID:
            case EXPR_NUMBER:
            case EXPR_STRING:
            case EXPR_REGEX:
            case EXPR_RPAREN:
            case EXPR_RBRACKET:
            case EXPR_RBRACE:
            case TEMPLATE_END:
                regexAllowed = false;
                break;

            default:
                break;
        }
    }

    @Override
    public org.antlr.v4.runtime.Token emit() {
        org.antlr.v4.runtime.Token token = super.emit();
        updateRegexState(token.getType());
        return token;
    }
}

TEMPLATE_START
    : '`' -> pushMode(TEMPLATE_MODE)
;

//DEFAULT_ID
//    : ID_START ID_CONTINUE* -> type(EXPR_ID)
//;

DEFAULT_WS
    : [ \t\r\n]+ -> skip
;

//DEFAULT_OTHER
//    : . -> type(EXPR_OTHER)
//;

mode TEMPLATE_MODE;

TEMPLATE_END
    : '`' -> popMode
;

INTERPOLATION_START
    : '${'
      {
          braceStack.push(0);
          regexAllowed = true;
      }
      -> pushMode(EXPRESSION_MODE)
;

TEMPLATE_INVALID_ESCAPE
    : '\\' (
          'u' (
                '{' ~[0-9a-fA-F}] ~[}]* '}'?
              | ~[{0-9a-fA-F]

              | [0-9a-fA-F] (~[0-9a-fA-F] | [0-9a-fA-F] (~[0-9a-fA-F] | [0-9a-fA-F] ~[0-9a-fA-F]))
            )

        | 'x' (~[0-9a-fA-F] | [0-9a-fA-F] ~[0-9a-fA-F])
        | [1-9]
        | '0' [0-9]
      )
      -> type(INVALID_ESCAPE)
;

TEMPLATE_TEXT
    : (
          '\\' (
                ['"\\bfnrtv0`$\r\n]
              | '\r\n'
              | 'x' HEX_DIGIT HEX_DIGIT
              | 'u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
              | 'u{' HEX_DIGITS '}'
              | ~[ux0-9'"\\bfnrtv`$\r\n]
          )
        | ~[`\\$]
        | '$' {_input.LA(1) != '{'}?
      )+
;

TEMPLATE_EOF
    : EOF -> type(UNTERMINATED_TEMPLATE)
;

mode EXPRESSION_MODE;

EXPR_TEMPLATE_START
    : '`'
      {
          regexAllowed = true;
      }
      -> type(TEMPLATE_START), pushMode(TEMPLATE_MODE)
;

EXPR_LBRACE
    : '{'
      {
          if (!braceStack.isEmpty()) {
              int depth = braceStack.pop();
              braceStack.push(depth + 1);
          }
          regexAllowed = true;
      }
;

EXPR_RBRACE
    : '}'
      {
          if (!braceStack.isEmpty()) {
              int depth = braceStack.peek();
              if (depth == 0) {
                  braceStack.pop();
                  setType(INTERPOLATION_END);
                  regexAllowed = false;
                  popMode();
              } else {
                  braceStack.pop();
                  braceStack.push(depth - 1);
                  regexAllowed = false;
              }
          }
      }
;

EXPR_STRING
    : '"' ( '\\' . | ~["\\\r\n] )* '"'

    | '\'' ( '\\' . | ~['\\\r\n] )* '\''
;

EXPR_UNTERMINATED_DOUBLE_STRING
    : '"' ( '\\' . | ~["\\\r\n] )* ('\r'? '\n' | EOF)
      -> type(UNTERMINATED_STRING)
;

EXPR_UNTERMINATED_SINGLE_STRING
    : '\'' ( '\\' . | ~['\\\r\n] )* ('\r'? '\n' | EOF)
      -> type(UNTERMINATED_STRING)
;

EXPR_SINGLE_LINE_COMMENT
    : '//' ~[\r\n]* -> skip
;

EXPR_MULTI_LINE_COMMENT
    : '/*' .*? '*/' -> skip
;

EXPR_UNTERMINATED_COMMENT
    : '/*' ( ~[*] | '*' ~[/] )* '*'? EOF
      -> type(UNTERMINATED_COMMENT)
;

EXPR_REGEX
    : {regexAllowed}?
      '/'
      (
          '\\' .

        | '[' ('\\' . | ~']')* ']'
        | ~[/\\\r\n]
      )+
      '/'
      [a-zA-Z]*
;

EXPR_HEX_NUMBER
    : '0' [xX] HEX_DIGITS 'n'?
      -> type(EXPR_NUMBER)
;

EXPR_BINARY_NUMBER
    : '0' [bB] BIN_DIGITS 'n'?
      -> type(EXPR_NUMBER)
;

EXPR_OCTAL_NUMBER
    : '0' [oO] OCT_DIGITS 'n'?
      -> type(EXPR_NUMBER)
;

EXPR_DECIMAL_BIGINT
    : DEC_DIGITS 'n'
      -> type(EXPR_NUMBER)
;

EXPR_DECIMAL_NUMBER
    : (
          DEC_DIGITS ('.' DEC_DIGITS?)?
        | '.' DEC_DIGITS
      )
      ([eE] [+-]? DEC_DIGITS)?
      -> type(EXPR_NUMBER)
;

fragment DEC_DIGITS
    : [0-9] ('_'? [0-9])*
;

fragment HEX_DIGITS
    : HEX_DIGIT ('_'? HEX_DIGIT)*
;

fragment HEX_DIGIT
    : [0-9a-fA-F]
;

fragment BIN_DIGITS
    : [01] ('_'? [01])*
;

fragment OCT_DIGITS
    : [0-7] ('_'? [0-7])*
;

EXPR_ID
    : ID_START ID_CONTINUE*
;

fragment ID_START
    : [\p{L}\p{Nl}_$]
    | '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
    | '\\u{' HEX_DIGITS '}'
;

fragment ID_CONTINUE
    : [\p{L}\p{Nl}\p{Mn}\p{Mc}\p{Nd}\p{Pc}_$\u200C\u200D]
    | '\\u' HEX_DIGIT HEX_DIGIT HEX_DIGIT HEX_DIGIT
    | '\\u{' HEX_DIGITS '}'
;

EXPR_OPERATOR
    : '>>>='
    | '==='
    | '!=='
    | '>>>'
    | '**='
    | '<<='
    | '>>='
    | '&&='

    | '||='
    | '??='
    | '=='
    | '!='
    | '<='
    | '>='
    | '&&'

    | '||'
    | '??'
    | '++'
    | '--'
    | '=>'
    | '**'
    | '+='
    | '-='
    | '*='
    | '/='
    | '%='
    | '&='

    | '|='
    | '^='
    | '<<'
    | '>>'
    | '?.'
    | '+'
    | '-'
    | '*'
    | '/'
    | '%'
    | '='
    | '<'
    | '>'
    | '!'
    | '?'
    | ':'
    | '.'
    | ','
    | '&'

    | '|'
    | '^'
    | '~'
    | ';'
;

EXPR_LPAREN
    : '('
;

EXPR_RPAREN
    : ')'
;

EXPR_LBRACKET
    : '['
;

EXPR_RBRACKET
    : ']'
;

EXPR_WS
    : [ \t\r\n]+ -> skip
;

EXPR_OTHER
    : .
;

EXPR_EOF
    : EOF -> type(UNTERMINATED_INTERPOLATION)
;
