-- original: tkt1444.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

CREATE TABLE DemoTable (x INTEGER, TextKey TEXT, DKey Real);
    CREATE INDEX DemoTableIdx ON DemoTable (TextKey);
    INSERT INTO DemoTable VALUES(9,8,7);
    INSERT INTO DemoTable VALUES(1,2,3);
    CREATE VIEW DemoView AS SELECT * FROM DemoTable ORDER BY TextKey;
    SELECT * FROM DemoTable UNION ALL SELECT * FROM DemoView ORDER BY 1
;SELECT * FROM DemoTable UNION ALL SELECT * FROM DemoView
;DROP VIEW DemoView;
    CREATE VIEW DemoView AS SELECT * FROM DemoTable;
    SELECT * FROM DemoTable UNION ALL SELECT * FROM DemoView ORDER BY 1
;SELECT * FROM DemoTable UNION ALL SELECT * FROM DemoView;