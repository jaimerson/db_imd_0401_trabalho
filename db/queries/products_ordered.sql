SELECT descricao, to_char(area_plantada, 'FM999999999.00') as area_plantada,
  id_trabalhador,
  nome as nome_trabalhador, especialidade as especialidade_trabalhador
FROM produto
  INNER JOIN trabalhador USING(id_trabalhador)
ORDER BY id_trabalhador DESC, area_plantada;
