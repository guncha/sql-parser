-- original: tkt3357.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

create table a(id integer primary key, b_id integer, myvalue varchar);
    create table b(id integer primary key, bvalue varchar);
    insert into a(b_id, myvalue) values(1,'Test');
    insert into a(b_id, myvalue) values(1,'Test2');
    insert into a(b_id, myvalue) values(1,'Test3');
    insert into b(bvalue) values('btest')
;SELECT cc.id, cc.b_id, cc.myvalue, dd.bvalue 
    FROM (
      SELECT DISTINCT a.id, a.b_id, a.myvalue FROM a
      INNER JOIN b ON a.b_id = b.id WHERE b.bvalue = 'btest'
    ) cc
    LEFT OUTER JOIN b dd ON cc.b_id = dd.id
;SELECT cc.id, cc.b_id, cc.myvalue
    FROM (
      SELECT a.id, a.b_id, a.myvalue 
      FROM a, b WHERE a.b_id = b.id
    ) cc
    LEFT OUTER JOIN b dd ON cc.b_id = dd.id
;SELECT cc.id, cc.b_id, cc.myvalue
    FROM (
      SELECT DISTINCT a.id, a.b_id, a.myvalue 
      FROM a, b WHERE a.b_id = b.id
    ) cc
    LEFT OUTER JOIN b dd ON cc.b_id = dd.id;