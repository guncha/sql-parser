SELECT *
FROM hats
WHERE bees LIKE '%somebees%';

SELECT *
FROM hats
WHERE bees ILIKE '%somebees%' ESCAPE '@';
