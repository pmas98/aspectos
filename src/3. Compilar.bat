echo.
echo 📋 Etapa 3: Compilando arquivos Java...
javac -cp ".;java-cup-11b.jar" *.java

if errorlevel 1 (
    echo ❌ Erro na compilação
    pause
    exit /b 1
)

echo ✅ Compilação concluída com sucesso!
echo.
echo 🎉 Processo finalizado! Os arquivos foram gerados e compilados.
echo.
pause