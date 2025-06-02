import java.io.*;
import java_cup.runtime.*;

public class TestParser {
    public static void main(String[] args) {
        try {
            System.out.println("=== TESTE DO ANALISADOR SINTÁTICO ===\n");
            
            // Ler arquivo de entrada
            String inputFile = "input.txt";
            FileReader fileReader = new FileReader(inputFile);
            Scanner scanner = new Scanner(fileReader);
            Parser parser = new Parser(scanner);
            
            System.out.println("Analisando arquivo: " + inputFile);
            System.out.println("Iniciando análise sintática...\n");
            
            try {
                // Executar parsing
                Symbol result = parser.parse();
                
                if (result != null) {
                    System.out.println("\n=== ANÁLISE SINTÁTICA BEM-SUCEDIDA ===");
                    System.out.println("O código fonte está sintaticamente correto!");
                } else {
                    System.out.println("\n=== ERRO NA ANÁLISE SINTÁTICA ===");
                    System.out.println("O parsing retornou resultado nulo.");
                }
                
            } catch (Exception e) {
                System.err.println("\n=== ERRO DURANTE PARSING ===");
                System.err.println("Erro: " + e.getMessage());
                
                if (e.getCause() != null) {
                    System.err.println("Causa: " + e.getCause().getMessage());
                }
            }
            
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