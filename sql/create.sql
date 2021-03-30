-- SCRIPT DE CRIAÇÃO DO BANCO SIGDIETPLAN

DROP DATABASE IF EXISTS db_sigdietplan;

CREATE DATABASE IF NOT EXISTS db_sigdietplan
CHARACTER SET = 'utf8'
COLLATE 'utf8_unicode_ci';

USE db_sigdietplan;

CREATE TABLE db_sigdietplan.usuario(
	nome VARCHAR(100),
    senha VARCHAR(100) NOT NULL,
    tipo INT NOT NULL,
	status BOOLEAN DEFAULT 0,
    CHECK(tipo >= 0 AND tipo <= 2),
    PRIMARY KEY(nome)
);

CREATE TABLE db_sigdietplan.usuario_comunicacao(
	id INT AUTO_INCREMENT,
    mensagem TEXT NOT NULL,
    usuario_emissor VARCHAR(100) NOT NULL,
    usuario_receptor VARCHAR(100) NOT NULL,
    data_de_envio DATETIME,
    PRIMARY KEY(id),
    FOREIGN KEY(usuario_emissor) REFERENCES db_sigdietplan.usuario(nome) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(usuario_receptor) REFERENCES db_sigdietplan.usuario(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.processo(
	id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
	descricao TEXT NOT NULL,
	tipo INT NOT NULL,
	situacao INT DEFAULT 0,
    CHECK(tipo >= 0 AND tipo <= 3),
    PRIMARY KEY(id),
    FOREIGN KEY(nome) REFERENCES db_sigdietplan.usuario(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.administrador(
	id INT AUTO_INCREMENT,
	nome VARCHAR(100),
    nome_usuario VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY(nome_usuario) REFERENCES db_sigdietplan.usuario(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.nutricionista(
	id INT AUTO_INCREMENT,
	nome VARCHAR(100),
    nome_usuario VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY(nome_usuario) REFERENCES db_sigdietplan.usuario(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.consumidor(
	id INT AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
	idade INT,
    peso FLOAT,
    altura INT,
    nome_usuario VARCHAR(100) NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY(nome_usuario) REFERENCES db_sigdietplan.usuario(nome) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.cardapio(
	id INT AUTO_INCREMENT,
    preco FLOAT NOT NULL,
    garantia INT,
	tipo INT,
	descricao TEXT,
    CHECK(tipo >= 0 AND tipo <= 2),
    PRIMARY KEY(id)
);

CREATE TABLE db_sigdietplan.alimento(
	id INT AUTO_INCREMENT,
	nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    proteina FLOAT NOT NULL,
    carboidrato FLOAT NOT NULL,
    gordura FLOAT NOT NULL,
    caloria FLOAT NOT NULL,
    PRIMARY KEY(id)
);

CREATE TABLE db_sigdietplan.cardapio_alimento(
	id INT AUTO_INCREMENT,
    quantidade INT NOT NULL,
    alimento_id INT NOT NULL,
	cardapio_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(alimento_id) REFERENCES db_sigdietplan.alimento(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(cardapio_id) REFERENCES db_sigdietplan.cardapio(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.cartao_credito(
	numero VARCHAR(30),
	nomeTitular VARCHAR(100) NOT NULL,
	data_validade VARCHAR(7) NOT NULL,
    bandeira VARCHAR(30) NOT NULL,
    codigo_seguranca INT NOT NULL,
    consumidor_id INT NOT NULL,
    PRIMARY KEY(numero),
    FOREIGN KEY(consumidor_id) REFERENCES db_sigdietplan.consumidor(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.acompanhamento(
	id INT AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
	data_inicio DATETIME NOT NULL,
    data_final DATETIME NOT NULL,
    consumidor_id INT NOT NULL,
    nutricionista_id INT NOT NULL,
    pedido_id INT NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY(consumidor_id) REFERENCES db_sigdietplan.consumidor(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(nutricionista_id) REFERENCES db_sigdietplan.nutricionista(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.pedido(
	id INT AUTO_INCREMENT,
    desconto FLOAT DEFAULT 0,
    data DATETIME NOT NULL,
    finalizado BOOLEAN DEFAULT 0,
    forma_pagamento enum('boleto', 'cartao') NOT NULL,
    consumidor_id INT NOT NULL,
    cardapio_id INT NOT NULL,
    PRIMARY KEY(id),
	FOREIGN KEY(consumidor_id) REFERENCES db_sigdietplan.consumidor(id) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(cardapio_id) REFERENCES db_sigdietplan.cardapio(id) ON UPDATE CASCADE ON DELETE CASCADE
);

ALTER TABLE db_sigdietplan.acompanhamento ADD FOREIGN KEY(pedido_id) REFERENCES db_sigdietplan.pedido(id) ON UPDATE CASCADE ON DELETE CASCADE;

CREATE TABLE db_sigdietplan.relatorio(
	id INT AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT NOT NULL,
    data DATETIME NOT NULL,
	acompanhamento_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(acompanhamento_id) REFERENCES db_sigdietplan.acompanhamento(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.anexo(
	id INT AUTO_INCREMENT,
    link VARCHAR(1000),
    relatorio_id INT NOT NULL,
    PRIMARY KEY(id),
    FOREIGN KEY(relatorio_id) REFERENCES db_sigdietplan.relatorio(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.cartao_credito_pagamento(
	id INT AUTO_INCREMENT,
    parcelamento INT NOT NULL,
	numero_cartao VARCHAR(30) NOT NULL,
    pedido_id INT NOT NULL UNIQUE,
    PRIMARY KEY(id),
    FOREIGN KEY(numero_cartao) REFERENCES db_sigdietplan.cartao_credito(numero) ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(pedido_id) REFERENCES db_sigdietplan.pedido(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE db_sigdietplan.boleto_bancario(
	codigo_barras VARCHAR(50),
    data_vencimento DATE NOT NULL,
    pedido_id INT NOT NULL UNIQUE,
    PRIMARY KEY(codigo_barras),
    FOREIGN KEY(pedido_id) REFERENCES db_sigdietplan.pedido(id) ON UPDATE CASCADE ON DELETE CASCADE
);







