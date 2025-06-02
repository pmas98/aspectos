# Compilador Front-end

Este projeto implementa um compilador front-end básico usando JFlex para análise léxica e JCup para análise sintática.

## Estrutura do Projeto

```
.
├── src/
│   ├── scanner.flex    # Especificação do analisador léxico
│   ├── parser.cup      # Especificação do analisador sintático
│   └── Main.java       # Classe principal para integração
├── input.txt           # Arquivo de entrada com código-fonte de teste
├── build.bat           # Script de compilação para Windows
└── README.md           # Este arquivo
```

## Requisitos

- Java JDK 8 ou superior
- JFlex 1.8.2
- JCup 0.11b
- Make (opcional, para sistemas Unix)

## Como Compilar e Executar

### Windows

1. Certifique-se de que o Java JDK está instalado e configurado no PATH
2. Execute o script de compilação:
   ```
   build.bat
   ```
3. Execute o programa:
   ```
   java -cp . Main input.txt
   ```

### Linux/Mac

1. Certifique-se de que o Java JDK está instalado
2. Execute os comandos:
   ```bash
   jflex src/scanner.flex
   java -jar java-cup-11b.jar src/parser.cup
   javac *.java
   java Main input.txt
   ```

## Funcionalidades Implementadas

### Analisador Léxico (Scanner)
- Reconhece keywords (if, else, while, return, etc.)
- Identificadores
- Constantes (inteiros e ponto flutuante)
- Operadores (+, -, *, /, ==, !=, etc.)
- Delimitadores (;, ,, {, }, (, ), etc.)
- Comentários (linha única e múltiplas linhas)

### Analisador Sintático (Parser)
- Estrutura básica de programa
- Declaração de variáveis
- Estruturas de controle (if-else, while)
- Definição e chamada de funções
- Expressões e atribuições

## Testes

O arquivo `input.txt` contém exemplos de código que demonstram todas as funcionalidades implementadas. A execução do programa mostrará:
1. Os tokens gerados pelo scanner
2. A árvore sintática gerada pelo parser
3. Quaisquer erros encontrados durante a análise 