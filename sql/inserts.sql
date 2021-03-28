USE db_sigdietplan;

DELETE FROM db_sigdietplan.usuario_comunicacao;
DELETE FROM db_sigdietplan.usuario;
DELETE FROM db_sigdietplan.consumidor;
DELETE FROM db_sigdietplan.nutricionista;
DELETE FROM db_sigdietplan.administrador;
DELETE FROM db_sigdietplan.processo;
DELETE FROM db_sigdietplan.alimento;
DELETE FROM db_sigdietplan.cartao_credito;

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

