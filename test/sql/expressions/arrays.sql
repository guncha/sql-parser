SELECT name FROM sal_emp WHERE pay_by_quarter[1] <> pay_by_quarter[2];
SELECT pay_by_quarter[3] FROM sal_emp;
SELECT schedule[1:2][1:1] FROM sal_emp WHERE name = 'Bill';
SELECT schedule[1:2][2] FROM sal_emp WHERE name = 'Bill';
SELECT schedule[:2][2:] FROM sal_emp WHERE name = 'Bill';
SELECT schedule[:][1:1] FROM sal_emp WHERE name = 'Bill';
UPDATE sal_emp SET pay_by_quarter[4] = 15000
    WHERE name = 'Bill';
UPDATE sal_emp SET pay_by_quarter[1:2] = '{27000,27000}'
    WHERE name = 'Carol';

SELECT ARRAY[];
SELECT ARRAY[[1,2], [3,4]];
SELECT ARRAY[1, 1+1, 2*3];
