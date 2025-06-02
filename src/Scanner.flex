%%

%class Scanner
%unicode
%line
%column
%cup

%{
    // Método para criar símbolos
    private java_cup.runtime.Symbol symbol(int type) {
        return new java_cup.runtime.Symbol(type, yyline, yycolumn);
    }
    
    private java_cup.runtime.Symbol symbol(int type, Object value) {
        return new java_cup.runtime.Symbol(type, yyline, yycolumn, value);
    }
%}

// Definições de caracteres
Letter = [a-zA-Z]
Digit = [0-9]
Whitespace = [ \t\r\n]
Integer = {Digit}+
Float = {Digit}+\.{Digit}+
Identifier = {Letter}({Letter}|{Digit}|_)*

// Estados para comentários
%state COMMENT
%state LINE_COMMENT

%%

// Whitespace
{Whitespace} { /* ignore */ }

// Comentários
"//"         { yybegin(LINE_COMMENT); }
"/*"         { yybegin(COMMENT); }

<LINE_COMMENT> {
    \n       { yybegin(YYINITIAL); }
    .        { /* ignore */ }
}

<COMMENT> {
    "*/"     { yybegin(YYINITIAL); }
    .        { /* ignore */ }
    \n       { /* ignore */ }
}

// Keywords
"if"         { return symbol(sym.IF); }
"else"       { return symbol(sym.ELSE); }
"while"      { return symbol(sym.WHILE); }
"for"        { return symbol(sym.FOR); }
"return"     { return symbol(sym.RETURN); }
"int"        { return symbol(sym.INT); }
"float"      { return symbol(sym.FLOAT); }
"void"       { return symbol(sym.VOID); }
"main"       { return symbol(sym.MAIN); }

// Operadores aritméticos
"+"          { return symbol(sym.PLUS); }
"-"          { return symbol(sym.MINUS); }
"*"          { return symbol(sym.MULT); }
"/"          { return symbol(sym.DIV); }
"="          { return symbol(sym.ASSIGN); }

// Operadores relacionais
"=="         { return symbol(sym.EQ); }
"!="         { return symbol(sym.NEQ); }
"<"          { return symbol(sym.LT); }
"<="         { return symbol(sym.LE); }
">"          { return symbol(sym.GT); }
">="         { return symbol(sym.GE); }

// Operadores lógicos
"&&"         { return symbol(sym.AND); }
"||"         { return symbol(sym.OR); }
"!"          { return symbol(sym.NOT); }

// Delimitadores
";"          { return symbol(sym.SEMICOLON); }
","          { return symbol(sym.COMMA); }
"("          { return symbol(sym.LPAREN); }
")"          { return symbol(sym.RPAREN); }
"{"          { return symbol(sym.LBRACE); }
"}"          { return symbol(sym.RBRACE); }

// Identificadores e constantes
{Identifier} { return symbol(sym.ID, yytext()); }
{Integer}    { return symbol(sym.INT_CONST, Integer.parseInt(yytext())); }
{Float}      { return symbol(sym.FLOAT_CONST, Float.parseFloat(yytext())); }

// Qualquer outro caractere
.            { throw new Error("Unexpected character [" + yytext() + "]"); }