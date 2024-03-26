SELECT
f.nome,
f.data_cadastro,
c.nome as nome_do_contato,
c2.cpf,
c2.nome as nome_do_colaborador,
c2.data_nascimento as dtn_colaborador,
c2.data_cadastro as dtc_colaborador,
c2.rg as rg_colaborador,
c2.orgao_rg as orgao_uf_colaborador,
s.nome as nome_setor
FROM
fornecedor as f
INNER JOIN tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
INNER JOIN empresa e on f.id_empresa = e.id
INNER JOIN contato c on e.id = c.empresa_id
INNER JOIN colaborador c2 on c.colaborador_id = c2.id
INNER JOIN setor s on c2.id_setor = s.id
WHERE
    f.cpf_cnpj = 254543543
;

1º Metodo de fazer
SELECT
    c.nome AS nome_do_colaborador,
    c.cpf,
    c3.nome AS cargo,
    c3.salario AS salario,
    CASE
        WHEN c3.salario <= 1212 THEN c3.salario * 0.075
        WHEN c3.salario > 1212 AND c3.salario <= 2424.35 THEN c3.salario * 0.09
        WHEN c3.salario > 2424.36 AND c3.salario <= 3641.03 THEN c3.salario * 0.12
        WHEN c3.salario > 3641.04 AND c3.salario <= 7087.22 THEN c3.salario * 0.14
        ELSE c3.salario * 0.14
    END AS aliquota_inss,
    CASE
        WHEN c3.salario <= 1903.98 THEN c3.salario = 0
        WHEN c3.salario >= 1903.99 AND c3.salario <= 2826.65 THEN c3.salario * 0.075
        WHEN c3.salario >= 2826.66 AND c3.salario <= 3751.05 THEN c3.salario * 0.15
        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN c3.salario * 0.225
        ELSE c3.salario * 0.275
    END AS aliquota_irrf,
    c3.salario  -   (CASE
                        WHEN c3.salario <= 1212 THEN c3.salario * 0.075
                        WHEN c3.salario > 1212 AND c3.salario <= 2424.35 THEN c3.salario * 0.09
                        WHEN c3.salario > 2424.36 AND c3.salario <= 3641.03 THEN c3.salario * 0.12
                        WHEN c3.salario > 3641.04 AND c3.salario <= 7087.22 THEN c3.salario * 0.14
                        ELSE c3.salario * 0.14
                        END +
                     CASE
                        WHEN c3.salario <= 1903.98 THEN c3.salario = 0
                        WHEN c3.salario >= 1903.99 AND c3.salario <= 2826.65 THEN c3.salario * 0.075
                        WHEN c3.salario >= 2826.66 AND c3.salario <= 3751.05 THEN c3.salario * 0.15
                        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN c3.salario * 0.225
                        ELSE c3.salario * 0.275
                    END)
    as salario_liquido
FROM
colaborador AS c
LEFT JOIN contato c2 ON c.id = c2.colaborador_id
inner JOIN cargo c3 ON c.cargo_id = c3.id;
;

