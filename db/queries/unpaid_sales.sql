SELECT valor, nome_comprador
  FROM venda INNER JOIN comprador USING(id_comprador)
  WHERE data_recebimento IS NULL;
