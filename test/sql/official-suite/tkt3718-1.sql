-- original: tkt3718.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

CREATE TABLE t1(a PRIMARY KEY, b);
    INSERT INTO t1 VALUES(1, 'one');
    INSERT INTO t1 VALUES(2, 'two');
    INSERT INTO t1 VALUES(3, 'three');
    INSERT INTO t1 VALUES(4, 'four');
    INSERT INTO t1 VALUES(5, 'five');
    CREATE TABLE t2(a PRIMARY KEY, b)
;SELECT f2(sub_a)
;BEGIN;
    INSERT INTO t2 SELECT a, b FROM t1;
    INSERT INTO t2 SELECT a+5, f1(b) FROM t1;
    COMMIT
;SELECT a FROM t2
;DELETE FROM t2 WHERE a > 5;
    PRAGMA count_changes = 1;
    BEGIN
;INSERT INTO t2 SELECT a+5, b||'+5' FROM t1
;SELECT f2('three')
;COMMIT;
    SELECT a FROM t2
;pragma count_changes=0
;SELECT sql(1, 'DELETE FROM t2 WHERE a = '||a ) FROM t2 WHERE a>5
;SELECT a from t2
;DELETE FROM t2 WHERE a > 5;
    BEGIN;
    INSERT INTO t2 SELECT a+5, sql(a==3,
        'INSERT INTO t2 SELECT a+10, f2(b) FROM t1'
    ) FROM t1
;COMMIT;
    SELECT a FROM t2
;DELETE FROM t2 WHERE a > 5;
    BEGIN;
    INSERT INTO t2 SELECT a+5, sql(a==3,
        'INSERT INTO t2 SELECT a+10, b FROM t1'
    ) FROM t1;
    COMMIT
;SELECT a FROM t2 ORDER BY a+0
;DELETE FROM t2;
      INSERT INTO t2 SELECT a+5, b FROM t1;
      INSERT INTO t2 SELECT a+15, b FROM t1
;COMMIT
;SELECT a FROM t2 ORDER BY a+0
;DELETE FROM t2;
      INSERT INTO t2 SELECT a+5, b FROM t1;
      INSERT INTO t2 SELECT a+15, b FROM t1;
      INSERT INTO t2 SELECT a+25, b FROM t1
;COMMIT
;SELECT a FROM t2 WHERE (a%5)==0 ORDER BY a+0
;SELECT 
        (SELECT sum(a) FROM t2)==(SELECT sum(a*5-10) FROM t2 WHERE (a%5)==0);