-- original: tpch01.test
-- credit:   http://www.sqlite.org/src/tree?ci=trunk&name=test

CREATE TABLE NATION  ( N_NATIONKEY  INTEGER NOT NULL,
                              N_NAME       CHAR(25) NOT NULL,
                              N_REGIONKEY  INTEGER NOT NULL,
                              N_COMMENT    VARCHAR(152));
  CREATE TABLE REGION  ( R_REGIONKEY  INTEGER NOT NULL,
                              R_NAME       CHAR(25) NOT NULL,
                              R_COMMENT    VARCHAR(152));
  CREATE TABLE PART  ( P_PARTKEY     INTEGER NOT NULL,
                            P_NAME        VARCHAR(55) NOT NULL,
                            P_MFGR        CHAR(25) NOT NULL,
                            P_BRAND       CHAR(10) NOT NULL,
                            P_TYPE        VARCHAR(25) NOT NULL,
                            P_SIZE        INTEGER NOT NULL,
                            P_CONTAINER   CHAR(10) NOT NULL,
                            P_RETAILPRICE DECIMAL(15,2) NOT NULL,
                            P_COMMENT     VARCHAR(23) NOT NULL );
  CREATE TABLE SUPPLIER ( S_SUPPKEY     INTEGER NOT NULL,
                               S_NAME        CHAR(25) NOT NULL,
                               S_ADDRESS     VARCHAR(40) NOT NULL,
                               S_NATIONKEY   INTEGER NOT NULL,
                               S_PHONE       CHAR(15) NOT NULL,
                               S_ACCTBAL     DECIMAL(15,2) NOT NULL,
                               S_COMMENT     VARCHAR(101) NOT NULL);
  CREATE TABLE PARTSUPP ( PS_PARTKEY     INTEGER NOT NULL,
                               PS_SUPPKEY     INTEGER NOT NULL,
                               PS_AVAILQTY    INTEGER NOT NULL,
                               PS_SUPPLYCOST  DECIMAL(15,2)  NOT NULL,
                               PS_COMMENT     VARCHAR(199) NOT NULL );
  CREATE TABLE CUSTOMER ( C_CUSTKEY     INTEGER NOT NULL,
                               C_NAME        VARCHAR(25) NOT NULL,
                               C_ADDRESS     VARCHAR(40) NOT NULL,
                               C_NATIONKEY   INTEGER NOT NULL,
                               C_PHONE       CHAR(15) NOT NULL,
                               C_ACCTBAL     DECIMAL(15,2)   NOT NULL,
                               C_MKTSEGMENT  CHAR(10) NOT NULL,
                               C_COMMENT     VARCHAR(117) NOT NULL);
  CREATE TABLE ORDERS  ( O_ORDERKEY       INTEGER NOT NULL,
                             O_CUSTKEY        INTEGER NOT NULL,
                             O_ORDERSTATUS    CHAR(1) NOT NULL,
                             O_TOTALPRICE     DECIMAL(15,2) NOT NULL,
                             O_ORDERDATE      DATE NOT NULL,
                             O_ORDERPRIORITY  CHAR(15) NOT NULL,  
                             O_CLERK          CHAR(15) NOT NULL, 
                             O_SHIPPRIORITY   INTEGER NOT NULL,
                             O_COMMENT        VARCHAR(79) NOT NULL);
  CREATE TABLE LINEITEM ( L_ORDERKEY    INTEGER NOT NULL,
                               L_PARTKEY     INTEGER NOT NULL,
                               L_SUPPKEY     INTEGER NOT NULL,
                               L_LINENUMBER  INTEGER NOT NULL,
                               L_QUANTITY    DECIMAL(15,2) NOT NULL,
                               L_EXTENDEDPRICE  DECIMAL(15,2) NOT NULL,
                               L_DISCOUNT    DECIMAL(15,2) NOT NULL,
                               L_TAX         DECIMAL(15,2) NOT NULL,
                               L_RETURNFLAG  CHAR(1) NOT NULL,
                               L_LINESTATUS  CHAR(1) NOT NULL,
                               L_SHIPDATE    DATE NOT NULL,
                               L_COMMITDATE  DATE NOT NULL,
                               L_RECEIPTDATE DATE NOT NULL,
                               L_SHIPINSTRUCT CHAR(25) NOT NULL,
                               L_SHIPMODE     CHAR(10) NOT NULL,
                               L_COMMENT      VARCHAR(44) NOT NULL);
  CREATE INDEX npki on nation(N_NATIONKEY);
  CREATE INDEX rpki on region(R_REGIONKEY);
  CREATE INDEX ppki on part(P_PARTKEY);
  CREATE INDEX spki on supplier(S_SUPPKEY);
  CREATE INDEX pspki on partsupp(PS_PARTKEY, PS_SUPPKEY);
  CREATE INDEX cpki on customer(C_CUSTKEY);
  CREATE INDEX opki on orders(O_ORDERKEY);
  CREATE INDEX lpki on lineitem(L_ORDERKEY, L_LINENUMBER);
  CREATE INDEX nrki on nation(n_regionkey);
  CREATE INDEX snki on supplier(s_nationkey);
  CREATE INDEX cnki on customer(c_nationkey);
  CREATE INDEX ocki on orders(O_CUSTKEY);
  CREATE INDEX odi on orders(O_ORDERDATE);
  CREATE INDEX lpki2 on lineitem(L_PARTKEY);
  CREATE INDEX lski on lineitem(L_SUPPKEY);
  CREATE INDEX lsdi on lineitem(L_SHIPDATE);
  CREATE INDEX lcdi on lineitem(L_COMMITDATE);
  CREATE INDEX lrdi on lineitem(L_RECEIPTDATE);
  CREATE INDEX bootleg_nni on nation(N_NAME);
  CREATE INDEX bootleg_psi on part(p_size);
  CREATE INDEX bootleg_pti on part(p_type);
  ANALYZE sqlite_master;
  INSERT INTO sqlite_stat1 VALUES('LINEITEM','lrdi','600572 236');
  INSERT INTO sqlite_stat1 VALUES('LINEITEM','lcdi','600572 244');
  INSERT INTO sqlite_stat1 VALUES('LINEITEM','lsdi','600572 238');
  INSERT INTO sqlite_stat1 VALUES('LINEITEM','lski','600572 601');
  INSERT INTO sqlite_stat1 VALUES('LINEITEM','lpki2','600572 31');
  INSERT INTO sqlite_stat1 VALUES('LINEITEM','lpki','600572 5 1');
  INSERT INTO sqlite_stat1 VALUES('ORDERS','odi','150000 63');
  INSERT INTO sqlite_stat1 VALUES('ORDERS','ocki','150000 15');
  INSERT INTO sqlite_stat1 VALUES('ORDERS','opki','150000 1');
  INSERT INTO sqlite_stat1 VALUES('CUSTOMER','cnki','15000 600');
  INSERT INTO sqlite_stat1 VALUES('CUSTOMER','cpki','15000 1');
  INSERT INTO sqlite_stat1 VALUES('PARTSUPP','pspki','80000 4 1');
  INSERT INTO sqlite_stat1 VALUES('SUPPLIER','snki','1000 40');
  INSERT INTO sqlite_stat1 VALUES('SUPPLIER','spki','1000 1');
  INSERT INTO sqlite_stat1 VALUES('PART','bootleg_pti','20000 134');
  INSERT INTO sqlite_stat1 VALUES('PART','bootleg_psi','20000 400');
  INSERT INTO sqlite_stat1 VALUES('PART','ppki','20000 1');
  INSERT INTO sqlite_stat1 VALUES('REGION','rpki','5 1');
  INSERT INTO sqlite_stat1 VALUES('NATION','bootleg_nni','25 1');
  INSERT INTO sqlite_stat1 VALUES('NATION','nrki','25 5');
  INSERT INTO sqlite_stat1 VALUES('NATION','npki','25 1');
  ANALYZE sqlite_master
