@echo off
setlocal enabledelayedexpansion
echo ===========================================
echo     SCRIPT DE COMPILACAO - COMPILADOR
echo ===========================================
echo.

REM Limpar arquivos anteriores
echo 🔧 Limpando arquivos anteriores...
del Scanner.java Parser.java *.class 2>nul

echo.
echo 📋 Etapa 1: Gerando Scanner com JFlex...
jflex Scanner.flex

if errorlevel 1 (
    echo ❌ Erro ao gerar Scanner
    pause
    exit /b 1
)

echo ✅ Scanner.java gerado com sucesso!
