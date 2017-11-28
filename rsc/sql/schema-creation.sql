\c user_invoices;

CREATE SCHEMA invoices;

CREATE TABLE invoices.user_auth (
   name     VARCHAR(32)
  ,password VARCHAR(32)
);

CREATE TABLE invoices.invoice (
   id           SERIAL
  ,amount       DECIMAL(18, 6)
  ,document     VARCHAR(14)
  ,month        SMALLINT
  ,year         INT
  ,is_active    BOOLEAN
);
