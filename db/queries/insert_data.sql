INSERT INTO trabalhador (nome, data_nascimento, especialidade) VALUES
  ('Abracadaniel','01/07/1685','jardineiro'),
  ('Ancient Sleeping Magi of Life Giving','01/07/1985','jardineiro'),
  ('Banana Man','01/07/1985','jardineiro'),
  ('Betty Grof','01/07/1985','jardineiro'),
  ('Billy','01/07/1985','jardineiro'),
  ('Bronwyn','01/07/1985','jardineiro'),
  ('Bufo','01/07/1985','jardineiro'),
  ('Charlie','01/07/1985','jardineiro'),
  ('Chet','01/07/1985','jardineiro'),
  ('Chocoberry','01/07/1985','jardineiro'),
  ('Choose Goose','01/07/1985','jardineiro'),
  ('Cinnamon Bun','01/07/1985','jardineiro'),
  ('Cosmic Owl','01/07/1999','hortelão'),
  ('Crunchy','01/07/1999','hortelão'),
  ('Cuber','01/07/1999','hortelão'),
  ('Hunson Abadeer','01/07/1994','agrônomo'),
  ('Jake Jr.','01/07/1964','agrônomo'),
  ('Jermaine','01/07/1995','agrônomo'),
  ('Joshua','01/07/1964','agrônomo'),
  ('Kim Kil Whan','01/07/1964','agrônomo'),
  ('King of Ooo','01/07/1964','agrônomo'),
  ('Lemongrab 1 & 2 & 3','01/07/1964','agrônomo'),
  ('The Lich','01/07/1964','agrônomo'),
  ('Lumpy Space King & Queen','01/07/1964','agrônomo'),
  ('Magic Man','01/07/1964','agrônomo'),
  ('Maja','01/07/1964','agrônomo'),
  ('Toronto','01/07/1964','agrônomo'),
  ('Tree Trunks','01/07/1964','agrônomo'),
  ('T.V.','01/07/1964','agrônomo'),
  ('Viola','01/07/1964','agrônomo')
;

INSERT INTO produto (descricao, area_plantada, id_trabalhador) VALUES
  ('rosa', random() * 10000, (SELECT id_trabalhador FROM trabalhador ORDER BY RANDOM() LIMIT 1)),
  ('milho', random() * 10000, (SELECT id_trabalhador FROM trabalhador ORDER BY RANDOM() LIMIT 1)),
  ('cominho', random() * 10000, (SELECT id_trabalhador FROM trabalhador ORDER BY RANDOM() LIMIT 1)),
  ('pimenta', random() * 10000, (SELECT id_trabalhador FROM trabalhador ORDER BY RANDOM() LIMIT 1)),
  ('batata doce', random() * 10000, (SELECT id_trabalhador FROM trabalhador ORDER BY RANDOM() LIMIT 1)),
  ('arroz', random() * 10000, (SELECT MIN(id_trabalhador) FROM trabalhador LIMIT 1)),
  ('macaxeira', random() * 10000, (SELECT MIN(id_trabalhador) FROM trabalhador LIMIT 1)),
  ('feijão', random() * 10000, (SELECT id_trabalhador FROM trabalhador ORDER BY RANDOM() LIMIT 1))
;

INSERT INTO comprador (nome_comprador, telefone_comprador, cidade_comprador) VALUES
  ('Death','08488887777','Natal'),
  ('Doctor Princess','08488887741','Natal'),
  ('Dr. Ice Cream','08488887742','Natal'),
  ('Fern','08488887743','Natal'),
  ('Flambo','08488887744','Natal'),
  ('Flame King','08488887745','Moscow'),
  ('Forest Wizard','08488887746','Moscow'),
  ('Gingerbread Cookie','08488887747','Moscow'),
  ('Gingerbread Muto','08488887748','Natal'),
  ('Grassy Wizard','08488887749','Natal'),
  ('Gumball Guardian','08488887751','Natal'),
  ('Gunter','08488887752','Natal'),
  ('Manfried','08488887753','Moscow'),
  ('Margaret','08488887754','Parnamirim'),
  ('Martin','08488287741','Parnamirim'),
  ('The Morrow','08418887741','Parnamirim'),
  ('Mr. Cupcake','08488886741','Parnamirim'),
  ('Mr. Fox','08488887841','Moscow'),
  ('Mr. Pig','08488877741','Parnamirim'),
  ('Neptr','08488987741','Parnamirim'),
  ('Nurse Pound Cake','08480887741','Parnamirim'),
  ('Party God','08488887740','Parnamirim'),
  ('Peppermint Butler','08488387741','Parnamirim'),
  ('Phil','08488877412','Natal'),
  ('Prismo','08488877414','Natal'),
  ('Pup Gang','0848887741','Natal'),
  ('Shelby','0848888741','Natal'),
  ('Snail','0854888741','Natal'),
  ('Starchy','084888741','Natal'),
  ('Susan Strong','0488887741','Natal'),
  ('Ricardio','98488887741','Natal'),
  ('Root Beer Guy','07488887741','Natal'),
  ('Tiffany','0848888774','Moscow')
;

WITH datas AS (
  SELECT
    generate_series('2017-01-01 00:00'::timestamp, current_date, '10 days') AS data_venda,
    generate_series('2017-01-01 00:00'::timestamp, current_date, '10 days') AS data_recebimento
  )
INSERT INTO venda (id_comprador, id_produto, data_venda, data_recebimento, quantidade, valor)
  SELECT DISTINCT ON (id_comprador, id_produto)
    id_comprador,
    id_produto,
    datas.data_venda,
    datas.data_recebimento,
    RANDOM() * 200,
    (RANDOM() * 100000)::numeric::money
  FROM datas CROSS JOIN comprador CROSS JOIN produto;
;

UPDATE venda SET data_recebimento = NULL WHERE id_venda IN (
  SELECT id_venda FROM venda ORDER BY RANDOM() LIMIT 50
);

-- Para a última questão
DELETE FROM venda WHERE id_produto = (SELECT MAX(id_produto) FROM produto);
