SELECT
  to_char(SUM(area_plantada), 'FM999999999.99') AS area_total,
  to_char(AVG(area_plantada), 'FM999999999.99') AS area_media,
  COUNT(*)           AS total_produtos
FROM produto;
