GRANT RELOAD, REPLICATION CLIENT, REPLICATION SLAVE ON *.* TO 'wbh'@'%';

CREATE TABLE IF NOT EXISTS t1 (
  id INT NOT NULL,
  recorded_at DATETIME NOT NULL,
  payload varchar(255) NOT NULL,
  PRIMARY KEY (id, recorded_at),
  KEY t1_payload_idx (payload)
)
PARTITION BY RANGE (YEAR(recorded_at)) (
  PARTITION t1_p_past VALUES LESS THAN (2025),
  PARTITION t1_p_2025 VALUES LESS THAN (2026),
  PARTITION t1_p_2026 VALUES LESS THAN (2027),
  PARTITION t1_p_future VALUES LESS THAN MAXVALUE
);

-- 200k rows, one every 15 minutes from mid-2023 to 2029, spread over all partitions
SET SESSION cte_max_recursion_depth = 200000;
INSERT INTO t1 (id, recorded_at, payload)
WITH RECURSIVE seq (n) AS (SELECT 1 UNION ALL SELECT n + 1 FROM seq WHERE n < 200000)
SELECT n, '2023-06-01' + INTERVAL n * 15 MINUTE, MD5(n) FROM seq;
