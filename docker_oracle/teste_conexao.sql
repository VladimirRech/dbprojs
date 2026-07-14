-- Verificando objetos
desc all_tables;

-- Tabelas criadas pelo usuário SYSDBA
select TABLE_NAME, TABLESPACE_NAME, NUM_ROWS
from   all_tables
where  table_name like 'EXEMPLO%'
--where owner = 'SYSDBA'
;

-- Criando uma tabela de exemplo

create table exemplo_tabela (
    id number primary key,
    nome varchar2(50),
    data_criacao date default sysdate
);
