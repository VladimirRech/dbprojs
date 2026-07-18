# ORACLE EXTERNAL TABLES
Ela funciona como um "ponteiro" para o arquivo físico no servidor, permitindo que você consulte o arquivo de texto usando SELECT e insira os dados na tabela final com um `INSERT INTO ... SELECT`.

# Passo 1: Criar o Diretório no Oracle (Físico/Lógico)
O Oracle precisa saber em qual pasta do servidor o arquivo está. Um usuário com privilégios de Administrador (SYS ou SYSTEM) precisa rodar:

```SQL
-- Cria o ponteiro para o diretório do servidor onde o arquivo de texto está salvo
CREATE OR REPLACE DIRECTORY dir_importacao AS '/caminho/do/seu/servidor/arquivos';

-- Concede permissão de leitura para o usuário que vai importar
GRANT READ, WRITE ON DIRECTORY dir_importacao TO seu_usuario;
```

# Passo 2: Criar a Tabela Externa (Mapeando o Texto)
Agora, logado com o seu usuário, você criará uma estrutura que lê o arquivo usando o driver ORACLE_LOADER.

Imagine que seu arquivo de texto (dados.txt) seja assim:

```
1;ID123;PRODUTO A;10.50
2;ID456;PRODUTO B;20.00
```

O comando SQL para mapear esse arquivo será:

```SQL
CREATE TABLE tabela_externa_txt (
    id_item      NUMBER,
    codigo       VARCHAR2(20),
    nome_item    VARCHAR2(100),
    preco        NUMBER
)
ORGANIZATION EXTERNAL (
    TYPE ORACLE_LOADER
    DEFAULT DIRECTORY dir_importacao
    ACCESS PARAMETERS (
        RECORDS DELIMITED BY NEWLINE
        -- Define o ponto e vírgula como delimitador das colunas
        FIELDS TERMINATED BY ';' 
        MISSING FIELD VALUES ARE NULL
    )
    LOCATION ('dados.txt') -- Nome exato do seu arquivo
)
REJECT LIMIT UNLIMITED;
```

# Passo 3: Inserir os dados na tabela definitiva
Depois de criada a tabela externa, o Oracle passa a enxergar o arquivo de texto como se fosse uma tabela comum. Para transferir os dados para a sua tabela de produção definitiva, basta rodar um comando SQL simples:

```SQL
INSERT INTO sua_tabela_definitiva (id, cod, nome, valor)
SELECT id_item, codigo, nome_item, preco 
FROM tabela_externa_txt;

-- Não se esqueça de efetivar a transação
COMMIT;
```

