SELECT depname, empno, salary, avg(salary) OVER (PARTITION BY depname) FROM empsalary;

SELECT depname, empno, salary,
       rank() OVER (PARTITION BY depname ORDER BY salary DESC)
FROM empsalary;

SELECT salary, sum(salary) OVER () FROM empsalary;

SELECT salary, sum(salary) OVER (ORDER BY salary) FROM empsalary;

SELECT depname, empno, salary, enroll_date
FROM
  (SELECT depname, empno, salary, enroll_date,
          rank() OVER (PARTITION BY depname ORDER BY salary DESC, empno) AS pos
     FROM empsalary
  ) AS ss
WHERE pos < 3;

SELECT sum(salary) OVER w, avg(salary) OVER (w)
  FROM empsalary
  WINDOW w AS (PARTITION BY depname ORDER BY salary DESC);
