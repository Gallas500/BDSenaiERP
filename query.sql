create database senaierp;
use senaierp;

-- Sem FK

create table grupo_produto (
    id int auto_increment primary key,
    nome varchar(100),
    descricao text
);

create table unidade_produto (
    id int auto_increment primary key,
    nome varchar(10),
    descricao text
);

create table tipo_fornecedor (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table situacao_for_cli (
    id int auto_increment primary key,
    nome varchar(10),
    descricao text
);

create table tipo_endereco (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table tipo_telefone (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table tipo_email (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table tipo_relacionamento (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table papel (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table funcao (
    id int auto_increment primary key,
    descricao_menu varchar(30),
    imagem_menu varchar(30),
    metodo varchar(30)
);

create table tipo_colaborador (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table nivel_formacao (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text
);

create table cargo (
    id int auto_increment primary key,
    nome varchar(20),
    descricao text,
    salario double(11,2)
);

create table pais (
    id int auto_increment primary key,
    codigo int,
    nome varchar(100),
    sigla2 char(2),
    sigla3 char(3)
);

create table cfop (
    id int auto_increment primary key,
    cfop int,
    descricao text,
    aplicacao text
);

create table banco (
    id int auto_increment primary key,
    codigo int,
    nome varchar(100),
    url varchar(255)
);

create table operadora_cartao (
    id int auto_increment primary key,
    bandeira varchar(30),
    nome varchar(50)
);

-- Com FK
create table sub_grupo_produto (
    id int auto_increment primary key,
    id_grupo int not null,
    foreign key (id_grupo) references grupo_produto(id),
    nome varchar(100),
    descricao text
);

create table produto (
    id int auto_increment primary key,
    id_sub_grupo int not null,
    foreign key (id_sub_grupo) references sub_grupo_produto(id),
    id_unidade int not null,
    foreign key (id_unidade) references unidade_produto(id),
    gtin char(14),
    nome_produto varchar(100),
    descricao text,
    descricao_pdv varchar(30),
    valor_compra double(11,2),
    valor_venda double(11,2),
    qtd_estoque double(11,2),
    estoque_min double(11,2),
    estoque_max double(11,2),
    excluido char(1),
    data_cadastro date
);

create table empresa (
    id int auto_increment primary key,
    empresa_id int not null,
    foreign key (empresa_id) references empresa(id),
    razao_social varchar(150),
    nome_fantasia varchar(150),
    cnpj varchar(14),
    inscricao_estatual varchar(30),
    inscricao_municipal varchar(30),
    matriz_filial char(1),
    data_cadastro date
);

create table convenio (
    id int auto_increment primary key ,
    id_empresa int not null,
    foreign key (id_empresa) references empresa(id),
    nome varchar(100),
    descricao text,
    desconto double(11,2),
    data_vencimento date,
    endereco varchar(250),
    contato varchar(30),
    telefone varchar(10),
    excluido char(1),
    data_cadastro date
);

create table setor (
    id int auto_increment primary key ,
    empresa_id int not null,
    foreign key (empresa_id) references empresa(id),
    nome varchar(20),
    descricao text
);

create table funcao_papel(
    id int auto_increment primary key ,
    funcao_id int not null,
    foreign key (funcao_id) references funcao(id),
    papel_id int not null ,
    foreign key (papel_id) references papel(id),
    pode_consultar char(1),
    pode_inserir char(1),
    pode_alterar char(1),
    pode_excluir char(1)
);

create table empresa_produto(
    id int auto_increment primary key,
    empresa_id int not null,
    foreign key (empresa_id) references empresa(id),
    produto_id int not null,
    foreign key (produto_id) references produto(id)
);

create table fornecedor(
    id int auto_increment primary key ,
    situacao_for_cli_id int not null ,
    foreign key (situacao_for_cli_id) references situacao_for_cli(id),
    tipo_fornecedor_id int not null ,
    foreign key (tipo_fornecedor_id) references tipo_fornecedor(id),
    id_empresa int not null,
    foreign key (id_empresa) references empresa(id),
    nome varchar(150),
    cpf_cnpj varchar(14),
    rg varchar(20),
    orgao_rg varchar(10),
    inscricao_estadual varchar(30),
    inscricao_municipal varchar(30),
    desde date,
    tipo_pessoa char(1),
    excluido char(1),
    data_cadastro date
);

create table fornecedor_produto(
    id int auto_increment primary key,
    fornecedor_id int not null ,
    foreign key (fornecedor_id) references fornecedor(id),
    produto_id int not null ,
    foreign key (produto_id) references produto(id)
);

create table cliente(
    id int auto_increment primary key,
    situacao_for_cli_id int not null ,
    foreign key (situacao_for_cli_id) references situacao_for_cli(id),
    id_empresa int not null ,
    foreign key (id_empresa) references empresa(id),
    nome varchar(150),
    cpf_cnpj varchar(14),
    rg varchar(20),
    orgao_rg varchar(10),
    inscricao_estadual varchar(30),
    inscricao_municipal varchar(30),
    desde date,
    tipo_pessoa char(1),
    excluido char(1),
    data_cadastro date
);

create table colaborador(
    id int auto_increment primary key,
    nivel_formacao_id int not null ,
    foreign key (nivel_formacao_id) references nivel_formacao(id),
    tipo_colaborador_id int not null ,
    foreign key (tipo_colaborador_id) references tipo_colaborador(id),
    cargo_id int not null ,
    foreign key (cargo_id) references cargo(id),
    id_setor int not null ,
    foreign key (id_setor) references setor(id),
    nome varchar(150),
    cpf varchar(11),
    rg varchar(20),
    orgao_rg varchar(10),
    data_nascimento date,
    tipo_sanguineo varchar(5),
    foto_34 varchar(255),
    excluido char(1),
    data_cadastro date
);

create table usuario (
    id int auto_increment primary key,
    papel_id int not null,
    foreign key (papel_id) references papel(id),
    colaborador_id int not null,
    foreign key (colaborador_id) references colaborador(id),
    login varchar(20),
    senha varchar(20),
    data_cadastro date
);

create table colaborador_relacionamento (
    id int auto_increment primary key,
    tipo_relacionamento_id int not null,
    foreign key (tipo_relacionamento_id) references tipo_relacionamento(id),
    colaborador_id int not null,
    foreign key (colaborador_id) references colaborador(id),
    nome varchar(100)
);

create table contato_email (
    id int auto_increment primary key,
    tipo_email_id int not null,
    foreign key (tipo_email_id) references tipo_email(id),
    contato_id int not null,
    foreign key (contato_id) references contato(id),
    email varchar(100)
);

create table contato (
    id int auto_increment primary key,
    empresa_id int not null,
    foreign key (empresa_id) references empresa(id),
    colaborador_id int not null,
    foreign key (colaborador_id) references colaborador(id),
    cliente_id int not null,
    foreign key (cliente_id) references cliente(id),
    fornecedor_id int not null,
    foreign key (fornecedor_id) references fornecedor(id),
    nome varchar(100),
    dono char(1)
);

create table contato_telefone (
    id int auto_increment primary key ,
    tipo_telefone_id int not null,
    foreign key (tipo_telefone_id) references tipo_telefone(id),
    contato_id int not null,
    foreign key (contato_id) references contato(id),
    telefone varchar(10)
);

create table estado (
    id int auto_increment primary key,
    pais_id int not null,
    foreign key (pais_id) references pais(id),
    sigla char(2),
    nome varchar(50),
    codigo_ibge int
);

create table indice_economico (
    id int auto_increment primary key,
    pais_id int not null,
    foreign key (pais_id) references pais(id),
    sigla varchar(10),
    nome varchar(50),
    descricao text
);

create table cidade (
    id int auto_increment primary key,
    estado_id int not null,
    foreign key (estado_id) references estado(id),
    nome varchar(100),
    codigo_ibge int
);

create table cep (
    id int auto_increment primary key,
    cidade_id int not null,
    foreign key (cidade_id) references cidade(id),
    cep varchar(8),
    logradouro varchar(100),
    bairro varchar(50)
);

create table agencia_banco (
    id int auto_increment primary key,
    cep_id int not null,
    foreign key (cep_id) references cep(id),
    banco_id int not null,
    foreign key (banco_id) references banco(id),
    codigo int,
    nome varchar(100),
    endereco varchar(100),
    telefone varchar(10),
    gerente varchar(30),
    contato varchar(30),
    obs text
);

create table endereco (
    id int auto_increment primary key,
    empresa_id int not null,
    foreign key (empresa_id) references empresa(id),
    colaborador_id int not null,
    foreign key (colaborador_id) references colaborador(id),
    fornecedor_id int not null,
    foreign key (fornecedor_id) references fornecedor(id),
    cliente_id int not null,
    foreign key (cliente_id) references cliente(id),
    tipo_endereco_id int not null,
    foreign key (tipo_endereco_id) references tipo_endereco(id),
    cep_id int not null,
    foreign key (cep_id) references cep(id),
    logradouro varchar(100),
    numero int,
    complemento varchar(100),
    bairro varchar(50),
    dono char(1)
);

INSERT INTO CFOP (CFOP,DESCRICAO,APLICACAO) VALUES (1000,'ENTRADAS OU AQUISIÇÕES DE SERVIÇOS DO ESTADO','Classificam-se, neste grupo, as operações ou prestações em que o estabelecimento remetente esteja localizado na mesma unidade da Federação do destinatário'),(1100,'COMPRAS PARA INDUSTRIALIZAÇÃO, PRODUÇÃO RURAL, COMERCIALIZAÇÃO OU PRESTAÇÃO DE SERVIÇOS','(NR Ajuste SINIEF 05/2005) (DECRETO Nº 28.868, DE 31/01/2006)\r\n\r\n(Dec. 28.868/2006 – Efeitos a partir de 01/01/2006, ficando facultada ao contribuinte a sua adoção para fatos geradores ocorridos no período de 01 de novembro a 31 de dezembro de 2005)'),(1101,'Compra para industrialização ou produção rural (NR Ajuste SINIEF 05/2005) (Decreto 28.868/2006)','Compra de mercadoria a ser utilizada em processo de industrialização ou produção rural, bem como a entrada de mercadoria em estabelecimento industrial ou produtor rural de cooperativa recebida de seus cooperados ou de estabelecimento de outra cooperativa.\r\n\r\n(DECRETO Nº 28.868, DE 31/01/2006-– Efeitos a partir de 01/01/2006, ficando facultada ao contribuinte a sua adoção para fatos geradores ocorridos no período de 01 de novembro a 31 de dezembro de 2005).'),(1102,'Compra para comercialização','Classificam-se neste código as compras de mercadorias a serem comercializadas. Também serão classificadas neste código as entradas de mercadorias em estabelecimento comercial de cooperativa recebidas de seus cooperados ou de estabelecimento de outra cooperativa.');

INSERT INTO OPERADORA_CARTAO (BANDEIRA,NOME) VALUES ('VISA','0VISA'),('MASTERCARD','0MASTERCARD');

INSERT INTO PAIS (CODIGO,NOME,SIGLA2,SIGLA3) VALUES (1,'BRASIL','BR','BRA'),(2,'ESTADOS UNIDOS','EU','EUA'),(3,'ANGOLA','AN','ANG');

INSERT INTO PAPEL (NOME,DESCRICAO) VALUES ('ADM','ADMINISTRADO'),('USER','USUARIO'),('TESTE','TESTE');

INSERT INTO SITUACAO_FOR_CLI (NOME,DESCRICAO) VALUES ('NORMAL',NULL),('DEVEDOR',NULL),('OUTRO',NULL);

INSERT INTO GRUPO_PRODUTO (NOME,DESCRICAO) VALUES ('GRUPO 01',NULL),('GRUPO 02',NULL),('GRUPO 03',NULL);

INSERT INTO NIVEL_FORMACAO (NOME,DESCRICAO) VALUES ('MESTRADO',NULL),('ENSINO MEDIO',NULL),('ENSINO FUNDAMENTAL',NULL);

INSERT INTO TIPO_RELACIONAMENTO (NOME,DESCRICAO) VALUES ('FILHO',NULL);

INSERT INTO TIPO_TELEFONE (NOME,DESCRICAO) VALUES ('RESIDENCIAL',NULL);

INSERT INTO UNIDADE_PRODUTO (NOME,DESCRICAO) VALUES ('UND','UNIDADE'),('KG','KILO'),('CX','CAIXA'),('TESTE UND','TESTE UND');

INSERT INTO TIPO_FORNECEDOR (NOME,DESCRICAO) VALUES ('FORNECEDOR',NULL);

INSERT INTO TIPO_COLABORADOR (NOME,DESCRICAO) VALUES ('EMPREGADO',NULL),('REPRESENTANTE','REPRESENTANTE DA EMPRESA');

INSERT INTO TIPO_EMAIL (NOME,DESCRICAO) VALUES ('PESSOAL',NULL);

INSERT INTO TIPO_ENDERECO (NOME,DESCRICAO) VALUES ('RESIDENCIAL','Endereço moradia.'),('TRABALHO','Endereço do local de trabalho');

INSERT INTO CARGO (NOME,DESCRICAO,SALARIO) VALUES ('ANALISTA','ANALISTA DE SISTEMAS',8000.00),('PROGRAMADOR','AJUDA O ANALISTA',5500.00),('DBA','ADMINISTRADOR DE BANCO DE DADOS',6000.00),('TÉCNICO DE INFORMÁTICA','AJUDA O ANALISTA E O PROGRAMADOR',1900.00),('TÉCNICO','ADMINISTRATIVO',2500.00);

INSERT INTO EMPRESA (EMPRESA_ID,RAZAO_SOCIAL,NOME_FANTASIA,CNPJ,INSCRICAO_ESTADUAL,INSCRICAO_MUNICIPAL,MATRIZ_FILIAL,DATA_CADASTRO) VALUES (1,'SERVICO NACIONAL DE APRENDIZAGEM INDUSTRIAL - DEPARTAMENTO REGIONAL DO DISTRITO FEDERAL','SENAI DR/DF','03806360000173',NULL,NULL,NULL,CURRENT_TIMESTAMP);

INSERT INTO SETOR (EMPRESA_ID,NOME,DESCRICAO) VALUES (1,'INFORMATICA',NULL),(1,'VENDAS','SETOR DE VENDAS'),(1,'RECURSOS HUMANOS','RECURSOS HUMANOS');

INSERT INTO SUB_GRUPO_PRODUTO (ID_GRUPO,NOME,DESCRICAO) VALUES (1,'SUBGRUPO 1.01',NULL),(1,'SUBGRUPO 1.02',NULL),(1,'SUBGRUPO 1.03',NULL),(2,'SUBGRUPO 2.01',NULL),(2,'SUBGRUPO 2.02',NULL),(3,'SUBGRUPO 3.01',NULL);

INSERT INTO ESTADO (PAIS_ID,SIGLA,NOME,CODIGO_IBGE) VALUES (1,'DF','DISTRITO FEDERAL',53),(1,'CE','CEARA',19),(1,'MA','MARANHAO',21),(2,'NY','NEW YORK',NULL);

INSERT INTO CONVENIO (ID_EMPRESA,NOME,DESCRICAO,DESCONTO,DATA_VENCIMENTO,ENDERECO,CONTATO,TELEFONE,EXCLUIDO,DATA_CADASTRO) VALUES (1,'COCA COLA',NULL,20.00,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP);

INSERT INTO INDICE_ECONOMICO (PAIS_ID,SIGLA,NOME,DESCRICAO) VALUES (1,'IPCA','INDICE DE PRECOS CONSUMIDOR AMPLO',NULL);

INSERT INTO CLIENTE (SITUACAO_FOR_CLI_ID,ID_EMPRESA,NOME,CPF_CNPJ,RG,ORGAO_RG,INSCRICAO_ESTADUAL,INSCRICAO_MUNICIPAL,DESDE,TIPO_PESSOA,EXCLUIDO,DATA_CADASTRO) VALUES (1,1,'CLIENTE 01','61368455789','930152878','SSP-DF',NULL,'','2010-06-01','F','N',CURRENT_TIMESTAMP);

INSERT INTO PRODUTO (ID_SUB_GRUPO,ID_UNIDADE,GTIN,NOME_PRODUTO,DESCRICAO,DESCRICAO_PDV,VALOR_COMPRA,VALOR_VENDA,QTD_ESTOQUE,ESTOQUE_MIN,ESTOQUE_MAX,EXCLUIDO,DATA_CADASTRO) VALUES (1,1,NULL,'CANETA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP),(1,1,NULL,'LAPIS',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP),(2,1,NULL,'CADERNO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP),(2,1,NULL,'REGUA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP),(4,1,NULL,'CELTA',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP),(4,1,NULL,'PALIO',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP);

INSERT INTO BANCO (CODIGO,NOME,URL) VALUES (1,'BANCO DO BRASIL','BB.COM'),(237,'BRADESCO','BRADESCO.COM'),(555,'ITAU','ITAU.COM');

INSERT INTO SETOR (EMPRESA_ID,NOME,DESCRICAO) VALUES (1,'INFORMATICA',NULL),(1,'VENDAS','SETOR DE VENDAS'),(1,'RECURSOS HUMANOS','RECURSOS HUMANOS');

INSERT INTO FORNECEDOR (SITUACAO_FOR_CLI_ID,TIPO_FORNECEDOR_ID,ID_EMPRESA,NOME,CPF_CNPJ,RG,ORGAO_RG,INSCRICAO_ESTADUAL,INSCRICAO_MUNICIPAL,DESDE,TIPO_PESSOA,EXCLUIDO,DATA_CADASTRO) VALUES (1,1,1,'FORNECEDOR 01',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP),(1,1,1,'FORNECEDOR 02',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,CURRENT_TIMESTAMP);

INSERT INTO COLABORADOR (NIVEL_FORMACAO_ID,TIPO_COLABORADOR_ID,CARGO_ID,ID_SETOR,NOME,CPF,RG,ORGAO_RG,DATA_NASCIMENTO,TIPO_SANGUINEO,FOTO_34,EXCLUIDO,DATA_CADASTRO) VALUES (1,1,1,1,'ALBERT','12345678910','123','SSP-CE','1977-04-22','A+',NULL,'N',CURRENT_TIMESTAMP);

INSERT INTO CIDADE (ESTADO_ID,NOME,CODIGO_IBGE) VALUES (1,'BRASILIA',53123),(2,'FORTALEZA',19123);

INSERT INTO USUARIO (PAPEL_ID,COLABORADOR_ID,LOGIN,SENHA,DATA_CADASTRO) VALUES (1,1,'ALBERT','123',NULL);

INSERT INTO CONTATO (EMPRESA_ID,COLABORADOR_ID,CLIENTE_ID,FORNECEDOR_ID,NOME,DONO) VALUES (1,1,1,1,'JOAO','C');

INSERT INTO CEP (CIDADE_ID,CEP,LOGRADOURO,BAIRRO) VALUES (1,'60763560','RUA 107','CENTRO'),(1,'60763561','RUA 108','CENTRO');

INSERT INTO AGENCIA_BANCO (CEP_ID,BANCO_ID,CODIGO,NOME,ENDERECO,TELEFONE,GERENTE,CONTATO,OBS) VALUES (1,1,1522,'AG AGUAS CLARAS',NULL,NULL,'NUNES',NULL,NULL),(1,2,666,'666','RUA 107','666','666','666','666'),(1,1,77,'77','RUA 107','77','77','77','77'),(1,1,66,'66','66','66','66','66','66'),(1,2,987,'987','RUA 107','987','987','987','987'),(1,2,789789,'789789','RUA 107','789789','789789','789789','789789'),(1,2,8787,'AGENCIA 87879','RUA 107','87878787','GERENTE 8787','CONTATO 8787','8787'),(1,3,8798,'ITAU555','RUA 107','ITAU555','ITAU555','ITAU555','ITAU555'),(1,2,474747,'47','RUA 107','47','47','47','47'),(1,1,445566,'445566','RUA 107','445566','445566','445566','445566'),(1,3,9966,'9966','RUA 107','9966','9966','9966','9966'),(1,3,555888,'555888','RUA 107','555888','555888','555888','555888');

INSERT INTO CONTATO_TELEFONE (TIPO_TELEFONE_ID,CONTATO_ID,TELEFONE) VALUES (1,1,'6154875487');

INSERT INTO CONTATO_EMAIL (TIPO_EMAIL_ID,CONTATO_ID,EMAIL) VALUES (1,1,'adm@senai.com');

INSERT INTO ENDERECO (EMPRESA_ID,COLABORADOR_ID,FORNECEDOR_ID,CLIENTE_ID,TIPO_ENDERECO_ID,CEP_ID,LOGRADOURO,NUMERO,COMPLEMENTO,BAIRRO,DONO) VALUES (1,1,1,1,1,1,'RUA 107',281,'','CENTRO','C'),(1,1,1,1,2,1,'RUA 108',291,NULL,'CENTRO','C');

insert into COLABORADOR (NIVEL_FORMACAO_ID,
TIPO_COLABORADOR_ID, CARGO_ID, ID_SETOR,
NOME, CPF, RG, ORGAO_RG, DATA_NASCIMENTO,
TIPO_SANGUINEO, FOTO_34, EXCLUIDO,
DATA_CADASTRO) VALUES (2,1,3,1,'JOÃO',
'66546556','245435','SSP/DF','2002-10-02',
'O+',NULL,'1','2022-12-22'),(1,1,2,1,'MARIA',
'6465465','232123','SSP/DF','2008-11-09',
'O+',NULL,'1','2022-12-22'),(1,1,2,1,'PAULO',
'6576578548','2365655','SSP/SP','2000-06-23',
'O+',NULL,'1','2022-12-22'),(1,1,4,1,'LUIZA',
'767665','267432','SSP/RS','1990-04-13',
'O+',NULL,'1','2022-12-22');

insert into endereco(EMPRESA_ID,COLABORADOR_ID,FORNECEDOR_ID,CLIENTE_ID,TIPO_ENDERECO_ID,CEP_ID,LOGRADOURO,NUMERO,COMPLEMENTO,BAIRRO,DONO)
values (1,1,1,1,1,1,'QUADRA 104','23','SETOR COMERCIAL SUL','TAGUATINGA','C'),
(1,2,1,1,1,1,'RUA NORTE','14','SETOR COMERCIAL NORTE','TAGUATINGA','C'),
(1,3,1,1,1,1,'QUADRA 21','105','SETOR HOTELEIRO','ASA NORTE','C'),
(1,4,1,1,1,1,'QUADRA 111','306','SQS','ASA SUL','C'),
(1,5,1,1,1,1,'RUA 07','27','SETOR DE CHACARA','SAMAMBAIA','C');

INSERT INTO CEP(CIDADE_ID,CEP,LOGRADOURO,BAIRRO) VALUES
(2,'73223440','RUA 13','PELORINHO'),(2,'71424432','RUA 13','JARDINS'),
(1,'75943743','QUADRA 115','ASA SUL'),(1,'70263721','QUADRA 202','ASA NORTE'),
(1,'71788320','QUADRA 302','SUDOESTE');

insert into fornecedor(SITUACAO_FOR_CLI_ID,TIPO_FORNECEDOR_ID,ID_EMPRESA,NOME,CPF_CNPJ,RG,ORGAO_RG,INSCRICAO_ESTADUAL,INSCRICAO_MUNICIPAL,DESDE,TIPO_PESSOA,EXCLUIDO,DATA_CADASTRO)
values(1,1,1,'JOÃO','254543543','454543234','ssp/df','54545435','4554354',null,'1','1','2022-03-01'),
(1,1,1,'Maria','4636536','34343344','ssp/df','6345653','4555654',null,'1','1','2022-01-02');

insert into CONTATO(EMPRESA_ID,COLABORADOR_ID,
CLIENTE_ID,FORNECEDOR_ID,NOME,DONO) VALUES (1,1,1,1,'JUNDIAI',NULL);

INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Cadastro de Usuários', 'cad_usuario.jpg', 'adicionarUsuario');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Consulta de Produtos', 'consulta_produto.jpg', 'consultarProdutos');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Relatório de Vendas', 'relatorio_vendas.jpg', 'gerarRelatorioVendas');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Configurações do Sistema', 'config_sistema.jpg', 'acessarConfiguracoes');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Gestão de Estoque', 'gestao_estoque.jpg', 'gerenciarEstoque');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Suporte Técnico', 'suporte_tecnico.jpg', 'acessarSuporte');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Cadastro de Fornecedores', 'cad_fornecedor.jpg', 'adicionarFornecedor');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Agenda de Compromissos', 'agenda_compromissos.jpg', 'gerenciarAgenda');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Notificações do Sistema', 'notificacoes_sistema.jpg', 'verNotificacoes');
INSERT INTO FUNCAO (DESCRICAO_MENU, IMAGEM_MENU, METODO) VALUES ('Gerenciamento de Permissões', 'ger_permissoes.jpg', 'editarPermissoes');


INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Sul', 'XYZ Sul', '23456789012345', 'IE234567', 'IM234567', 'F', '2023-01-02');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Norte', 'XYZ Norte', '34567890123456', 'IE345678', 'IM345678', 'F', '2023-01-03');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Leste', 'XYZ Leste', '45678901234567', 'IE456789', 'IM456789', 'F', '2023-01-04');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Oeste', 'XYZ Oeste', '56789012345678', 'IE567890', 'IM567890', 'F', '2023-01-05');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Nordeste', 'XYZ Nordeste', '67890123456789', 'IE678901', 'IM678901', 'F', '2023-01-06');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Sudeste', 'XYZ Sudeste', '78901234567890', 'IE789012', 'IM789012', 'F', '2023-01-07');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Centro-Oeste', 'XYZ Centro-Oeste', '89012345678901', 'IE890123', 'IM890123', 'F', '2023-01-08');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Suldeste', 'XYZ Suldeste', '90123456789012', 'IE901234', 'IM901234', 'F', '2023-01-09');
INSERT INTO EMPRESA (EMPRESA_ID, RAZAO_SOCIAL, NOME_FANTASIA, CNPJ, INSCRICAO_ESTADUAL, INSCRICAO_MUNICIPAL, MATRIZ_FILIAL, DATA_CADASTRO) VALUES (1, 'XYZ Filial Externa', 'XYZ Externa', '01234567890123', 'IE012345', 'IM012345', 'F', '2023-01-10');

update produto set VALOR_COMPRA = 1.25, VALOR_VENDA = 2.5, QTD_ESTOQUE = 50 where id = 1;
update produto set VALOR_COMPRA = 1, VALOR_VENDA = 2, QTD_ESTOQUE = 100 where id = 2;
update produto set VALOR_COMPRA = 3, VALOR_VENDA = 5.5, QTD_ESTOQUE = 70 where id = 3;
update produto set VALOR_COMPRA = 2.5, VALOR_VENDA = 4, QTD_ESTOQUE = 90 where id = 4;
update produto set VALOR_COMPRA = 24000, VALOR_VENDA = 26500, QTD_ESTOQUE = 1 where id = 5;
update produto set VALOR_COMPRA = 28000, VALOR_VENDA = 29700, QTD_ESTOQUE = 1 where id = 6;

insert into fornecedor_produto (FORNECEDOR_ID,PRODUTO_ID) values (1,1),(1,2),(1,3),(1,4),(3,5),(4,6);
update fornecedor set cpf_cnpj = "33.564.543/0001-90" where id = 1;
update fornecedor set nome = "SENAI ATACADISTA E VAREJO" where id = 1;



