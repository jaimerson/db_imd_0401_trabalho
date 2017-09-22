SELECT descricao AS descricao_produto,
  valor,
  valor * 0.05 AS multa,
  data_venda,
  current_date::date - data_venda::date AS dias_de_atraso
FROM venda
  INNER JOIN produto USING(id_produto)
WHERE data_recebimento IS NULL;