2º Metodo de fazer
SELECT
    c.nome AS nome_do_colaborador,
    c.cpf,
    c3.nome AS cargo,
    c3.salario AS salario,
    CASE
        WHEN c3.salario <= 1212.00 THEN c3.salario * 0.075
        WHEN c3.salario >= 1212.01 AND c3.salario <= 2427.35 THEN c3.salario * 0.09
        WHEN c3.salario >= 2427.36 AND c3.salario <= 3641.03 THEN c3.salario * 0.12
        WHEN c3.salario >= 3641.04 AND c3.salario <= 7087.22 THEN c3.salario * 0.14
        ELSE c3.salario * 0.14
    END AS aliquota_inss,
    CASE
        WHEN c3.salario <= 1903.98 THEN c3.salario = 0
        WHEN c3.salario >= 1903.99 AND c3.salario <= 2826.65 THEN c3.salario * 0.075
        WHEN c3.salario >= 2826.66 AND c3.salario <= 3751.05 THEN c3.salario * 0.15
        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN c3.salario * 0.225
        ELSE c3.salario * 0.275
    END AS aliquota_irrf,
    CASE
        WHEN c3.salario <= 1212.00 THEN c3.salario - (c3.salario * 0.075) -- inss(0.075) + irrf(0)
        WHEN c3.salario >= 1212.01 AND c3.salario <= 1903.98 THEN c3.salario - (c3.salario * 0.09) -- inss(0.09) + irrf(0)
        WHEN c3.salario >= 1903.99 AND c3.salario <= 2427.35 THEN  c3.salario - (c3.salario * 0.165) -- inss(0.09) + irrf(0.075)
        WHEN c3.salario >= 2427.36 AND c3.salario <= 2826.65 THEN  c3.salario - (c3.salario * 0.195)  -- inss(0.12) + irrf(0.075)
        WHEN c3.salario >= 2826.66 AND c3.salario <= 3641.03 THEN  c3.salario - (c3.salario * 0.27)  -- inss(0.12) + irrf(0.15)
        WHEN c3.salario >= 3641.04 AND c3.salario <= 3751.05 THEN  c3.salario - (c3.salario * 0.29)  -- inss(0.14) + irrf(0.15)
        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN  c3.salario - (c3.salario * 0.365)  -- inss(0.14) + irrf(0.225)
        WHEN c3.salario >= 4664.69 AND c3.salario <= 7087.22 THEN c3.salario - (c3.salario * 0.415)-- inss(0.14) + irrf(0.275)
        WHEN c3.salario >= 7087.23 THEN c3.salario - (c3.salario * 0.415)-- inss(0.14) + irrf(0.275)
    END AS salario_liquido
FROM
colaborador AS c
LEFT JOIN contato c2 ON c.id = c2.colaborador_id
inner JOIN cargo c3 ON c.cargo_id = c3.id
;

-- 1. COUNT, AND

SELECT
    c.nome AS nome_do_colaborador,
    c.cpf,
    c3.nome AS cargo,
    c3.salario AS salario,
    CASE
        WHEN c3.salario <= 1212 THEN c3.salario * 0.075
        WHEN c3.salario > 1212 AND c3.salario <= 2427.35 THEN c3.salario * 0.09
        WHEN c3.salario > 2427.36 AND c3.salario <= 3641.03 THEN c3.salario * 0.12
        WHEN c3.salario > 3641.04 AND c3.salario <= 7087.22 THEN c3.salario * 0.14
        ELSE c3.salario * 0.14
    END AS aliquota_inss,
    CASE
        WHEN c3.salario <= 1903.98 THEN c3.salario = 0
        WHEN c3.salario >= 1903.99 AND c3.salario <= 2826.65 THEN c3.salario * 0.075
        WHEN c3.salario >= 2826.66 AND c3.salario <= 3751.05 THEN c3.salario * 0.15
        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN c3.salario * 0.225
        ELSE c3.salario * 0.275
    END AS aliquota_irrf,
    c3.salario  -   (CASE
                        WHEN c3.salario <= 1212 THEN c3.salario * 0.075
                        WHEN c3.salario > 1212 AND c3.salario <= 2427.35 THEN c3.salario * 0.09
                        WHEN c3.salario > 2427.36 AND c3.salario <= 3641.03 THEN c3.salario * 0.12
                        WHEN c3.salario > 3641.04 AND c3.salario <= 7087.22 THEN c3.salario * 0.14
                        ELSE c3.salario * 0.14
                        END +
                     CASE
                        WHEN c3.salario <= 1903.98 THEN c3.salario = 0
                        WHEN c3.salario >= 1903.99 AND c3.salario <= 2826.65 THEN c3.salario * 0.075
                        WHEN c3.salario >= 2826.66 AND c3.salario <= 3751.05 THEN c3.salario * 0.15
                        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN c3.salario * 0.225
                        ELSE c3.salario * 0.275
                    END)
    as salario_liquido
