SELECT descricao, trunc(area_plantada), id_trabalhador,
  nome as nome_trabalhador, especialidade as especialidade_trabalhador
FROM produto
  INNER JOIN trabalhador USING(id_trabalhador)
ORDER BY id_trabalhador DESC, area_plantada;
