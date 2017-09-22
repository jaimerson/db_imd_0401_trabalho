SELECT descricao, trunc(area_plantada, 2),
  nome as nome_trabalhador,
  especialidade as especialidade_trabalhador
FROM produto INNER JOIN trabalhador USING(id_trabalhador);
