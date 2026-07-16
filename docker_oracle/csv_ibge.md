# IMPORTAR CSV DADOS CENSO PARANÁ
Objetivo: importar dados do último censo do Estado do Paraná em uma base Orale rodando no Docker para demonstrar o caminho para realizar importação de dados CSV no banco de dados ORACLE.

> **Nota**: os dados usados no exemplo são dados abertos e disponíveis livremente na internet através de sites institucionais e do Governo.

# Etapas
1. Fazer download dos dados
2. Definir formato dos dados de origem.
3. Definir o script para importação dos dados.
4. Realizar testes de importação.

# 1. Fazer download dos dados
Download do arquivo do Excel para os dados do [Censo 2022](https://ftp.ibge.gov.br/Censos/Censo_Demografico_2022/Populacao_e_domicilios_Primeiros_resultados/Resultados_da_2a_apuracao_20231027/CD2022_Populacao_Coletada_Imputada_e_Total_Municipio_e_UF_20231222.ods) nome do arquivo: *CD2022_Populacao_Coletada_Imputada_e_Total_Municipio_e_UF_20231222.ods*.

# 2. Definir formato dos dados de origem.
Usar CSV usando o separador ';'.
Encoding: UTF-8.

## Transformações
1. Separado no arquivo original os dados do Estado do Paraná em uma planilha.
2. No nome do cabeçalho das colunas foram substituídos os pontos (.) e espaços pelo caractere "_" para simplificar a manipulação do arquivo CSV.
3. Gerado o arquivo `censo_2022_paraná.csv`.

## Dicionário de dados
Colunas:
* **UF**: Sigla do estado.
* **COD_UF**: Código IBGE do Estado. Sempre dois dígitos.
* **COD_MUNIC**: Código IBGE do município. 5 dígitos. Sempre considerar os zeros à esquerda.
* **NOME_DO_MUNICÍPIO**: Nome do município.
* **POP_COLETADA**: Número de habitantes coletados originalmente. Campo numérico, inteiro.
* **POP_IMPUTADA**: Quantidade de habitantes ajustados e adicionados posteriormente à coleta.  Campo numérico, inteiro.
* **POP_TOTAL**: Soma da população coletada com a imputada.  Campo numérico, inteiro.

# 3. Definir o script para importação dos dados.
Serão definidos dois scripts:
1. Definição da tabela do banco de dados. No arquivo **`cria_tabela.sql`**.
2. Script de importação dos dados. Serão feitas duas abordagens para o script de importação:
    1. **Script gerado pelo Excel**.
    2. **Script que Lê o arquivo**.

## Gerando script de importação dos dados pelo Excel ou Libre Office Calc.
A abordagem consiste em converter o arquivo CSV para uma planilha do Excel ou Libre Office Calc e através de fórmula que concatena os dados das colunas com o texto, gerar o script SQL.

Nos testes foi usado o Libre Office Calc 25.2.3.2, as fórmulas estão compatíveis com esta versão.

Também foi necessário alterar nomes de municípios com apóstrofo "'" porque quebravam o SQL, exemplo: **Diamante D'Oeste**.

Exemplo de fórmula: 
```basic
=concatenar("insert into IBGE_MUNICIPIOS (UF, COD_UF, CODIGO_MUNICIPIO, NOME_MUNICIPIO, POP_COLETADA, POP_IMPUTADA, POP_TOTAL) values ('"; A2; "', '"; B2; "', '"; C2; "', '"; D2; "',"; E2; ", "; F2; ", "; G2; ");")
```

Arquivos:
* **censo_2022_paraná-script.ods**: planilha do Libre Office para gerar o script SQL.
* **insere_registros_paraná.sql**: script SQL para inserção dos registros.
