SELECT descricao AS descricao_produto,
  COUNT(venda.id_venda) AS numero_de_vendas,
  SUM(venda.valor) AS total_a_receber
FROM venda INNER JOIN produto USING(id_produto)
WHERE data_recebimento IS NULL
GROUP BY descricao;

