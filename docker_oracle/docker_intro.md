# Introdução e conceitos do Docker
(By Google Gemini)
14/07/2026

# 1. O Core Concept: Máquina Virtual vs. Contêiner
Para entender Docker de verdade, você precisa entender como ele conversa com o Sistema Operacional.

* **Virtualização Clássica (VMs)**: Você virtualiza o hardware. Cada VM roda um sistema operacional completo (com seu próprio Kernel), consumindo gigabytes de RAM e CPU só para manter o sistema "vivo", antes mesmo de rodar sua aplicação.
* **Contêineres (Docker)**: Você virtualiza apenas o sistema de arquivos (user space). O Docker não roda um sistema operacional novo; ele compartilha o Kernel do seu Debian hospedeiro. Ele isola os processos usando recursos nativos do Linux Kernel:
  * Namespaces: Criam uma "ilusão" para o processo de que ele está sozinho na máquina (rede própria, árvore de processos isolada, discos isolados).
  * Cgroups (Control Groups): Limitam o quanto de CPU, memória e banda aquele contêiner pode consumir, para ele não derrubar o resto do servidor.

  A analogia definitiva: Se uma VM é uma casa independente (com seus próprios canos, fiação, fundação e telhado), o contêiner é um apartamento em um condomínio. Ele divide a estrutura principal (o Kernel do Linux), mas tem sua própria porta trancada, sua própria decoração e suas próprias regras lá dentro.

# 2. A Trindade do Docker
No dia a dia, você vai operar sob três conceitos fundamentais. Se você entender a relação entre eles, nunca mais vai se perder em comandos.

```
+------------------+                 +-------------------+                 +---------------------+
|    Dockerfile    |  == (Build) ==> |    Image (Ima)    |  == (Run) ===>  | Container (Contêi)  |
| (A receita/código|                 | (O disco rígido   |                 | (O processo vivo,   |
|  de montagem)    |                 |  congelado/read)  |                 |  executando em RAM) |
+------------------+                 +-------------------+                 +---------------------+
```

# Aprofundando
## A. A Imagem (Image) — O Estado Congelado
A imagem é um sistema de arquivos somente leitura (read-only). Ela contém absolutamente tudo o que o seu processo precisa para rodar: as bibliotecas C, o Python/Java, as dependências e o seu código de ETL.

* **Conceito-chave**: Camadas (Layers). Cada linha que você escreve para montar uma imagem gera uma camada que é cacheada pelo Docker. Se você só alterar o código do seu script Python, o Docker não reconstrói a imagem inteira; ele só joga fora a última camada e reaproveita todo o resto. Isso torna o processo incrivelmente rápido.

## B. O Contêiner (Container) — A Instância Viva
O contêiner é a imagem em execução. Quando você dá docker run, o Docker pega aquela imagem somente leitura e adiciona uma camada finíssima de escrita no topo (a Writable Layer). Tudo o que o contêiner cria, altera ou deleta em tempo de execução morre e nasce nessa camada temporária.

> Atenção: Contêineres são efêmeros. Se você deletar o contêiner, tudo o que foi salvo nessa camada temporária some. 

## C. O Dockerfile — A Infraestrutura como Código
É o arquivo de texto simples onde você dita as regras de como sua imagem deve ser construída. É aqui que você sai do papel de "instalador de programas" e entra no de "arquiteto".

# 3. O Fluxo de Trabalho Essencial para Dados
Como Analista de Dados, o seu fluxo de trabalho produtivo com Docker vai girar em torno de três pilares práticos de arquitetura:

## I. Persistência de Dados (Volumes e Bind Mounts)
Como os contêineres são efêmeros, onde colocamos o banco de dados (como o seu Oracle XE) ou os arquivos .csv e .parquet do seu pipeline?

**Bind Mounts**: Você mapeia uma pasta real do seu Debian diretamente para dentro do contêiner. Se o seu script de ETL dentro do contêiner salvar um arquivo em /data, ele aparece instantaneamente na pasta do seu computador físico. Excelente para desenvolvimento.

**Volumes**: São gerenciados pelo próprio Docker em uma área isolada do disco. São mais performáticos no Linux e ideais para bancos de dados em produção, pois garantem que o dado sobreviva mesmo se o contêiner for destruído e recriado.

## II. Exposição de Portas (Port Forwarding)
O contêiner roda em uma rede interna isolada. Se o banco de dados lá dentro escuta na porta 1521, o seu Debian (e as ferramentas de BI na sua rede) não conseguem vê-lo até que você crie uma "ponte". Você precisa mapear a porta da sua máquina física para a porta do contêiner (ex: `-p 1521:1521`).

## III. Variáveis de Ambiente (Environment Variables)
Nunca coloque senhas de banco de dados, chaves de API ou caminhos rígidos (hardcoded) dentro do seu código de ETL ou da sua imagem. O Docker permite injetar essas configurações em tempo de execução. Assim, a exata mesma imagem que você testou localmente roda em produção apenas mudando as credenciais injetadas.

# 4. Fluxo recomendado para estudos:Crie seu próprio Dockerfile (O Batismo):

1. Pegue um script simples de ETL que você já tenha (em Python, por exemplo).
    * Crie um Dockerfile que parta de uma imagem oficial (`FROM python:3.10-slim`).
    * Instale as dependências (`RUN pip install pandas sqlalchemy ...`).
    * Copie seu script para dentro da imagem (`COPY . /app`).
    * Defina o comando de execução (`CMD ["python", "/app/seu_script.py"]`).
2. Entenda o ciclo de vida do contêiner:
    * Pratique a diferença entre `docker stop` (pausa o processo, mas mantém o estado temporário no disco) e `docker rm` (destrói o contêiner e limpa o lixo).
    * Aprenda a inspecionar o que está acontecendo lá dentro usando `docker logs <nome_container>` e `docker stats` (para monitorar consumo de RAM e CPU).
3. Aprenda o Docker Compose (O próximo nível obrigatório):
    * No mundo real, você raramente rodará comandos gigantescos do Docker no terminal. Você usará o Docker Compose (um arquivo yaml simples).
    * Ele serve para coordenar múltiplos contêineres. Por exemplo: subir o seu banco de dados Oracle + o seu script de ETL de forma unificada, garantindo que o ETL só comece a rodar depois que o banco estiver saudável.

# Exemplos
Exemplo de comandos considerando a imagem nomeada como **oracle-db**

```bash

# Iniciando a imagem - se estiver stopped
$ docker start oracle-db

# Verificando a execução
$ docker stats

# Interrompendo:
$ docker stop
```