FROM
colaborador AS c
LEFT JOIN contato c2 ON c.id = c2.colaborador_id
inner JOIN cargo c3 ON c.cargo_id = c3.id;

;

-- 2. COUNT, AND

SELECT
    c.nome AS nome_do_colaborador,
    c.cpf,
    c3.descricao AS cargo,
    c3.salario AS salario,
    CASE
        WHEN c3.salario <= 1212.00 THEN c3.salario * 0.075
        WHEN c3.salario >= 1212.01 AND c3.salario <= 2427.35 THEN c3.salario * 0.09
        WHEN c3.salario >= 2427.36 AND c3.salario <= 3641.03 THEN c3.salario * 0.12
        WHEN c3.salario >= 3641.04 AND c3.salario <= 7087.22 THEN c3.salario * 0.14
        ELSE c3.salario * 0.14
    END AS aliquota_inss,
    CASE
        WHEN c3.salario <= 1903.98 THEN c3.salario = 0
        WHEN c3.salario >= 1903.99 AND c3.salario <= 2826.65 THEN c3.salario * 0.075
        WHEN c3.salario >= 2826.66 AND c3.salario <= 3751.05 THEN c3.salario * 0.15
        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN c3.salario * 0.225
        ELSE c3.salario * 0.275
    END AS aliquota_irrf,
    CASE
        WHEN c3.salario <= 1212.00 THEN c3.salario - (c3.salario * 0.075) -- inss(0.075) + irrf(0)
        WHEN c3.salario >= 1212.01 AND c3.salario <= 1903.98 THEN c3.salario - (c3.salario * 0.09) -- inss(0.09) + irrf(0)
        WHEN c3.salario >= 1903.99 AND c3.salario <= 2427.35 THEN  c3.salario - (c3.salario * 0.165) -- inss(0.09) + irrf(0.075)
        WHEN c3.salario >= 2427.36 AND c3.salario <= 2826.65 THEN  c3.salario - (c3.salario * 0.195)  -- inss(0.12) + irrf(0.075)
        WHEN c3.salario >= 2826.66 AND c3.salario <= 3641.03 THEN  c3.salario - (c3.salario * 0.27)  -- inss(0.12) + irrf(0.15)
        WHEN c3.salario >= 3641.04 AND c3.salario <= 3751.05 THEN  c3.salario - (c3.salario * 0.29)  -- inss(0.14) + irrf(0.15)
        WHEN c3.salario >= 3751.06 AND c3.salario <= 4664.68 THEN  c3.salario - (c3.salario * 0.365)  -- inss(0.14) + irrf(0.225)
        WHEN c3.salario >= 4664.69 AND c3.salario <= 7087.22 THEN c3.salario - (c3.salario * 0.415)-- inss(0.14) + irrf(0.275)
        WHEN c3.salario >= 7087.23 THEN c3.salario - (c3.salario * 0.415)-- inss(0.14) + irrf(0.275)
    END AS salario_liquido
FROM
colaborador AS c
RIGHT JOIN cargo c3 ON c.cargo_id = c3.id
;


-- 3. COUNT, BETWEEN, AND

