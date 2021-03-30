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

-- TABELA USUÁRIO
-- USUARIO CONSUMIDOR
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('richard', '123', 0, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('ana', '321', 0, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('roberto', '123', 0, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('juliana', '321', 0, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('jose', '123', 0, 0);

-- USUARIO NUTRICIONISTA
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('maria', '321', 1, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('carlos', '123', 1, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('lucas', '321', 1, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('leonardo', '123', 1, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('joão', '321', 1, 0);

-- USUARIO ADMINISTRADOR
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('marcelo', '123', 2, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('joaquim', '321', 2, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('cristiano', '123', 2, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('paulo', '321', 2, 0);
INSERT INTO db_sigdietplan.usuario(nome, senha, tipo, status) VALUES('moises', '123', 2, 0);

-- TABELA CONSUMIDOR
INSERT INTO db_sigdietplan.consumidor(nome, idade, peso, altura, nome_usuario) VALUES('Richard', 30, 80.00, 180, 'richard');
INSERT INTO db_sigdietplan.consumidor(nome, idade, peso, altura, nome_usuario) VALUES('Ana', 40, 90.00, 180, 'ana');
INSERT INTO db_sigdietplan.consumidor(nome, idade, peso, altura, nome_usuario) VALUES('Roberto', 40, 35.00, 180, 'roberto');
INSERT INTO db_sigdietplan.consumidor(nome, idade, peso, altura, nome_usuario) VALUES('Juliana', 20, 70.00, 160, 'juliana');
INSERT INTO db_sigdietplan.consumidor(nome, idade, peso, altura, nome_usuario) VALUES('Jose', 20, 100.00, 190, 'jose');

-- TABELA NUTRICIONISTA
INSERT INTO db_sigdietplan.nutricionista(nome, nome_usuario) VALUES('Maria','maria');
INSERT INTO db_sigdietplan.nutricionista(nome, nome_usuario) VALUES('Carlos','carlos');
INSERT INTO db_sigdietplan.nutricionista(nome, nome_usuario) VALUES('Lucas','lucas');
INSERT INTO db_sigdietplan.nutricionista(nome, nome_usuario) VALUES('Leonardo','leonardo');
INSERT INTO db_sigdietplan.nutricionista(nome, nome_usuario) VALUES('João','joão');

-- TABELA ADMINISTRADOR
INSERT INTO db_sigdietplan.administrador(nome, nome_usuario) VALUES('Marcelo', 'marcelo');
INSERT INTO db_sigdietplan.administrador(nome, nome_usuario) VALUES('Joaquim', 'joaquim');
INSERT INTO db_sigdietplan.administrador(nome, nome_usuario) VALUES('Cristiano', 'cristiano');
INSERT INTO db_sigdietplan.administrador(nome, nome_usuario) VALUES('Paulo', 'paulo');
INSERT INTO db_sigdietplan.administrador(nome, nome_usuario) VALUES('Moises', 'moises');

-- TABELA USUARIO_COMUNICACAO

INSERT INTO db_sigdietplan.usuario_comunicacao(mensagem, usuario_emissor, usuario_receptor, data_de_envio) VALUES('Olá, tudo bom?', 'richard', 'ana', now());
INSERT INTO db_sigdietplan.usuario_comunicacao(mensagem, usuario_emissor, usuario_receptor, data_de_envio) VALUES('Opa, como vão as coisas?', 'ana', 'richard', now());
INSERT INTO db_sigdietplan.usuario_comunicacao(mensagem, usuario_emissor, usuario_receptor, data_de_envio) VALUES('Você prefere uma dieta restritiva ou maior flexibilidade', 'roberto', 'juliana', now());
INSERT INTO db_sigdietplan.usuario_comunicacao(mensagem, usuario_emissor, usuario_receptor, data_de_envio) VALUES('Prefiro uma dieta mais restritiva', 'juliana', 'roberto', now());
INSERT INTO db_sigdietplan.usuario_comunicacao(mensagem, usuario_emissor, usuario_receptor, data_de_envio) VALUES('Vou comprar uma dieta mais restritiva também', 'roberto', 'juliana', now());

-- TABELA PROCESSO

INSERT INTO db_sigdietplan.processo(nome, descricao, tipo, situacao) VALUES('richard', 'Gostaria de renovar meu plano', 2, 0);
INSERT INTO db_sigdietplan.processo(nome, descricao, tipo, situacao) VALUES('ana', 'Gostaria de remover meus dados bancários do sistema', 1, 0);
INSERT INTO db_sigdietplan.processo(nome, descricao, tipo, situacao) VALUES('roberto', 'Gostaria de renovar meu plano', 2, 0);
INSERT INTO db_sigdietplan.processo(nome, descricao, tipo, situacao) VALUES('juliana', 'Gostaria de renovar meu plano', 2, 0);
INSERT INTO db_sigdietplan.processo(nome, descricao, tipo, situacao) VALUES('jose', 'Gostaria de solicitar o reembolso do meu plano atual', 0, 0);

-- TABELA ALIMENTO

INSERT INTO db_sigdietplan.alimento(nome, descricao, proteina, carboidrato, gordura, caloria) VALUES('Peito de Frango ', 'Para cada 300 gramas',100, 50, 50, 400);
INSERT INTO db_sigdietplan.alimento(nome, descricao, proteina, carboidrato, gordura, caloria) VALUES('Carne Patinho', 'Para cada 200 gramas', 80, 35, 35, 300);
INSERT INTO db_sigdietplan.alimento(nome, descricao, proteina, carboidrato, gordura, caloria) VALUES('Ovo cozido', 'Para cada um ovo tamanho grande', 20, 5, 5, 50);
INSERT INTO db_sigdietplan.alimento(nome, descricao, proteina, carboidrato, gordura, caloria) VALUES('Tilápia', 'Para cada 300 gramas', 120, 45, 45, 250);
INSERT INTO db_sigdietplan.alimento(nome, descricao, proteina, carboidrato, gordura, caloria) VALUES('Bife de peru', 'Para cada 300 gramas', 120, 60, 60, 400);

-- TABELA CARTÃO DE CRÉDITO

INSERT INTO db_sigdietplan.cartao_credito(numero, nomeTitular, data_validade, bandeira, codigo_seguranca, consumidor_id) VALUES('5374 7625 1220 0785', 'Richard', '02/2024', 'master card', 845, 1);
INSERT INTO db_sigdietplan.cartao_credito(numero, nomeTitular, data_validade, bandeira, codigo_seguranca, consumidor_id) VALUES('4556 8562 7610 6809', 'Ana', '05/2025', 'visa', 584, 2);
INSERT INTO db_sigdietplan.cartao_credito(numero, nomeTitular, data_validade, bandeira, codigo_seguranca, consumidor_id) VALUES('4943 0218 8777 5094', 'Roberto', '05/2026', 'visa', 836, 3);
INSERT INTO db_sigdietplan.cartao_credito(numero, nomeTitular, data_validade, bandeira, codigo_seguranca, consumidor_id) VALUES('5314 3705 9977 5498', 'Juliana', '06/2027', 'master card', 703, 4);
INSERT INTO db_sigdietplan.cartao_credito(numero, nomeTitular, data_validade, bandeira, codigo_seguranca, consumidor_id) VALUES('5215 0928 7157 7984', 'Jose', '07/2028', 'master card', 297, 5);

-- TABELA CARDÁPIO

INSERT INTO db_sigdietplan.cardapio(preco, garantia, tipo, descricao) VALUES(300.00, 30, 0, 'Uma boa dieta para quem está começando a fazer restrição alimentar.');
INSERT INTO db_sigdietplan.cardapio(preco, garantia, tipo, descricao) VALUES(200.00, 30, 0, 'Uma dieta flexivel, porém eficaz, com uma quantidade de divisões alimentares.');
INSERT INTO db_sigdietplan.cardapio(preco, garantia, tipo, descricao) VALUES(250.00, 30, 0, 'Dieta cetogênica, rica em carnes e gorduras');
INSERT INTO db_sigdietplan.cardapio(preco, garantia, tipo, descricao) VALUES(100, 30, 0, 'Uma simples dieta pra emagrecimento');
INSERT INTO db_sigdietplan.cardapio(preco, garantia, tipo, descricao) VALUES(100, 30, 0, 'Uma simples dieta para hipertrofia');

-- TABELA CARDAPIO_ALIMENTO 

INSERT INTO db_sigdietplan.cardapio_alimento(quantidade, alimento_id, cardapio_id) VALUES(10, 1, 1);
INSERT INTO db_sigdietplan.cardapio_alimento(quantidade, alimento_id, cardapio_id) VALUES(30, 2, 2);
INSERT INTO db_sigdietplan.cardapio_alimento(quantidade, alimento_id, cardapio_id) VALUES(30, 3, 3);
INSERT INTO db_sigdietplan.cardapio_alimento(quantidade, alimento_id, cardapio_id) VALUES(30, 4, 4);
INSERT INTO db_sigdietplan.cardapio_alimento(quantidade, alimento_id, cardapio_id) VALUES(30, 5, 5);

-- TABELA PEDIDO

INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'cartao', 2, 1);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'cartao', 2, 2);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'cartao', 2, 3);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'cartao', 2, 4);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'cartao', 2, 5);

INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'boleto', 1, 1);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'boleto', 1, 2);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'boleto', 1, 3);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'boleto', 1, 4);
INSERT INTO db_sigdietplan.pedido(data, forma_pagamento, consumidor_id, cardapio_id) VALUES(now(), 'boleto', 1, 5);

-- TABELA ACOMPANHAMENTO

INSERT INTO db_sigdietplan.acompanhamento(title, descricao, data_inicio, data_final, consumidor_id, nutricionista_id, pedido_id) VALUES('Dieta #1', 'Dieta restritiva', now(),'2021-04-10 00:00:00' ,1, 1, 1);
INSERT INTO db_sigdietplan.acompanhamento(title, descricao, data_inicio, data_final, consumidor_id, nutricionista_id, pedido_id) VALUES('Dieta #2', 'Dieta com flexibilidade de carboidratos', now(),'2021-04-10 00:00:00' ,1, 1, 2);
INSERT INTO db_sigdietplan.acompanhamento(title, descricao, data_inicio, data_final, consumidor_id, nutricionista_id, pedido_id) VALUES('Dieta #3', 'Dieta a base de proteínas', now(),'2021-04-10 00:00:00' ,1, 1, 3);
INSERT INTO db_sigdietplan.acompanhamento(title, descricao, data_inicio, data_final, consumidor_id, nutricionista_id, pedido_id) VALUES('Dieta #4', 'Dieta cetogênica', now(),'2021-04-10 00:00:00' ,1, 1, 4);
INSERT INTO db_sigdietplan.acompanhamento(title, descricao, data_inicio, data_final, consumidor_id, nutricionista_id, pedido_id) VALUES('Dieta #5', 'Dieta a base de gorduras boas e proteínas', now(),'2021-04-10 00:00:00' ,1, 1, 5);

-- TABELA RELATÓRIO

INSERT INTO db_sigdietplan.relatorio(nome, descricao, data, acompanhamento_id) VALUES('Semana 1', 'É preciso tomar cuidado e comer com todas as divisões pre estabelecidas', now(), 1);
INSERT INTO db_sigdietplan.relatorio(nome, descricao, data, acompanhamento_id) VALUES('Semana 2', 'A retenção líquida está começando a enxugar, continue a tomar bastante água', now(), 1);
INSERT INTO db_sigdietplan.relatorio(nome, descricao, data, acompanhamento_id) VALUES('Semana 3', 'Mantenha-se longe de carboidratos', now(), 1);
INSERT INTO db_sigdietplan.relatorio(nome, descricao, data, acompanhamento_id) VALUES('Semana 4', 'Como etapa final, faça bastante aerobicos para avaliar os resultados no retorno', now(), 1);
INSERT INTO db_sigdietplan.relatorio(nome, descricao, data, acompanhamento_id) VALUES('Semana 1', 'Remova os carboidratos aos poucos', now(), 2);

-- TABELA ANEXO

INSERT INTO db_sigdietplan.anexo(link, relatorio_id) VALUES('https://localhost:8080/data/suggestions/?user=oASd908asd08ad09a8d0/?=relatorio=a87dya8sdyady/suggest-01', 1);
INSERT INTO db_sigdietplan.anexo(link, relatorio_id) VALUES('https://localhost:8080/data/suggestions/?user=oASd908asd08ad09a8d0/?=relatorio=a87dya8sdyady/suggest-02', 1);
INSERT INTO db_sigdietplan.anexo(link, relatorio_id) VALUES('https://localhost:8080/data/suggestions/?user=oASd908asd08ad09a8d0/?=relatorio=a87dya8sdyady/suggest-03', 1);
INSERT INTO db_sigdietplan.anexo(link, relatorio_id) VALUES('https://localhost:8080/data/suggestions/?user=oASd908asd08ad09a8d0/?=relatorio=a87dya8sdyady/suggest-04', 1);
INSERT INTO db_sigdietplan.anexo(link, relatorio_id) VALUES('https://localhost:8080/data/suggestions/?user=oASd908asd08ad09a8d0/?=relatorio=a87dya8sdyady/suggest-05', 1);

-- TABELA CARTÃO CRÉDITO PAGAMENTO

INSERT INTO db_sigdietplan.cartao_credito_pagamento(parcelamento, numero_cartao, pedido_id) VALUES(3, '5374 7625 1220 0785', 1);
INSERT INTO db_sigdietplan.cartao_credito_pagamento(parcelamento, numero_cartao, pedido_id) VALUES(3, '4556 8562 7610 6809', 2);
INSERT INTO db_sigdietplan.cartao_credito_pagamento(parcelamento, numero_cartao, pedido_id) VALUES(3, '4943 0218 8777 5094', 3);
INSERT INTO db_sigdietplan.cartao_credito_pagamento(parcelamento, numero_cartao, pedido_id) VALUES(3, '5314 3705 9977 5498', 4);
INSERT INTO db_sigdietplan.cartao_credito_pagamento(parcelamento, numero_cartao, pedido_id) VALUES(3, '5215 0928 7157 7984', 5);

-- TABELA BOLETO BANCÁRIO

INSERT INTO db_sigdietplan.boleto_bancario(codigo_barras, data_vencimento, pedido_id) VALUES('1231231231231231231231312', '2021-04-1', 6);
INSERT INTO db_sigdietplan.boleto_bancario(codigo_barras, data_vencimento, pedido_id) VALUES('3123123123131231231231233', '2021-04-1', 7);
INSERT INTO db_sigdietplan.boleto_bancario(codigo_barras, data_vencimento, pedido_id) VALUES('4353453453534534534534554', '2021-04-1', 8);
INSERT INTO db_sigdietplan.boleto_bancario(codigo_barras, data_vencimento, pedido_id) VALUES('9087897897979879872344323', '2021-04-1', 9);
INSERT INTO db_sigdietplan.boleto_bancario(codigo_barras, data_vencimento, pedido_id) VALUES('9837498236428936429846239', '2021-04-1', 10);





