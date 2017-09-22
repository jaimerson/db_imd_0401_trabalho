CREATE TYPE ESPECIALIDADE AS ENUM ('jardineiro', 'hortelão', 'agrônomo');

CREATE TABLE trabalhador(
  id_trabalhador SERIAL,
  nome VARCHAR(255) NOT NULL,
  data_nascimento DATE NOT NULL,
  especialidade ESPECIALIDADE NOT NULL,

  PRIMARY KEY(id_trabalhador)
);

CREATE TABLE produto(
  id_produto SERIAL,
  descricao TEXT UNIQUE NOT NULL,
  area_plantada NUMERIC NOT NULL,
  id_trabalhador INTEGER REFERENCES trabalhador(id_trabalhador) NOT NULL,

  PRIMARY KEY(id_produto)
);

CREATE TABLE comprador(
  id_comprador SERIAL,
  nome_comprador VARCHAR(255) NOT NULL,
  cidade_comprador VARCHAR(255) NOT NULL,
  telefone_comprador VARCHAR(20) NOT NULL,

  PRIMARY KEY(id_comprador)
);

CREATE TABLE venda(
  id_venda SERIAL,
  id_comprador INTEGER REFERENCES comprador(id_comprador) NOT NULL,
  id_produto INTEGER REFERENCES produto(id_produto) NOT NULL,
  data_venda DATE NOT NULL,
  quantidate INTEGER NOT NULL,
  valor MONEY NOT NULL,
  data_recebimento DATE NOT NULL,

  PRIMARY KEY(id_venda)
);