select
c.NOME nome_funcionario,
c.cpf,
ca.DESCRICAO cargo,
ca.SALARIO,
case
when ca.SALARIO <= 1212 then ca.SALARIO * 0.075
-- when ca.SALARIO > 1212 and ca.salario <= 2427.35 then ca.SALARIO * 0.09
when ca.salario between 1212.01 and 2427.35 then ca.SALARIO * 0.09
when ca.salario between 2427.36 and 3641.03 then ca.SALARIO * 0.12
when ca.salario between 3641.04 and 7087.22 then ca.salario * 0.14
when ca.salario > 7087.22 then ca.salario * 0.14
end inss,
case
when ca.salario <= 1903.98 then 0
when ca.salario between 1903.99 and 2826.65 then ca.salario * 0.075
when ca.salario between 2826.66 and 3751.05 then ca.salario * 0.15
when ca.salario between 3751.06 and 4664.68 then ca.salario * 0.225
when ca.salario > 4664.68 then ca.salario * 0.275
end irrf,
case
when ca.salario < 1212 then ca.SALARIO * 0.075
when ca.salario between 1213 and 1903.98 then ca.salario - (ca.salario * 0.09)
when ca.salario between 1903.99 and 2427.35 then ca.salario - (ca.salario * 0.165)
when ca.salario between 2427.36 and 2826.65 then ca.salario - (ca.salario * 0.195)
when ca.salario between 2826.66 and 3641.03 then ca.salario - (ca.salario * 0.27)
when ca.salario between 3641.04 and 3751.05 then ca.salario - (ca.salario * 0.29)
when ca.salario between 3751.06 and 4664.68 then ca.salario - (ca.salario * 0.365)
when ca.salario between 4664.69 and 7087.22 then ca.salario - (ca.salario * 0.415)
when ca.salario > 7087.22 then ca.salario - (ca.SALARIO * 0.415)
end salario_liquido
from colaborador c
inner join cargo ca on ca.ID = c.CARGO_ID
;

-- AND

SELECT * FROM colaborador WHERE nome = "Albert" AND tipo_sanguineo = "A+";

-- OR

SELECT * FROM colaborador WHERE nome = "Albert" OR tipo_sanguineo = "AB+";

-- AND, NOT

SELECT * FROM colaborador WHERE nome = "Albert" AND tipo_sanguineo = "A+" AND foto_34 IS NOT NULL;

SELECT * FROM colaborador WHERE nome = "Albert" AND tipo_sanguineo = "A+"
                             OR foto_34 IS NOT NULL;

SELECT * FROM colaborador WHERE nome = "Albert" AND tipo_sanguineo = "A+"
                             AND foto_34 IS NULL;

-- CASE ... WHEN ... END AS


-- COUNT

SELECT COUNT(*) FROM colaborador WHERE tipo_sanguineo = "A+";

SELECT
    tipo_sanguineo,
    COUNT(tipo_sanguineo) AS QT_TIPO_SANGUINEO FROM colaborador
GROUP BY
    tipo_sanguineo
;

-- AVG

SELECT
    avg(ca.salario) media_salarial
    FROM colaborador AS c
INNER JOIN cargo AS ca ON ca.id = c.cargo_id;

-- SUM (SOMA) + COUNT
SELECT
    SUM(ca.salario)/COUNT(C.id) media_salarial
    FROM colaborador AS c
INNER JOIN cargo AS ca ON ca.id = c.cargo_id;

-- Query para retornar quantidade de funcionarios que ganham mais que a media salarial da empresa.
-- utilize o filtro WHERE

-- 1.
select
    -- ca.salario
    count(c.id) as salario_superior_a_media
    from colaborador as c
    inner join cargo as ca on ca.id = c.cargo_id
    where ca.salario >= (SELECT AVG(salario) FROM cargo);

-- 2.
select
    count(c.id)
    -- ca.salario
    from colaborador as c
    inner join cargo as ca on ca.id = c.cargo_id and ca.salario >= 5380;



-- MAX

SELECT
    MAX(CA.salario) as maior_salario
FROM colaborador AS C
INNER JOIN CARGO AS CA ON C.cargo_id = CA.id;

SELECT
    c.nome,
    ca.salario as maior_salario
FROM colaborador AS C
INNER JOIN CARGO AS CA ON C.cargo_id = CA.id
where ca.salario = (select MAX(CA.salario) from colaborador as c
                            inner join cargo as ca on ca.id = c.cargo_id)
;

-- MIN

-- 1.
SELECT
    MIN(CA.salario) as menor_salario
FROM colaborador AS C
INNER JOIN CARGO AS CA ON C.cargo_id = CA.id;
-- 2.
SELECT
    c.nome,
    ca.salario as menor_salario
