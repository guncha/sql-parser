SELECT sum(salary) OVER w, avg(salary) OVER (w)
  FROM empsalary
  WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);

SELECT sum(salary) OVER w
  FROM empsalary
  WINDOW w AS (PARTITION BY depname ORDER BY salary DESC)
UNION
SELECT sum FROM empsalary_history
  WINDOW _ AS ();