;EXPLAIN QUERY PLAN
       select
               o_year,
               sum(case
                       when nation = 'EGYPT' then volume
                       else 0
               end) / sum(volume) as mkt_share
       from
               (
                       select
                               strftime('%Y', o_orderdate) as o_year,
                               l_extendedprice * (1 -l_discount) as volume,
                               n2.n_name as nation
                       from
                               part,
                               supplier,
                               lineitem,
                               orders,
                               customer,
                               nation n1,
                               nation n2,
                               region
                       where
                               p_partkey = l_partkey
                               and s_suppkey = l_suppkey
                               and l_orderkey = o_orderkey
                               and o_custkey = c_custkey
                               and c_nationkey = n1.n_nationkey
                               and n1.n_regionkey = r_regionkey
                               and r_name = 'MIDDLE EAST'
                               and s_nationkey = n2.n_nationkey
                               and o_orderdate between  '1995-01-01' and '1996-12-31'
                               and p_type = 'LARGE PLATED STEEL'
               ) as all_nations
       group by
               o_year
       order by
               o_year
;select
    c_custkey,    c_name,    sum(l_extendedprice * (1 -l_discount)) as revenue,
    c_acctbal,    n_name,    c_address,    c_phone,    c_comment
from
    customer,    orders,    lineitem,    nation
where
    c_custkey = o_custkey    and l_orderkey = o_orderkey
    and o_orderdate >=  '1994-08-01'    and o_orderdate < date('1994-08-01', '+3 month')
    and l_returnflag = 'R'    and c_nationkey = n_nationkey
group by
    c_custkey,    c_name,    c_acctbal,    c_phone,    n_name, c_address,    c_comment
order by
    revenue desc;