FROM colaborador AS C
INNER JOIN CARGO AS CA ON C.cargo_id = CA.id
where ca.salario = (select min(CA.salario) from colaborador as c
                            inner join cargo as ca on ca.id = c.cargo_id);

-- LIKE

-- COMEÇA COM 'A'
SELECT
    c.nome
from colaborador as c
where  c.nome LIKE "A%";
-- TERMINA COM 'A'
SELECT
    c.nome
from colaborador as c
where  c.nome LIKE "%A";
-- QUEM TEM 'A'
SELECT
    c.nome
from colaborador as c
where  c.nome LIKE "%A%";


-- LENGTH

SELECT
    c.nome,
    length(c.nome)
from colaborador as c;

-- TRIM, LENGTH

SELECT
    C.ID,
    C.NOME,
    (LENGTH(TRIM(C.NOME)))
FROM colaborador AS C;

UPDATE colaborador SET NOME=' JOÃO' WHERE ID = 2;

-- CONCAT

SELECT CONCAT("R$ ", salario) FROM cargo;

SELECT salario FROM cargo;


-- Referencia
SELECT NOME_FANTASIA FROM empresa;
-- UPPER

SELECT upper(NOME_FANTASIA) FROM empresa;

-- LOWER

SELECT lower(NOME_FANTASIA) FROM empresa;

-- INITCAP(SQL SERVER)
CREATE FUNCTION INITCAP(input_string VARCHAR(255))
RETURNS VARCHAR(255)
BEGIN
    DECLARE result VARCHAR(255);
    DECLARE i INT DEFAULT 1;
    DECLARE c CHAR(1);
    DECLARE prev_c CHAR(1) DEFAULT ' ';

    SET result = LOWER(input_string);

    WHILE i <= LENGTH(input_string) DO
        SET c = SUBSTRING(input_string, i, 1);
        IF prev_c IN (' ', '-', '\t', '\n', '\r') THEN
            SET result = CONCAT(result, UCASE(c));
        END IF;
        SET prev_c = c;
        SET i = i + 1;
    END WHILE;

    RETURN result;
END;

-- Elabore um query que retorne os dados dos:
-- fornecedores: Nome, cpf_cnpj, inscrição_estadual, data_cadastro;
-- tipo_fornecedor: nome e descrição
-- produtor: nome_produto, descrição, qtd_estoque, valor_venda, valor_compra

select
    f.nome nome_fornecedor,
    f.cpf_cnpj,
    f.inscricao_estadual,
    f.data_cadastro,
    tf.nome tipo_fornecedor,
    tf.descricao descricao_fornecedor,
    p.nome_produto,
    p.descricao descricao_produto,
    p.qtd_estoque,
    p.valor_venda,
    p.valor_compra,
    p.valor_venda - p.valor_compra as lucro,
    (p.valor_venda - p.valor_compra)* p.qtd_estoque as lucro_total
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id;

update produto set VALOR_COMPRA = 1.25, VALOR_VENDA = 2.5, QTD_ESTOQUE = 50 where id = 1;
update produto set VALOR_COMPRA = 1, VALOR_VENDA = 2, QTD_ESTOQUE = 100 where id = 2;
update produto set VALOR_COMPRA = 3, VALOR_VENDA = 5.5, QTD_ESTOQUE = 70 where id = 3;
update produto set VALOR_COMPRA = 2.5, VALOR_VENDA = 4, QTD_ESTOQUE = 90 where id = 4;
update produto set VALOR_COMPRA = 24000, VALOR_VENDA = 26500, QTD_ESTOQUE = 1 where id = 5;
update produto set VALOR_COMPRA = 28000, VALOR_VENDA = 29700, QTD_ESTOQUE = 1 where id = 6;

use senaierp;

