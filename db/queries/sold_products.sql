SELECT descricao, nome as nome_trabalhador,
  especialidade as especialidade_trabalhador
FROM produto
  INNER JOIN venda USING(id_produto)
  INNER JOIN trabalhador USING(id_trabalhador)
GROUP BY id_produto, nome_trabalhador, especialidade_trabalhador;
