grammar Define;

compilationUnit
    : defaultDeclaration? systemDeclaration* EOF
    ;

defaultDeclaration
    : defineKey ':' defineValue
    ;

systemDeclaration
    : defineKey ':' defineValue
    ;

defineKey: IDENTIFIER;
defineValue: IDENTIFIER;


IDENTIFIER:         Letter LetterOrDigit*;

// Whitespace and comments

WS:                 [ \t\r\n\u000C]+ -> channel(HIDDEN);
COMMENT:            '/*' .*? '*/'    -> channel(HIDDEN);
LINE_COMMENT:       '//' ~[\r\n]*    -> channel(HIDDEN);

STRING_LITERAL:     '"' (~["\\\r\n] | EscapeSequence)* '"';


fragment HexDigit
    : [0-9a-fA-F]
    ;

fragment EscapeSequence
    : '\\' [btnfr"'\\]
    | '\\' ([0-3]? [0-7])? [0-7]
    | '\\' 'u'+ HexDigit HexDigit HexDigit HexDigit
    ;

fragment LetterOrDigit
    : Letter
    | [0-9]
    ;

fragment Letter
    : [a-zA-Z$_] // these are the "java letters" below 0x7F
    | ~[\u0000-\u007F\uD800-\uDBFF] // covers all characters above 0x7F which are not a surrogate
    | [\uD800-\uDBFF] [\uDC00-\uDFFF] // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
    ;