insert into fornecedor_produto (FORNECEDOR_ID,PRODUTO_ID) values (1,1),(1,2),(1,3),(1,4),(3,5),(4,6);
update fornecedor set cpf_cnpj = "33.564.543/0001-90" where id = 1;
update fornecedor set nome = "SENAI ATACADISTA E VAREJO" where id = 1;
insert into fornecedor_produto (FORNECEDOR_ID,PRODUTO_ID) values (2,1),(2,2),(2,3);

-- 1.Altere a query para mostrar apenas os produtos com QTD_ESTOQUE maior ou igual a 50.
select
    f.nome nome_fornecedor,
    f.cpf_cnpj,
    f.inscricao_estadual,
    f.data_cadastro,
    tf.nome tipo_fornecedor,
    tf.descricao descricao_fornecedor,
    p.nome_produto,
    p.descricao descricao_produto,
    p.qtd_estoque,
    p.valor_venda,
    p.valor_compra,
    p.valor_venda - p.valor_compra as lucro,
    (p.valor_venda - p.valor_compra)* p.qtd_estoque as lucro_total
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id
where p.qtd_estoque >= 50;

-- 2.Ordene os resultados pelo valor_lucro_total em ordem decrescente.
select
    f.nome nome_fornecedor,
    f.cpf_cnpj,
    f.inscricao_estadual,
    f.data_cadastro,
    tf.nome tipo_fornecedor,
    tf.descricao descricao_fornecedor,
    p.nome_produto,
    p.descricao descricao_produto,
    p.qtd_estoque,
    p.valor_venda,
    p.valor_compra,
    p.valor_venda - p.valor_compra as lucro,
    (p.valor_venda - p.valor_compra)* p.qtd_estoque as lucro_total
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id
order by lucro_total desc
;

-- 3. Mostrar o lucro total por fornecedor
select
    f.nome,
    SUM((p.valor_venda - p.valor_compra)* p.qtd_estoque) lucro_agregado
from produto p
inner join fornecedor_produto fp on fp.produto_id = p.id
inner join fornecedor f on f.id = fp.fornecedor_id
group by f.nome
;

-- 4. Mostre o nome do grupo dos produtos.
select
    f.nome nome_fornecedor,
    f.cpf_cnpj,
    f.inscricao_estadual,
    f.data_cadastro,
    tf.nome tipo_fornecedor,
    tf.descricao descricao_fornecedor,
    p.nome_produto,
    p.descricao descricao_produto,
    p.qtd_estoque,
    p.valor_venda,
    p.valor_compra,
    p.valor_venda - p.valor_compra as lucro,
    (p.valor_venda - p.valor_compra)* p.qtd_estoque as lucro_total,
    gp.nome
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id
inner join sub_grupo_produto sgp on p.id_sub_grupo = sgp.id
inner join grupo_produto gp on sgp.id_grupo = gp.id;

-- todas as instruções
select
    f.nome nome_fornecedor,
    f.cpf_cnpj,
    f.inscricao_estadual,
    f.data_cadastro,
    tf.nome tipo_fornecedor,
    tf.descricao descricao_fornecedor,
    p.nome_produto,
    p.descricao descricao_produto,
    p.qtd_estoque,
    p.valor_venda,
    p.valor_compra,
    p.valor_venda - p.valor_compra as lucro,
    (p.valor_venda - p.valor_compra)* p.qtd_estoque as lucro_total,
        (select SUM((p.valor_venda - p.valor_compra)* p.qtd_estoque)
                from fornecedor_produto as pf
                inner join produto as p on pf.produto_id = p.id
                where pf.fornecedor_id = f.id) as lucro_total_fornecedor,
    gp.nome
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id
inner join sub_grupo_produto sgp on p.id_sub_grupo = sgp.id
inner join grupo_produto gp on sgp.id_grupo = gp.id
where qtd_estoque >= 50
order by (p.valor_venda - p.valor_compra)* p.qtd_estoque desc;

-- Venda por grupo_produto
select
    SUM((p.valor_venda - p.valor_compra)* p.qtd_estoque),
    gp.nome
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id
inner join sub_grupo_produto sgp on p.id_sub_grupo = sgp.id
inner join grupo_produto gp on sgp.id_grupo = gp.id
group by
    gp.nome;

