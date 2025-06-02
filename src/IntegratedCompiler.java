import java.io.*;
import java_cup.runtime.*;

public class IntegratedCompiler {
    public static void main(String[] args) {
        try {
            System.out.println("==========================================");
            System.out.println("    COMPILADOR FRONT-END INTEGRADO");
            System.out.println("==========================================\n");
            
            String inputFile = "input.txt";
            
            // ETAPA 1: ANÁLISE LÉXICA
            System.out.println("ETAPA 1: ANÁLISE LÉXICA");
            System.out.println("------------------------\n");
            
            FileReader fileReader1 = new FileReader(inputFile);
            Scanner scanner1 = new Scanner(fileReader1);
            
            System.out.println("Executando análise léxica em: " + inputFile);
            System.out.printf("%-15s %-20s %s\n", "POSIÇÃO", "TIPO DE TOKEN", "VALOR");
            System.out.println("---------------------------------------------------");
            
            Symbol token;
            int tokenCount = 0;
            
            // Primeira passada: análise léxica
            while (true) {
                try {
                    token = scanner1.next_token();
                    
                    if (token.sym == Symbol.EOF) {
                        break;
                    }
                    
                    tokenCount++;
                    String position = String.format("%d:%d", token.left + 1, token.right + 1);
                    String tokenName = Symbol.getTokenName(token.sym);
                    String value = token.value != null ? token.value.toString() : "";
                    
                    System.out.printf("%-15s %-20s %s\n", position, tokenName, value);
                    
                } catch (Exception e) {
                    System.err.println("Erro na análise léxica: " + e.getMessage());
                    return;
                }
            }
            
            System.out.println("---------------------------------------------------");
            System.out.println("Total de tokens: " + tokenCount);
            System.out.println("✓ Análise léxica concluída com sucesso!\n");
            
            fileReader1.close();
            
            // ETAPA 2: ANÁLISE SINTÁTICA
            System.out.println("ETAPA 2: ANÁLISE SINTÁTICA");
            System.out.println("---------------------------\n");
            
            FileReader fileReader2 = new FileReader(inputFile);
            Scanner scanner2 = new Scanner(fileReader2);
            Parser parser = new Parser(scanner2);
            
            System.out.println("Executando análise sintática...");
            System.out.println("Construindo árvore sintática abstrata...\n");
            
            try {
                // Segunda passada: análise sintática
                Symbol result = parser.parse();
                
                if (result != null) {
                    System.out.println("\n✓ Análise sintática concluída com sucesso!");
                    System.out.println("✓ Árvore sintática construída!");
                } else {
                    System.err.println("\n✗ Erro: Análise sintática falhou");
                    return;
                }
                
            } catch (Exception e) {
                System.err.println("\n✗ Erro durante análise sintática:");
                System.err.println("   " + e.getMessage());
                return;
            }
            
            fileReader2.close();
            
            // ETAPA 3: RESULTADO FINAL
            System.out.println("\nETAPA 3: INTEGRAÇÃO COMPLETA");
            System.out.println("-----------------------------\n");
            
            System.out.println("✓ Scanner e Parser integrados com sucesso!");
            System.out.println("✓ Código fonte processado completamente!");
            System.out.println("\nResumo da compilação:");
            System.out.println("- Tokens identificados: " + tokenCount);
            System.out.println("- Estrutura sintática: Válida");
            System.out.println("- Status: SUCESSO");
            
            System.out.println("\n==========================================");
            System.out.println("    COMPILAÇÃO FRONT-END CONCLUÍDA");
            System.out.println("==========================================");
            
        } catch (FileNotFoundException e) {
            System.err.println("✗ Erro: Arquivo 'input.txt' não encontrado!");
            System.err.println("   Certifique-se de que o arquivo existe no diretório atual.");
        } catch (IOException e) {
            System.err.println("✗ Erro de E/S: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("✗ Erro inesperado: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // Método auxiliar para exibir informações de debug
    private static void printDebugInfo(String phase, String info) {
        System.out.println("[DEBUG " + phase + "] " + info);
    }
}