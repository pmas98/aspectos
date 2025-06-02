import java.io.*;
import java_cup.runtime.*;
public class TestScanner {
    public static void main(String[] args) {
        try {
            System.out.println("=== TESTE DO ANALISADOR LÉXICO ===\n");
            
            // Ler arquivo de entrada
            String inputFile = "input.txt";
            FileReader fileReader = new FileReader(inputFile);
            Scanner scanner = new Scanner(fileReader);
            
            System.out.println("Analisando arquivo: " + inputFile);
            System.out.println("Tokens encontrados:\n");
            System.out.printf("%-15s %-20s %s\n", "LINHA:COLUNA", "TOKEN", "VALOR");
            System.out.println("---------------------------------------------------");
            
            Symbol token;
            int tokenCount = 0;
            
            while (true) {
                try {
                    token = scanner.next_token();
                    
                    if (token.sym == Symbol.EOF) {
                        break;
                    }
                    
                    tokenCount++;
                    String position = String.format("%d:%d", token.left + 1, token.right + 1);
                    String tokenName = Symbol.getTokenName(token.sym);
                    String value = token.value != null ? token.value.toString() : "";
                    
                    System.out.printf("%-15s %-20s %s\n", position, tokenName, value);
                    
                } catch (Exception e) {
                    System.err.println("Erro durante análise léxica: " + e.getMessage());
                    break;
                }
            }
            
            System.out.println("---------------------------------------------------");
            System.out.println("Total de tokens encontrados: " + tokenCount);
            System.out.println("\n=== ANÁLISE LÉXICA CONCLUÍDA ===");
            
            fileReader.close();
            
        } catch (FileNotFoundException e) {
            System.err.println("Arquivo 'input.txt' não encontrado!");
            System.err.println("Certifique-se de que o arquivo existe no diretório atual.");
        } catch (IOException e) {
            System.err.println("Erro ao ler arquivo: " + e.getMessage());
        } catch (Exception e) {
            System.err.println("Erro inesperado: " + e.getMessage());
            e.printStackTrace();
        }
    }
}