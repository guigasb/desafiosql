CREATE DATABASE Banco;
USE Banco;

CREATE TABLE tipo_usuario(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(50) NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE usuario(
	id INT PRIMARY KEY IDENTITY,
	id_tipo_usuario TINYINT,
	email VARCHAR(100) UNIQUE NOT NULL,
	senha VARCHAR(64) NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_usuario_tipo_usuario FOREIGN KEY (id_tipo_usuario) REFERENCES tipo_usuario(id)
);

CREATE TABLE cliente(
	id INT PRIMARY KEY IDENTITY,
	nome VARCHAR(60),
	sobrenome VARCHAR(100),
	CPF BIGINT NOT NULL,
	data_nascimento DATETIME NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME
);

CREATE TABLE uf(
	id TINYINT PRIMARY KEY,
	uf CHAR(2) NOT NULL,
	nome VARCHAR(35) NOT NULL
);

CREATE TABLE cidade(
	id SMALLINT PRIMARY KEY IDENTITY,
	id_uf TINYINT NOT NULL,
	nome VARCHAR(35) NOT NULL,
	CONSTRAINT fk_cidade_uf FOREIGN KEY (id_uf) REFERENCES uf(id)
);

CREATE TABLE endereco(
	id INT PRIMARY KEY IDENTITY,
	id_cidade SMALLINT NOT NULL,
	id_cliente INT NOT NULL,
	logradouro VARCHAR(100) NOT NULL,
	numero VARCHAR(10) NOT NULL,
	bairro VARCHAR(60) NOT NULL,
	CEP INT NOT NULL,
	complemento VARCHAR(100),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_endereco_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id),
	CONSTRAINT fk_endereco_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

CREATE TABLE tipo_contato(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(30) NOT NULL
);

CREATE TABLE contato(
	id INT PRIMARY KEY IDENTITY,
	id_cliente INT NOT NULL,
	id_tipo_contato TINYINT NOT NULL,
	numero BIGINT NOT NULL,
	whatsapp BIT NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_contato_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	CONSTRAINT fk_endereco_tipo_contato FOREIGN KEY (id_tipo_contato) REFERENCES tipo_contato(id)
);

CREATE TABLE tipo_conta(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(50),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE status(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(20)
);

CREATE TABLE conta(
	id INT PRIMARY KEY IDENTITY,
	id_cliente INT NOT NULL,
	id_status TINYINT NOT NULL,
	id_tipo_conta TINYINT NOT NULL,
	saldo MONEY NOT NULL,
	agencia SMALLINT NOT NULL,
	numero_conta INT NOT NULL UNIQUE,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_conta_cliente FOREIGN KEY (id_cliente) REFERENCES cliente(id),
	CONSTRAINT fk_conta_status FOREIGN KEY (id_status) REFERENCES status(id),
	CONSTRAINT fk_conta_tipo_conta FOREIGN KEY (id_tipo_conta) REFERENCES tipo_conta(id)
);

CREATE TABLE emprestimo(
	id INT PRIMARY KEY IDENTITY,
	id_conta INT NOT NULL,
	valor MONEY NOT NULL,
	quantidade_parcelas TINYINT NOT NULL,
	valor_parcela MONEY NOT NULL,
	fechamento_parcela DATE NOT NULL,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_emprestimo_conta FOREIGN KEY (id_conta) REFERENCES conta(id)
);

CREATE TABLE tipo_movimentacao(
	id TINYINT PRIMARY KEY,
	descricao VARCHAR(20),
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL
);

CREATE TABLE extrato(
	id INT PRIMARY KEY IDENTITY,
	id_conta INT NOT NULL,
	id_tipo_movimentacao TINYINT NOT NULL,
	data DATETIME NOT NULL,
	valor MONEY NOT NULL,
	usuario_transferido INT,
	usuario_cadastro INT NOT NULL,
	data_cadastro DATETIME NOT NULL,
	usuario_ultima_alteracao INT,
	data_ultima_alteracao DATETIME,
	CONSTRAINT fk_extrato_conta FOREIGN KEY (id_conta) REFERENCES conta(id),
	CONSTRAINT fk_extrato_tipo_movimentacao FOREIGN KEY (id_tipo_movimentacao) REFERENCES tipo_movimentacao(id)
);

INSERT INTO tipo_usuario VALUES 
(1,'administrador',1,'20220211 12:08:12'),
(2,'cliente',1,'20220212 07:30:16'),
(3,'funcionario',1,'20220212 07:30:20');

INSERT INTO usuario VALUES 
(1, 'jose.gabriel@smn.com.br', 'fh4MCB1213', 1, '20220215 17:33:56', NULL, NULL),
(3, 'guilherme.neves@smn.com.br', 'jKDGSNbAJs', 1, '20220218 10:27:00', NULL, NULL),
(3, 'andressa.abrantes@smn.com.br', 'Jn927fuhad', 1, '20220219 04:09:00', NULL, NULL),
(3, 'jorge.neto@smn.com.br', '2987fh2FDS', 3, '20220222 15:45:00', NULL, NULL),
(3, 'mateus.dom@smn.com.br', 'asSFDSV#318d', 3, '20220222 15:45:00', NULL, NULL),
(2, 'joaosilva@outlook.com', 'MsasfSD341G', 6, '20220226 14:34:00', NULL, NULL),
(2, 'marianetneves@hotmail.com', 'N37914TF3GYB', 7, '20220228 16:01:00', NULL, NULL),
(2, 'andrealves@yahoo.com.br', 'nuivjd348i0DF', 8, '20220301 12:30:00', NULL, NULL),
(2, 'cleide_ane@hotmail.com', ',csoaikdds492', 9, '20220306 09:08:00', NULL, NULL),
(2, 'mariajose@bol.com.br', 'senha123', 10, '20220513 12:26:00', NULL, NULL),
(2, 'joanasocorro@outlook.com', 'jans1298hAS', 11, '20220630 15:25:00', NULL, NULL),
(2, 'pedrodantas@outlook.com', 'pqkd129e-asd', 12, '20220829 12:39:00', NULL, NULL),
(2, 'paulorabelo@yahoo.com.br', 'nsaa2173afj', 13, '20221218 11:35:00', NULL, NULL),
(2, 'jeffersondias@gmail.com', 'ehdue18!54', 14, '20230104 06:32:00', NULL, NULL),
(2, 'dexterpsy@gmail.com', 'FYTybGfh38', 15, '20230124 10:23:00', NULL, NULL);

INSERT INTO cliente VALUES 
('Joao', 'Silva Neto', 81389302153, '19980115', 6, '20220226 14:34:00', NULL, NULL),
('Mariane', 'Travassos Neves', 92817398297, '19950115', 7, '20220228 16:01:00', NULL, NULL),
('Andre', 'Alves Dias', 12984612909, '19870115', 8, '20220301 12:30:00', NULL, NULL),
('Cleideane', 'Anne Gouveia Santos', 27813768276, '19940115', 9, '20220306 09:08:00', NULL, NULL),
('Maria', 'Jose da Silva', 82394729833, '19940115', 10, '20220513 12:26:00', NULL, NULL),
('Joana', 'Socorro Aparecida', 28304732893, '19850115', 11, '20220630 15:25:00', NULL, NULL),
('Pedro', 'Dantas Filho', 19823692843, '19960115', 12, '20220829 12:39:00', NULL, NULL),
('Paulo', 'Rabelo', 01298739218, '19930115', 13, '20221218 11:35:00', NULL, NULL),
('Jefferson', 'Dias Melo', 28913809732, '19780115', 14, '20230104 06:32:00', NULL, NULL),
('Dexter', 'Smith', 65043987649, '19580115', 15, '20230124 10:23:00', NULL, NULL);

INSERT INTO uf VALUES 
(1, 'AC', 'Acre'),
(2, 'AL', 'Alagoas' ),
(3, 'AP', 'Amapa' ),
(4, 'AM', 'Amazonas' ),
(5, 'BA', 'Bahia' ),
(6, 'CE', 'Ceara' ),
(7, 'ES', 'Espirito Santo' ),
(8, 'GO', 'Goias' ),
(9, 'MA', 'Maranhao' ),
(10, 'MT', 'Mato Grosso' ),
(11, 'MS', 'Mato Grosso do Sul' ),
(12, 'MG', 'Minas Gerais' ),
(13, 'PA', 'Para' ),
(14, 'PB', 'Paraiba' ),
(15, 'PR', 'Parana' ),
(16, 'PE', 'Pernambuco' ),
(17, 'PI', 'Piaui' ),
(18, 'RJ', 'Rio de Janeiro' ),
(19, 'RN', 'Rio Grande do Norte' ),
(20, 'RS', 'Rio Grande do Sul' ),
(21, 'RO', 'Rondonia' ),
(22, 'RR', 'Roraima' ),
(23, 'SC', 'Santa Catarina' ),
(24, 'SP', 'Sao Paulo' ),
(25, 'SE', 'Sergipe' ),
(26, 'TO', 'Tocantins' ),
(27, 'DF', 'Distrito Federal');

INSERT INTO cidade VALUES 
(1,'Rio Branco'),
(1,'Cruzeiro do Sul'),
(2,'Maceio'),
(2,'Maragogi'),
(3,'Macapa'),
(3,'Santana'),
(4,'Manaus'),
(4,'Paratins'),
(5,'Salvador'),
(5,'Porto Seguro'),
(6,'Fortaleza'),
(6,'Eusebio'),
(7,'Vitoria'),
(7,'Vila Velha'),
(8,'Goiania'),
(8,'Anapolis'),
(9,'Sao Luiz'),
(9,'Imperatriz'),
(10,'Cuiaba'),
(10,'Rondonopolis'),
(11,'Campo Grande'),
(11,'Dourados'),
(12,'Belo Horizonte'),
(12,'Uberlendia'),
(13,'Santarem'),
(13,'Belem'),
(14,'Joao Pessoa'),
(14,'Capina Grande'),
(15,'Curitiba'),
(15,'Londrina'),
(16,'Recife'),
(16,'Caruaru'),
(17,'Teresina'),
(17,'Pico'),
(18,'Rio de Janeiro'),
(18,'Niteroi'),
(19,'Natal'),
(19,'Mossoro'),
(20,'Porto Alegre'),
(20,'Rio Grande'),
(21,'Porto Velho'),
(21,'Vilhena'),
(22,'Boa Vista'),
(22,'Pacaraima'),
(23,'Florianopolis'),
(23,'Joinville'),
(24,'Sao Paulo'),
(24,'Campinas'),
(25,'Aracaju'),
(25,'Lagarto'),
(26,'Palmas'),
(26,'Araguaina'),
(27,'Brasilia'),
(27,'Ceilândia');


/*
CPF - 11 numeros
CEP - 8 numeros
NUMERO - DDD+9+NUMERO
AGENCIA - 4 numeros
NUMERO(da conta) - 8 numeros

Id Usuario Funcionarios: 1 ao 5
id Usuario Clientes: 6 ao 15 (nao confundir com cliente(id))
*/
INSERT INTO endereco VALUES 
(7, 1, 'Rua Jose Patricio de Almeida', '104B', 'Mangabeira', 58039650, NULL, 6, '20220226 14:34:00', NULL, NULL),
(17, 2, 'Rua Epitacio Pessoa', '23', 'Cristo', 58037608, NULL, 7, '20220228 16:01:00', NULL, NULL),
(24, 3, 'Avenida Ruy Carneiro', '99', 'Jardim Oceania', 73628564, 'Apto 101', 8, '20220301 12:30:00', NULL, NULL),
(3, 4, 'Avenida Antonio Lira', '1003', 'Manaira', 58009246, 'Bloco 2', 9, '20220306 09:08:00', NULL, NULL),
(4, 5, 'Rua Profa. Maria Sales', 'S/N', 'Tambau', 58039204, 'Apto 300', 10, '20220513 12:26:00', NULL, NULL),
(16, 6, 'BR-230', '101', 'Estados', 58037837, NULL, 11, '20220630 15:25:00', NULL, NULL),
(21, 7, 'Avenida Gov. Argemiro de Figueiredo', '4990', 'Torre', 57357608, 'Condominio dos Jardins', 12, '20220829 12:39:00', NULL, NULL),
(18, 8, 'Rua Telegrafista Cicero Caldas', '291B', 'Bessa', 55437608, 'Apto 300', 13, '20221218 11:35:00', NULL, NULL),
(9, 9, 'Avenida Mato Grosso', '2', 'Intermares', 59274950, 'Bloco B', 14, '20230104 06:32:00', NULL, NULL),
(2, 10, 'Rua Luiz Lianza', '19', 'Bancarios', 63829025, 'Bloco 4 Apto 103', 15, '20230124 10:23:00', NULL, NULL);

INSERT INTO tipo_contato VALUES 
(1, 'Celular'),
(2, 'Telefone Residencial');

INSERT INTO contato VALUES 
(1, 1, 83987283746, 1, 6, '20220226 14:34:00', NULL, NULL),
(2, 2, 8897328467, 1, 7, '20220228 16:01:00', NULL, NULL),
(3, 2, 8348976348, 1, 8, '20220301 12:30:00', NULL, NULL),
(4, 1, 83980394237, 0, 9, '20220306 09:08:00', NULL, NULL),
(5, 1, 85990378264, 0, 10, '20220513 12:26:00', NULL, NULL),
(6, 2, 8330784632, 1, 11, '20220630 15:25:00', NULL, NULL),
(7, 1, 11994839283, 1, 12, '20220829 12:39:00', NULL, NULL),
(8, 2, 6998372488, 1, 13, '20221218 11:35:00', NULL, NULL),
(9, 2, 8580384692, 1, 14, '20230104 06:32:00', NULL, NULL),
(10, 1, 83984034008, 0, 15, '20230124 10:23:00', NULL, NULL);

INSERT INTO tipo_conta VALUES 
(1,'Conta Corrente', 2, '20220222 15:45:00'),
(2,'Conta Poupanca', 3, '20220222 15:45:00'),
(3,'Conta Corrente e Poupanca', 4, '20220222 15:45:00');

INSERT INTO status VALUES 
(1,'Ativo'),
(2,'Inativo'),
(3,'Suspensa');

INSERT INTO conta VALUES 
(1, 1, 1, 1900.50, 6020, 50023125, 6, '20220226 14:34:00', NULL, NULL),
(2, 3, 1, 2450.00, 6012, 73296498, 7, '20220228 16:01:00', NULL, NULL),
(3, 3, 1, 21424.20, 6012, 93824793, 8, '20220301 12:30:00', NULL, NULL),
(4, 1, 1, 19.46, 6020, 32984783, 9, '20220306 09:08:00', NULL, NULL),
(5, 3, 2, 250.00, 6015, 07439264, 10, '20220513 12:26:00', NULL, NULL),
(6, 1, 1, 10021.75, 3020, 43209890, 11, '20220630 15:25:00', NULL, NULL),
(7, 1, 1, 93200.45, 3020, 92183799, 12, '20220829 12:39:00', NULL, NULL),
(8, 3, 1, 1000000.32, 4002, 75438976, 13, '20221218 11:35:00', NULL, NULL),
(9, 1, 1, 1.50, 4045, 17283893, 14, '20230104 06:32:00', NULL, NULL),
(10, 2, 3, 0.00, 1020, 19827634, 15, '20230124 10:23:00', NULL, NULL);

INSERT INTO emprestimo VALUES 
(1, 0.00, 0, 0.00, '20220105', 2, '20220226 14:34:00', NULL, NULL),
(2, 0.00, 0, 0.00, '20220105', 2, '20220228 16:01:00', NULL, NULL),
(3, 0.00, 0, 0.00, '20220105', 3, '20220301 12:30:00', NULL, NULL),
(4, 0.00, 0, 0.00, '20220105', 2, '20220306 09:08:00', NULL, NULL),
(6, 0.00, 0, 0.00, '20220105', 3, '20220630 15:25:00', NULL, NULL),
(7, 0.00, 0, 0.00, '20220105', 2, '20220829 12:39:00', NULL, NULL),
(8, 0.00, 0, 0.00, '20220105', 4, '20221218 11:35:00', NULL, NULL),
(9, 0.00, 0, 0.00, '20220105', 4, '20230104 06:32:00', NULL, NULL);

INSERT INTO tipo_movimentacao VALUES 
(1, 'deposito', 1, '20220215 17:33:56'),
(2, 'saque', 1, '20220215 17:33:56'),
(3, 'transferencia', 1, '20220215 17:33:56');

INSERT INTO extrato VALUES 
(1, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(2, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(3, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(4, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(5, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(6, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(7, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(8, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(9, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL),
(10, 1, '20220215 17:33:56', 0.00, NULL, 1, '20220215 17:33:56', NULL, NULL);



---------------------------------------SP INSERT CLIENTE BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.InsCliente]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.InsCliente]	

GO

CREATE PROCEDURE [SP.InsCliente]
	@nome		varchar(60),
	@sobrenome		varchar(100),
	@CPF		BIGINT,
	@data_nascimento DATE,
	@usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Insere um novo cliente na tabela Cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia
	Data ...............: 16/02/2023
	Ex .................: EXEC [SP.InsCliente] @nome = 'Matias', @sobrenome = 'Santos', @CPF = 89258014738, @data_nascimento = '19670518', @usuario = 1
	Códigos de retorno: 0 - excução ok
	*/

	BEGIN 
		INSERT INTO cliente
		VALUES (@nome,@sobrenome,@CPF,@data_nascimento,@usuario, GETDATE(),@usuario,GETDATE())
		RETURN 0
	END
GO










---------------------------------------SP UPDATE STATUS CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.UpStatus]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.UpStatus]	

GO

CREATE PROCEDURE [SP.UpStatus]
	@status TINYINT,
	@id_cliente INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Ativa, inativa ou suspende uma conta de um cliente
							return 0 - execuçao ok
							@status: 1 = Ativo
									 2 = Inativo
									 3 = Suspensa

	Autor ..............: Gabriel Gouveia
	Data ...............: 16/02/2023
	Ex .................: EXEC [SP.UpStatus] @status = 3, @id_cliente = 10
	*/

	BEGIN 
		UPDATE conta SET id_status = @status WHERE id_cliente = @id_cliente 
		RETURN 0
	END
GO








---------------------------------------SP DEPOSITO CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.DepositoConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.DepositoConta]	

GO

CREATE PROCEDURE [SP.DepositoConta]
	@valor MONEY,
	@id_conta INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Faz o deposito de dinheiro em uma conta de um cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia
	Data ...............: 16/02/2023
	Ex .................: EXEC [SP.DepositoConta] @valor = 100.00, @id_conta  = 1, @id_usuario = 3
	*/

	BEGIN 
		UPDATE conta SET saldo = saldo + @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @id_conta;
		INSERT INTO extrato VALUES (@id_conta, 1, GETDATE(), @valor, NULL, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		RETURN 0
	END
GO


---------------------------------------SP SAQUE CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.SaqueConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.SaqueConta]	

GO

CREATE PROCEDURE [SP.SaqueConta]
	@valor MONEY,
	@id_conta INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Faz o saque de dinheiro em uma conta de um cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia
	Data ...............: 16/02/2023
	Ex .................: EXEC [SP.SaqueConta] @valor = 100.00, @id_conta  = 1, @id_usuario = 3
	*/

	BEGIN 
		UPDATE conta SET saldo = saldo - @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @id_conta;
		INSERT INTO extrato VALUES (@id_conta, 2, GETDATE(), @valor, NULL, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		RETURN 0
	END
GO


---------------------------------------SP TRANSFERENCIA CONTA BANCO--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.TransfConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.TransfConta]	

GO

CREATE PROCEDURE [SP.TransfConta]
	@valor MONEY,
	@id_conta INT,
	@conta_transferencia INT,
	@id_usuario INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Faz a transferencia de dinheiro em uma conta e outra de clientes
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia
	Data ...............: 16/02/2023
	Ex .................: EXEC [SP.TransfConta] @valor = 100.00, @id_conta  = 1, @conta_transferencia = 2, @id_usuario = 3
	*/

	BEGIN 
		UPDATE conta SET saldo = saldo - @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @id_conta;
		UPDATE conta SET saldo = saldo + @valor, usuario_ultima_alteracao = @id_usuario, data_ultima_alteracao = GETDATE() WHERE id = @conta_transferencia;
		INSERT INTO extrato VALUES (@id_conta, 3, GETDATE(), -@valor, @conta_transferencia, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		INSERT INTO extrato VALUES (@conta_transferencia, 3, GETDATE(), +@valor, @id_conta, @id_usuario, GETDATE(), @id_usuario, GETDATE());
		RETURN 0
	END
GO






---------------------------------------SP EXTRATO CLIENTE SMN--------------------------------------------
IF EXISTS(SELECT TOP 1 1 FROM sysobjects WHERE ID = object_id(N'[SP.ExtratoConta]') AND objectproperty(ID,N'isProcedure') = 1)
	DROP PROCEDURE [SP.ExtratoConta]	

GO

CREATE PROCEDURE [SP.ExtratoConta]
	@id_cliente INT
	AS

	/*Documentação
	Arquivo Fonte ......: Script.sql
	Objetivo ...........: Apresenta o relatorio com todo o extrato de transacoes de um cliente
							return 0 - execuçao ok

	Autor ..............: Gabriel Gouveia
	Data ...............: 16/02/2023
	Ex .................: EXEC [SP.ExtratoConta] @id_cliente = 1
	*/

	BEGIN 
		SELECT CONCAT(cl.nome,' ' ,cl.sobrenome) AS 'Nome Completo', tm.descricao AS 'Tipo Movimentacao',ex.valor AS Valor, ex.data AS 'Data Transacao', ex.usuario_transferido
		FROM extrato ex
		INNER JOIN conta ct
		ON ex.id_conta = ct.id
		INNER JOIN cliente cl
		ON ct.id_cliente = cl.id
		INNER JOIN tipo_movimentacao tm
		ON tm.id = ex.id_tipo_movimentacao
		WHERE cl.id = @id_cliente
		RETURN 0
	END
GO

---podem ignorar os comandos debaixo---
select * from conta
select * from extrato
select * from tipo_movimentacao

SELECT cl.nome, cl.sobrenome, ct.saldo FROM conta ct
INNER JOIN cliente cl
ON ct.id_cliente = cl.id

--datetimenow