/*=================================================== AULA 04 ===================================================*/

CREATE TABLE teste_priv (cod NUMBER(1), texto CHAR (1));
ALTER TABLE teste_priv MODIFY texto VARCHAR(10);
DROP TABLE teste_priv;

CREATE TABLE teste_priv (cod NUMBER(1), texto CHAR (10));

INSERT INTO teste_priv VALUES (1,'aaaaa');

CREATE SEQUENCE teste_id_seq INCREMENT BY 1 START WITH 2 NOCACHE;

INSERT INTO teste_priv VALUES (teste_id_seq.NEXTVAL, 'bbbbb');

CREATE VIEW v_teste_priv AS SELECT texto FROM teste_priv;

CREATE TABLE HR.teste_priv2 (id NUMBER(1), descricao CHAR(1));

CREATE VIEW HR.v_teste_priv2 AS SELECT descricao FROM HR.teste_priv2;

INSERT INTO hr.teste_priv2 VALUES (5, 'e');

GRANT select, insert
ON HR.clube
TO MARIA;

/*=================================================== AULA 05 ===================================================*/

SELECT id, nome, salario 
FROM hr.atleta
WHERE nome LIKE 'Miquela Malloy';

SELECT *
FROM hr.atleta
WHERE id = 199;

SELECT * 
FROM hr.atleta
WHERE nome = 'Rebeca Andrade';

SELECT salario FROM hr.atleta WHERE nome = 'Lambert Taffs';

UPDATE hr.atleta SET salario = 9000 WHERE nome = 'Lambert Taffs';

/* ====================================== EXERC�CIO ======================================*/

/*3. Abra uma nova sess�o como JOSE e fa�a um DESC na tabela EMP_TEMP do
usu�rio HR. O usu�rio JOSE j� enxerga a tabela EMP_TEMP? Por qu�?*/

DESCRIBE hr.EMP_TEMP;
/* N�o, pois ainda n�o foi efetivado o commit para que o JOSE possa ter visibilidade*/

/*5. Como JOSE, voc� j� enxerga os 2 registros inseridos? Por qu�?*/

select * from hr.EMP_TEMP;
/* N�o, pois ainda n�o foi efetivado o commit para que o JOSE possa ter visibilidade*/

/*8. Como JOSE, voc� j� enxerga os 2 registros inseridos? Por qu�?*/

select * from hr.EMP_TEMP;
/* Sim, pois foi realizado o COMMIT*/

/*10. Como JOSE, fa�a um SELECT na EMP_TEMP. Quantos registros aparecem? Por
qu�?*/

select * from hr.DEP_TEMP;
/*N�o, pois n�o foi dado a permiss�o de consulta ou qualquer outra para Jose nesta tabela do HR*/

/*13. Como JOSE, marque um SAVEPOINT chamado SP1. Apague 1 registro da tabela
HR.EMP_TEMP. Marque agora um novo SAVEPOINT chamado SP2. Apague
outro registro qualquer da tabela EMP_TEMP. Consulte a tabela EMP_TEMP
como JOSE e como HR. Quantos registros aparecem para cada um?*/

SAVEPOINT SP1;

delete hr.emp_temp where COD = 3;

SAVEPOINT SP2;

delete hr.emp_temp where COD = 4;
/* Para Jose aparece apenas 2 registros, para HR aparece 6 registros como se n�o tivesse apagado*/

/*14. Como JOSE, execute o comando ROLLBACK. O que aconteceu? Por qu�?*/

ROLLBACK;
/*Ambos deletes foram desfeitos, por que voltou ao estado natural da tabela como estava antes dos deletes*/

/*15. Execute novamente as instru��es do item 13.*/
SAVEPOINT SP1;

delete hr.emp_temp where COD = 3;

SAVEPOINT SP2;

delete hr.emp_temp where COD = 4;

/*16. Como JOSE, desfa�a agora somente o �ltimo DELETE realizado. Consulte a
tabela EMP_TEMP como HR e como JOSE e veja quantos registros aparecem
para cada um.*/

ROLLBACK TO SP2;

select * from hr.emp_temp;

/*17. Como JOSE, efetive todas as altera��es pendentes. Consulte a tabela
EMP_TEMP como HR e como JOSE e veja quantos registros aparecem para cada
um agora.*/

COMMIT;

SELECT * from hr.emp_temp;

/*18 parte 02*/

update hr.EMP_TEMP set sal = 350 where COD = 2;
select * from hr.emp_temp;

/*20. Como JOSE, torne as altera��es pendentes permanentes no banco. Fa�a um
SELECT no registro alterado nas duas sess�es e compare*/

COMMIT;
select * from hr.emp_temp;




