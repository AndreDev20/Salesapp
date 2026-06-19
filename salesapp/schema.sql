-- ============================================================
-- Script de criação do banco de dados - SalesApp
-- Compatível com PostgreSQL (padrão) e MySQL (comentários abaixo)
-- ============================================================

-- Para PostgreSQL: crie o banco antes de rodar este script:
-- CREATE DATABASE salesdb;
-- \c salesdb

-- Para MySQL:
-- CREATE DATABASE salesdb CHARACTER SET utf8mb4;
-- USE salesdb;

-- ============================================================
-- 1. Tabela SALESMAN
-- ============================================================
CREATE TABLE salesman (
    salesman_id NUMERIC(5)    PRIMARY KEY,
    name        VARCHAR(30)   NOT NULL,
    city        VARCHAR(15),
    commission  DECIMAL(5,2)
);

-- ============================================================
-- 2. Tabela CUSTOMER
-- ============================================================
CREATE TABLE customer (
    customer_id NUMERIC(5)    PRIMARY KEY,
    cust_name   VARCHAR(30)   NOT NULL,
    city        VARCHAR(15),
    grade       NUMERIC(3),
    salesman_id NUMERIC(5),
    CONSTRAINT fk_customer_salesman FOREIGN KEY (salesman_id)
        REFERENCES salesman(salesman_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- ============================================================
-- 3. Tabela ORDERS
-- ============================================================
CREATE TABLE orders (
    ord_no      NUMERIC(5)    PRIMARY KEY,
    purch_amt   DECIMAL(8,2)  NOT NULL,
    ord_date    DATE          NOT NULL,
    customer_id NUMERIC(5)    NOT NULL,
    salesman_id NUMERIC(5)    NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_orders_salesman FOREIGN KEY (salesman_id)
        REFERENCES salesman(salesman_id)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
);

-- ============================================================
-- 4. Dados de exemplo (opcional)
-- ============================================================
INSERT INTO salesman VALUES (5001, 'James Hoog',  'New York', 0.15);
INSERT INTO salesman VALUES (5002, 'Nail Knite',  'Paris',    0.13);
INSERT INTO salesman VALUES (5005, 'Pit Alex',    'London',   0.11);
INSERT INTO salesman VALUES (5006, 'Mc Lyon',     'Paris',    0.14);
INSERT INTO salesman VALUES (5007, 'Paul Adam',   'Rome',     0.13);
INSERT INTO salesman VALUES (5003, 'Lauson Hen',  'San Jose', 0.12);

INSERT INTO customer VALUES (3002, 'Nick Rimando',  'New York',  100, 5001);
INSERT INTO customer VALUES (3007, 'Brad Davis',    'New York',  200, 5001);
INSERT INTO customer VALUES (3005, 'Graham Zusi',   'California',200, 5002);
INSERT INTO customer VALUES (3008, 'Julian Green',  'London',    300, 5002);
INSERT INTO customer VALUES (3004, 'Fabian Johnson', 'Paris',    300, 5006);
INSERT INTO customer VALUES (3009, 'Geoff Cameron', 'Berlin',    100, 5003);

INSERT INTO orders VALUES (70001, 150.5,  '2012-10-05', 3005, 5002);
INSERT INTO orders VALUES (70009, 270.65, '2012-09-10', 3001, 5005);
INSERT INTO orders VALUES (70002, 65.26,  '2012-10-05', 3002, 5001);
INSERT INTO orders VALUES (70004, 110.5,  '2012-08-17', 3009, 5003);
INSERT INTO orders VALUES (70007, 948.5,  '2012-09-10', 3005, 5002);
INSERT INTO orders VALUES (70005, 2400.6, '2012-07-27', 3007, 5001);
INSERT INTO orders VALUES (70008, 5760.0, '2012-09-10', 3002, 5001);
