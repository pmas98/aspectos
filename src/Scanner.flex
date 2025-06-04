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
Letter = [A-Z]
Digit = [0-9]
Whitespace = [ \t\r\n]
Integer = {Digit}+
Float = {Digit}+\.{Digit}+
// Identificadores são só letras maiúsculas
Identifier = {Letter}({Letter}|"_")*({Letter})?
String = \"[^\"]*\"

// Estados para comentários
%state COMMENT
%state LINE_COMMENT

%%

// Whitespace
{Whitespace} { /* ignore */ }

// Comentários BABA SCRIPT
"REMEMBER"   { yybegin(LINE_COMMENT); }

<LINE_COMMENT> {
    \r?\n    { yybegin(YYINITIAL); }
    [^\r\n]+ { /* ignore */ }
}

// Keywords BABA SCRIPT
"IS"         { return symbol(sym.IS); }
"HAS"        { return symbol(sym.HAS); }
"CAN"        { return symbol(sym.CAN); }
"BE"         { return symbol(sym.BE); }
"WHEN"       { return symbol(sym.WHEN); }
"ELSE"       { return symbol(sym.ELSE); }
"LOOP"       { return symbol(sym.LOOP); }
"SAY"        { return symbol(sym.SAY); }
"DO"         { return symbol(sym.DO); }
"BYE BYE"       { return symbol(sym.DONE); }
"MAKE"       { return symbol(sym.MAKE); }
"FUNCTION"   { return symbol(sym.FUNCTION); }
"USE"        { return symbol(sym.USE); }
"NOT"        { return symbol(sym.NOT); }
"AND"        { return symbol(sym.AND); }
"OR"         { return symbol(sym.OR); }
"SAME"       { return symbol(sym.SAME); }
"AS"         { return symbol(sym.AS); }

// Operadores aritméticos
"PLUS"          { return symbol(sym.PLUS); }
"MINUS"          { return symbol(sym.MINUS); }
"TIMES"          { return symbol(sym.MULT); }
"DIVIDES"          { return symbol(sym.DIV); }

// Delimitadores (mínimos em BABA SCRIPT)
"("          { return symbol(sym.LPAREN); }
")"          { return symbol(sym.RPAREN); }
";"          { return symbol(sym.SEMICOLON); }

// Identificadores, constantes e strings
{Identifier} { return symbol(sym.ID, yytext()); }
{Integer}    { return symbol(sym.INT_CONST, Integer.parseInt(yytext())); }
{Float}      { return symbol(sym.FLOAT_CONST, Float.parseFloat(yytext())); }
{String}     { return symbol(sym.STRING_CONST, yytext().substring(1, yytext().length()-1)); }

// Qualquer outro caractere
.            { throw new Error("Unexpected character [" + yytext() + "]"); }