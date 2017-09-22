SELECT *
FROM produto
WHERE NOT EXISTS(
  SELECT NULL FROM venda
    WHERE venda.id_produto = produto.id_produto
);
