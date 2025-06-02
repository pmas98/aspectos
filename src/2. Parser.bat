echo.
echo 📋 Etapa 2: Gerando Parser com JCup...
echo Diretório atual: %CD%
echo Verificando java-cup-11b.jar...

if exist java-cup-11b.jar (
    echo Arquivo java-cup-11b.jar encontrado
    echo Executando java-cup...
    java -jar java-cup-11b.jar -parser Parser -dump_grammar -dump_states Parser.cup > cup_output.txt 2>&1
    set CUP_ERROR=%errorlevel%
    echo Retorno do java-cup: !CUP_ERROR!
    if !CUP_ERROR! neq 0 (
        echo ❌ Erro ao gerar Parser
        type cup_output.txt
        pause
        exit /b 1
    )
) else (
    echo ❌ Arquivo java-cup-11b.jar não encontrado
    pause
    exit /b 1
)
