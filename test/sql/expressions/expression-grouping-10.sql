SELECT * FROM products WHERE name LIKE '% widget' AND number > 0;
SELECT * FROM products WHERE name LIKE '% widget' ESCAPE '' AND number > 0;
SELECT * FROM products WHERE name IS DISTINCT FROM 'Some widget' AND number > 0;