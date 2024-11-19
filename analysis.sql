-- For ease of use with CSVs, this script is designed for DuckDB https://duckdb.org/
-- It should be possible to adapt this for SQLite3 or PostgreSQL using CSV import.

-- To see trends within a single CI collated by distribution type
select * from "results.csv" where ci_method = 1 order by N, param_info;

-- To aggregate results between runs during EDA
copy (select ci_method, N, mean(percent_missed), param_info from "results.csv" group by all) to 'results.csv';

-- To analyze stddev of `percent_missed` in sliding window w.r.t. N. A more complex query could probably do this automatically.
select ci_method, param_info, stddev(percent_missed) from "results.csv" where N in (10, 100);

-- To list the parameters of the distributions used (one param = Bernoulli, two params = Uniform, zero params = "Noisy")
select distinct param_info from "results.csv"

