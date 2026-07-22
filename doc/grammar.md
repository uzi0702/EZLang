# Lox の文法

出典: Crafting Interpreters, Appendix I (https://craftinginterpreters.com/appendix-i.html)

記法について:
- 書籍では定義記号に `→` を使っているが、ここでは BNF で一般的な `::=` に置き換えている
- `*`（0回以上の繰り返し）、`+`（1回以上の繰り返し）、`?`（省略可能）、`( )`（グループ化）は EBNF 由来の拡張記法
- `"..."` は終端記号（そのままの文字列）、大文字の `NUMBER` `STRING` `IDENTIFIER` `EOF` は字句解析器が生成するトークン

## 構文の文法 (Syntax Grammar)

```
program        ::= declaration* EOF

declaration    ::= classDecl
                 | funDecl
                 | varDecl
                 | statement

classDecl      ::= "class" IDENTIFIER ( "inherits" IDENTIFIER )?
                   "{" function* "}"
funDecl        ::= "fun" function
varDecl        ::= "var" IDENTIFIER ( "=" expression )? ";"

statement      ::= exprStmt
                 | forStmt
                 | forEachStmt
                 | ifStmt
                 | printStmt
                 | returnStmt
                 | whileStmt
                 | block

exprStmt       ::= expression ";"
forStmt        ::= "for" "(" ( varDecl | exprStmt | ";" )
                             expression? ";"
                             expression? ")" statement
forEachStmt    ::= "for" "(" "var" IDENTIFIER "in" expression ")" statement
ifStmt         ::= "if" "(" expression ")" statement
                   ( "else" statement )?
printStmt      ::= "print" expression ";"
returnStmt     ::= "return" expression? ";"
whileStmt      ::= "while" "(" expression ")" statement
block          ::= "{" declaration* "}"

expression     ::= assignment

assignment     ::= ( call "." )? IDENTIFIER "=" assignment
                 | call "[" expression "]" "=" assignment
                 | logic_or

logic_or       ::= logic_and ( "or" logic_and )*
logic_and      ::= equality ( "and" equality )*
equality       ::= comparison ( ( "!=" | "==" ) comparison )*
comparison     ::= term ( ( ">" | ">=" | "<" | "<=" ) term )*
term           ::= factor ( ( "-" | "+" ) factor )*
factor         ::= unary ( ( "/" | "*" ) unary )*

unary          ::= ( "!" | "-" ) unary
                 | call
call           ::= primary ( "(" arguments? ")" | "." IDENTIFIER | "[" expression "]" )*
primary        ::= "true" | "false" | "nil" | "this"
                 | NUMBER | STRING | IDENTIFIER | "(" expression ")"
                 | "super" "." IDENTIFIER
                 | listLiteral

listLiteral    ::= "[" ( expression ( "," expression )* )? "]"

function       ::= IDENTIFIER "(" parameters? ")" block
parameters     ::= IDENTIFIER ( "," IDENTIFIER )*
arguments      ::= expression ( "," expression )*
```

## 字句の文法 (Lexical Grammar)

```
NUMBER         ::= DIGIT+ ( "." DIGIT+ )?
STRING         ::= "\"" <any char except "\"">* "\""
IDENTIFIER     ::= ALPHA ( ALPHA | DIGIT )*
ALPHA          ::= "a" ... "z" | "A" ... "Z" | "_"
DIGIT          ::= "0" ... "9"
```
