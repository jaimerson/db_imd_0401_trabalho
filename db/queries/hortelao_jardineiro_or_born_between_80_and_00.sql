SELECT nome, especialidade, data_nascimento
  FROM trabalhador
  WHERE especialidade IN ('hortelão', 'jardineiro')
    OR data_nascimento BETWEEN '1980-01-01' AND '2000-01-01';
