CREATE DATABASE market_repository;

CREATE SCHEMA market;
SHOW search_path;

SET search_path TO market;
ALTER ROLE dmitry SET search_path = market;


CREATE TABLE Items (item_id BIGSERIAl PRIMARY KEY,
					model VARCHAR(32) NOT NULL,
					brand VARCHAR(32) NOT NULL,
					attributes VARCHAR(128) NOT NULL,
					price NUMERIC(12,2) CHECK (price > 0),
					currency VARCHAR(1) NOT NULL,
					quantity INT CHECK (quantity >= 0) NOT NULL, 
					UNIQUE (model, attributes)
				);				

CREATE EXTENSION pgcrypto;			
			
CREATE TABLE IF NOT EXISTS personal_account (
	account_id BIGSERIAL NOT NULL UNIQUE,
	email VARCHAR(128) PRIMARY KEY,
	password TEXT NOT NULL,
	name VARCHAR(32) NOT NULL,
	surname VARCHAR(32) NOT NULL,
	image VARCHAR(124) NOT NULL,
	birthday DATE NOT NULL,
	country VARCHAR(64) NOT NULL,
	city VARCHAR(256) NOT NULL,
	address VARCHAR(256) NOT NULL,
	phone_number TEXT CONSTRAINT phone_number_constraint NOT NULL,
	gender VARCHAR(12) NOT NULL,
	CONSTRAINT birthday_constraint CHECK(DATE_PART('year',current_date)-DATE_PART('year',birthday) > 18),
	CONSTRAINT phone_number_constraint CHECK (((phone_number ~ '\+7[0-9]{10}$') AND (country = 'russia' OR country = 'россия')) 
		OR (country != 'russia' AND country != 'россия'))
	);


CREATE TABLE IF NOT EXISTS sell_history (
	sell_id BIGSERIAl PRIMARY KEY,
	item_id BIGINT REFERENCES Items (item_id) ON UPDATE CASCADE ON DELETE RESTRICT,
	email VARCHAR(32) NOT NULL, 
	FOREIGN KEY (email) REFERENCES personal_account (email) ON DELETE RESTRICT,
	quantity INT CHECK (quantity >= 0) NOT NULL,
	sell_date TIMESTAMPTZ NOT NULL  
);
 
CREATE INDEX IF NOT EXISTS item_id_idx ON sell_history (item_id);

CREATE INDEX IF NOT EXISTS login_idx ON sell_history (login);

ALTER SEQUENCE items_item_id_seq RESTART WITH 1;
TRUNCATE TABLE items CASCADE;
DROP TABLE items CASCADE;

DROP TABLE personal_account CASCADE;
DROP TABLE sell_history CASCADE;


