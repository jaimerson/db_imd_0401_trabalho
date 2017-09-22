SELECT id_produto, c.nome_comprador, quantidade, valor
  FROM venda
  INNER JOIN comprador c USING(id_comprador)
  WHERE quantidade BETWEEN 50 AND 200
    OR valor < 60000::money;
