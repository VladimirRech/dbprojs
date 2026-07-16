--
-- Cria a tabela IBGE_MUNICIPIOS com os dados do IBGE
--
create table IBGE_MUNICIPIOS (
    UF varchar2(2) not null,
    COD_UF varchar(2) not null,
    CODIGO_MUNICIPIO varchar(5) not null,
    NOME_MUNICIPIO varchar2(100) not null,
    POP_COLETADA number(10) not null,
    POP_IMPUTADA number(5) not null,
    POP_TOTAL number(10) not null,
    PRIMARY KEY (CODIGO_MUNICIPIO)
);

drop table IBGE_MUNICIPIOS;

