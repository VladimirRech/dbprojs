--
-- Configura pasta para a tabela externa
--
-- Cria o ponteiro para o diretório do servidor onde o arquivo de texto está salvo
CREATE OR REPLACE DIRECTORY dir_importacao AS '/home/vlad/git/dbprojs/docker_oracle';

-- Concede permissão de leitura para o usuário que vai importar
GRANT READ, WRITE ON DIRECTORY dir_importacao TO sys;
