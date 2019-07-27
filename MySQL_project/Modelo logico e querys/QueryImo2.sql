use Imobiliaria;
select * from Funcionario;
drop database Imobiliaria;




use Imobiliaria;
select * from Funcionario;


-- 4
SELECT F.idFuncionario as CodigoFuncionario, F.Nome
	FROM Transacao as T
		INNER JOIN Funcionario as F
                 ON T.idFuncionario = F.idFuncionario
        WHERE T.idTransacao = 1;
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
    WHERE Condicao = 'Vendido';
-- 8
Select Count(idImovel)
	From Imovel 
    WHERE Condicao = 'Alugado';
-- 9 
Select Valor
	From Imovel
    WHERE idImovel = 1;

-- 10
Select idImovel as Codigo , Morada , Valor
	From Imovel
    Where Morada like ('%Braga') and valor >= 50000;
    
    