-- order by lucro_fornecedor e mostar grupos;
select
    f.nome nome_fornecedor,
    f.cpf_cnpj,
    SUM((p.valor_venda - p.valor_compra)* p.qtd_estoque)  as lucro_total_fornecedor,
    gp.nome nome_grupo
from fornecedor as f
inner join tipo_fornecedor tf on f.tipo_fornecedor_id = tf.id
inner join fornecedor_produto fp on f.id = fp.fornecedor_id
inner join produto p on fp.produto_id = p.id
inner join sub_grupo_produto sgp on p.id_sub_grupo = sgp.id
inner join grupo_produto gp on sgp.id_grupo = gp.id
group by
    f.nome, f.cpf_cnpj, gp.nome
order by lucro_total_fornecedor desc
;

CREATE FUNCTION formatar_celular (telefone VARCHAR(11))
RETURNS VARCHAR(15)
DETERMINISTIC
BEGIN
RETURN CONCAT('(', SUBSTRING(telefone, 1, 2), ') ', SUBSTRING(telefone, 3, 5),
'-', SUBSTRING(telefone, 8, 4));
END;
-- (61) 99345-6546
drop function formatar_telefone;

select formatar_celular("61993456546");

select * from contato_telefone;

select
formatar_telefone(telefone) telefone_formATADO
from contato_telefone;


DELIMITER $$

create function retorna_idade (dataNascimento date)
RETURNS int
deterministic
begin
return timestampdiff(YEAR, dataNascimento, curdate());
end $$
delimiter ;

SELECT
DATA_NASCIMENTO,
retorna_idade(DATA_NASCIMENTO) IDADE
FROM COLABORADOR;

-- Função para obter a quantidade de produtos por fornecedor
-- 1.
CREATE FUNCTION quant_prod_forne (id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_estoque INT;

    SELECT SUM(p.qtd_estoque) INTO total_estoque
    FROM fornecedor AS f
    INNER JOIN tipo_fornecedor AS tf ON f.tipo_fornecedor_id = tf.id
    INNER JOIN fornecedor_produto AS fp ON f.id = fp.fornecedor_id
    INNER JOIN produto AS p ON fp.produto_id = p.id
    WHERE f.id = id;

    RETURN total_estoque;
END;


drop function quant_prod_forne;

select nome, quant_prod_forne(id) from fornecedor;

-- 2.
create function qt_produto_fornecedor (idFornecedor int)
returns int
deterministic
begin
    declare qtdProdutos int;

    select count(*) into qtdProdutos
    from fornecedor_produto where fornecedor_id = idFornecedor;

    return qtdProdutos;
end;
;

select
    nome,
    qt_produto_fornecedor(id)
    from fornecedor;


-- Função para Obter Endereço Completo de um Cliente

-- 1.
CREATE FUNCTION endereco_cliente (idCliente INT)
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
    DECLARE endereco_completo VARCHAR(1000);

    SELECT CONCAT(e.logradouro, ' ', e.numero, ', ', e.complemento, ', ', e.bairro)
    INTO endereco_completo
    FROM cliente AS c
    inner JOIN endereco AS e ON c.id = e.cliente_id
    inner JOIN cep AS ce ON e.cep_id = ce.id
    WHERE c.id = idCliente limit 1;

    RETURN endereco_completo;
END;
;
drop function endereco_cliente;

select endereco_cliente(id) from cliente;

-- 2.
CREATE FUNCTION enderecoCompleto (idCliente int)
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN
    DECLARE enderecoCompleto varchar(1000);

    SELECT
        CONCAT(E.logradouro,' ', E.NUMERO,' ', E.COMPLEMENTO,' ', E.BAIRRO)
    INTO enderecoCompleto
    FROM endereco AS E
    INNER JOIN cep AS CE ON CE.ID = E.cep_id
    WHERE
        idCliente = cliente_id;

END;
