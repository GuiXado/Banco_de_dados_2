CREATE DATABASE livraria
GO

USE livraria
Go

CREATE TABLE livro (
codigo		INT		NOT NULL	IDENTITY(100001, 100),
nome 		VARCHAR(200)	NOT NULL,
lingua		VARCHAR(10)	NOT NULL	DEFAULT('PT-BR'),
ano		INT		NOT NULL	CHECK(ano >= 1990),

PRIMARY KEY(codigo)
)


CREATE TABLE autor (
id_autor	INT		NOT NULL	IDENTITY(2351, 1),
nome 		VARCHAR(100)	NOT NULL	UNIQUE,
data_nasc	DATE		NOT NULL,
pais_nasc	VARCHAR(50)	NOT NULL	CHECK(UPPER(pais_nasc) = 'BRASIL' OR UPPER(pais_nasc) = 'ESTADOS UNIDOS'
						OR UPPER(pais_nasc) = 'INGLATERRA' OR UPPER(pais_nasc) = 'ALEMANHA'),
biografia	VARCHAR(255)	NOT NULL,

PRIMARY KEY(id_autor)
)


CREATE TABLE edicao (
isbn			CHAR(13)	NOT NULL,
preco			DECIMAL(4,2)	NOT NULL	CHECK(preco >= 0),
ano			int		NOT NULL 	CHECK(ano >= 1993),
numero_paginas		int		NOT NULL	CHECK(numero_paginas >= 15),
qtd_estoque		int		NOT NULL,

PRIMARY KEY(isbn),

CONSTRAINT chk_isbn CHECK (LEN(isbn) = 13)
)


CREATE TABLE editora (
id_editora		INT		NOT NULL 	IDENTITY(491, 16),
nome 			VARCHAR(70)	NOT NULL	UNIQUE,
telefone		VARCHAR(11)	NOT NULL,
logradouro_endereco	VARCHAR(200)	NOT NULL,
numero_endereco		INT		NOT NULL	CHECK(numero_endereco >= 0),
cep_endereco		CHAR(8)		NOT NULL,
complemento_endereco	VARCHAR(255)	NOT NULL,

PRIMARY KEY(id_editora),

CONSTRAINT chk_telefone CHECK (LEN(telefone) = 10),
CONSTRAINT chk_cep_endereco CHECK (LEN(cep_endereco) = 8)
)


CREATE TABLE livro_autor (
livroCodigo	INT	NOT NULL,
autor_id_autor	INT	NOT NULL,

PRIMARY KEY (livroCodigo, autor_id_autor),

FOREIGN KEY (livroCodigo) 	REFERENCES livro(codigo),
FOREIGN KEY (autor_id_autor) 	REFERENCES autor(id_autor)
);


CREATE TABLE editora_edicao_livro (
editora_id_editora	INT		NOT NULL,
edicao_isbn		CHAR(13)	NOT NULL,
livro_codigo		INT		NOT NULL,

PRIMARY KEY (editora_id_editora, edicao_isbn, livro_codigo),

FOREIGN KEY (livro_codigo)	 	REFERENCES livro(codigo),
FOREIGN KEY (edicao_isbn) 		REFERENCES edicao(isbn),
FOREIGN KEY (editora_id_editora) 	REFERENCES editora(id_editora)
);

