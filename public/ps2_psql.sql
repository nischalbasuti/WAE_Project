---------------------------------------7.-------------------------------------
DROP VIEW stocks_i_like;
DROP TABLE my_stocks CASCADE;
DROP TABLE stock_prices CASCADE;
DROP TABLE newly_acquired_stocks CASCADE;

CREATE TABLE my_stocks (
	symbol VARCHAR(20) NOT NULL,
	n_shares INTEGER NOT NULL,
	date_acquired DATE NOT NULL
);

\copy my_stocks FROM '/home/ruangtiwa/wae/ps2_psql/detail_stock.txt' WITH delimiter E'\t';

---------------------------------------8.-----------------------------------

CREATE TABLE stock_prices (
	symbol VARCHAR(20) NOT NULL,
	quote_date DATE NOT NULL,
	price DECIMAL NOT NULL
);

INSERT INTO stock_prices (
	symbol, 
	quote_date, 
	price)
SELECT DISTINCT ON 
	(symbol) symbol, 
	CURRENT_DATE,
	31.415
FROM my_stocks;

CREATE TABLE newly_acquired_stocks (
	symbol VARCHAR(20) NOT NULL, 
	n_shares INTEGER NOT NULL, 
	date_acquired DATE NOT NULL 
);

INSERT INTO newly_acquired_stocks (
	symbol, 
	n_shares, 
	date_acquired)
SELECT * FROM my_stocks 
limit (SELECT COUNT(symbol)/2 FROM my_stocks);

SELECT * FROM newly_acquired_stocks;

----------------------------------------9.----------------------------------

SELECT stock_prices.symbol, n_shares, (price/n_shares) price_per_share, (price*n_shares) AS value 
FROM my_stocks, stock_prices 
WHERE my_stocks.symbol = stock_prices.symbol;

---------------------------------------10.-------------------------------------

INSERT INTO my_stocks (symbol, n_shares, date_acquired) VALUES ('SSS', '80', current_date);

SELECT stock_prices.symbol, my_stocks.n_shares, ((stock_prices.price)/(my_stocks.n_shares)) AS price_per_share 
FROM my_stocks FULL OUTER JOIN stock_prices ON stock_prices.symbol = my_stocks.symbol;

SELECT my_stocks.symbol, my_stocks.n_shares, ((stock_prices.price)/(my_stocks.n_shares)) AS price_per_share 
FROM my_stocks FULL OUTER JOIN stock_prices ON stock_prices.symbol = my_stocks.symbol;

---------------------------------------11.---------------------------------

CREATE OR REPLACE function sum_symbol (string VARCHAR)
RETURNS INTEGER AS $$
DECLARE
ascii_sum INTEGER := 0;
chars VARCHAR[];
c VARCHAR;
BEGIN 
SELECT regexp_split_to_array (string, '') INTO chars;
FOREACH c IN ARRAY chars
LOOP
ascii_sum = ascii_sum + ASCII(c);
END LOOP;
RETURN ascii_sum;
END;
$$ LANGUAGE PLPGSQL;

UPDATE stock_prices SET price = sum_symbol(stock_prices.symbol);

CREATE OR REPLACE FUNCTION portfolio_value()
RETURNS numeric AS $$
DECLARE
sum_value numeric := 0;
n_share CURSOR FOR SELECT n_shares*price val from my_stocks full outer join stock_prices on stock_prices.symbol = my_stocks.symbol;
num_share RECORD;
BEGIN
open n_share;
IF n_share IS NOT NULL THEN
LOOP
 FETCH n_share INTO num_share;
 IF num_share.val <> 0 THEN
 RAISE INFO '% ===> %',sum_value,num_share.val;
 sum_value = sum_value + num_share.val; 
 END IF;
 EXIT WHEN NOT FOUND;
END LOOP;
END IF;
close n_share;
RETURN sum_value;
END;
$$ LANGUAGE plpgsql;

SELECT portfolio_value();

-------------------------------12.---------------------------------------

INSERT INTO my_stocks (symbol, n_shares, date_acquired) 
SELECT my_stocks.symbol, my_stocks.n_shares, CURRENT_DATE 
FROM my_stocks, stock_prices
WHERE my_stocks.symbol = stock_prices.symbol 
AND (SELECT AVG(price) FROM stock_prices) < stock_prices.price;

SELECT symbol, SUM(n_shares) AS total_shares FROM my_stocks GROUP BY symbol;

INSERT INTO my_stocks (symbol, n_shares, date_acquired) VALUES ('AAA', '80', CURRENT_DATE);

SELECT my_stocks.symbol , SUM(n_shares) AS sum_shares, ((SUM(n_shares))*price) AS sum_value 
FROM my_stocks , stock_prices 
WHERE my_stocks.symbol = stock_prices.symbol 
GROUP BY my_stocks.symbol,price 
HAVING COUNT(my_stocks.symbol) >= 2;

-----------------------------------13.---------------------------------

CREATE VIEW stocks_i_like AS
SELECT my_stocks.symbol , SUM(n_shares) AS sum_shares, ((SUM(n_shares))*price) AS sum_value 
FROM my_stocks , stock_prices 
WHERE my_stocks.symbol = stock_prices.symbol 
GROUP BY my_stocks.symbol,price 
HAVING COUNT(my_stocks.symbol) >= 2;

SELECT * FROM stocks_i_like;
------------------------------------------------------------------------







