use imobiliaria;
-- Tabela Cliente
select * from cliente

-- Tabela Contacto de Cliente
select * from ContactoCliente

-- Tabela Contact de Funcionario
select * from ContactoFuncionario

-- Tabela de Funcionarios
select * from Funcionario

-- Tabela de Imoveis
select * from Imovel

-- Tabela de Transações
select * from Transacao


-- Procedimento que procura se já existe Email E e Telemovel T

Delimiter &&
	CREATE PROCEDURE existeContactoC(E varchar(45),T int)
		BEGIN
		DECLARE flag int default  0;
        DECLARE flag2 int default 0;
			Select  Count(Email) into flag
				from ContactoCliente
			Where email = E;
		Select  Count(Telemovel) into flag2
				from ContactoCliente
			Where Telemovel = T;
		IF (flag > 0 and flag2>0 ) then Select 'Ja Existe' as Email, 'Ja Existe' as Telemovel;
			ELSEIF (flag>0 and flag2=0) then Select 'Ja Existe' as Email;
				ELSEIF ( flag2 >0) then Select 'Ja Existe' as Telemovel;
        END IF;
		END
&&



-- Criar Um Novo Contacto
Delimiter &&
	Create Procedure FichaContactoCliente(E varchar(45),T int)
    BEGIN
		if(E like '%@%.%') then
		insert into ContactoCliente(Email,Telemovel)
			values(E,T);
		END IF;
	END
&&

--
--   
-- Inserir Novo Cliente
--
--
Delimiter &&
	Create Procedure FichaCliente(C int,N varchar(45),iCC int)
    BEGIN
		DECLARE flag int default 0;
		Select COUNT(Contribuinte) into flag
			From Cliente
            Where Contribuinte = C;
        if (flag=0) then    
			insert into Cliente(Contribuinte,Nome,idContactoCliente)
			values(C,N,iCC);
        END IF;
	END
    
    &&
    
-- Criar Um Novo Contacto
Delimiter &&
	Create Procedure FichaContactoF(E varchar(45),T int)
    BEGIN
		if(E like '%@%.%') then
		insert into ContactoFuncionario(Email,Telemovel)
			values(E,T);
		END IF;
	END
&&
--
-- Existe este Contacto no Funcionario
--
Delimiter &&
	CREATE PROCEDURE existeContactoF(E varchar(45),T int)
		BEGIN
		DECLARE flag int default  0;
        DECLARE flag2 int default 0;
			Select  Count(Email) into flag
				from ContactoFuncionario
			Where email = E;
		Select  Count(Telemovel) into flag2
				from ContactoFuncionario
			Where Telemovel = T;
		IF (flag > 0 and flag2>0 ) then Select 'Ja Existe' as Email, 'Ja Existe' as Telemovel;
			ELSEIF (flag>0 and flag2=0) then Select 'Ja Existe' as Email;
				ELSEIF ( flag2 >0) then Select 'Ja Existe' as Telemovel;
        END IF;
		END
&&
--
-- Criar Ficha Funcionario
--
Delimiter &&
	Create Procedure FichaFuncionario(N varchar(45),idCF int)
    BEGIN
		insert into Funcionario(Nome,idContactoFuncionario)
        values(N,idCF);
	END
    
    &&

--    
-- Inserir um Imovel.    
--
Delimiter &&
	Create Procedure InserirImovel(T varchar(45), A int, Cond varchar(45),V int,idC int,M varchar(45),idF int)
    BEGIN
    DECLARE flag int default 0;
		Select count(idImovel)into flag
			from Imovel
            WHERE Morada = M;
	IF ((STRCMP('Loja',T) or STRCMP('Apartamento',T) or STRCMP('Terreno',T) or strcmp('Moradia',T)and(strcmp(A,'Alugado') or strcmp(A,'Aluguer')or strcmp(A,'Vendido') or strcmp(A,'Venda'))and(V > 0))and(flag=0)) then
		insert into Imovel(Tipo,Area,Condicao,Valor,idCliente,Morada,idFuncionario)
		values(T,A,Cond,V,idC,M,idF);
	END IF;
    END
	&&

--
-- Efetuar uma Transacao
--
Delimiter &&
	Create Procedure Transacao(dI DATE,dF DATE,idI int, idC int,idF int, V int)
	BEGIN
		DECLARE flag INT default 0;
        SELECT COUNT(idImovel) into flag
			FROM Cliente as C
				 INNER JOIN Imovel I
                 ON C.idCliente = I.idCliente
			WHERE C.idCliente = idC;
        IF ((flag = 0) and(V>0)) THEN
			INSERT INTO Transacao(Data_Inicial,Data_Final,idImovel,idCliente,idFuncionario,valor)
            VALUES(dI,dF,idI,idC,idF,V);
		END IF;
        END
	&&
drop Procedure FichaContactoCliente
drop PROCEDURE existeEmailCliente
drop PROCEDURE FichaCliente
drop PROCEDURE InserirImovel

-- 1)	É possível adicionar imoveis à base de dados? X
-- 2)	É possível criar (adicionar) ficha cliente? X
-- 3)	É possível adicionar um novo funcionário? X
-- 4)	Qual funcionário foi/está responsável por determinada transação? X
-- 5)	Quantos imoveis estão à venda? X
-- 6)	Quais imoveis estão disponíveis para aluguer? X
-- 7)	Quais imoveis estão vendidos? X
-- 8)	Quais imoveis estão alugados? X
-- 9)	Qual o valor de determinado imóvel? X

-- 4
SELECT idFuncionario as CodigoFuncionario, F.Nome
	FROM Transacao as T
		INNER JOIN Funcionario as F
        ON T.idFuncionario = F.idFuncionario
        WHERE T.idFuncionario = ??;
-- 5
Select Count(idImovel)
	From Imovel 
    WHERE Condicao = 'Venda';
    
-- 6   
Select Count(idImovel)
	From Imovel 
    WHERE Condicao = 'Aluguer';
-- 7
Select Count(idImovel)
	From Imovel 
    WHERE Condicao = 'Vendidos';
-- 8
Select Count(idImovel)
	From Imovel 
    WHERE Condicao = 'Alugados';
-- 9 
Select Valor
	From Imovel
    WHERE idImovel = ??;
call FichaContactoF('Faria@2.2',1);
call FichaFuncionario('Joao',1);
call FichaContactoCliente('Joao@2.2',1);
call FichaCliente(1,'Als',1)
call InserirImovel('Moradia',80,'Venda',500,1,'Rua sobe a descer Braga',7)
select * from Imovel
select * from Cliente
select * from ContactoFuncionario
-- 10
Select idImovel as Codigo , Morada , Valor
	From Imovel
    Where Morada like ('%Braga%') and valor >= 50000;
    
    
    
    
    
    
    
    