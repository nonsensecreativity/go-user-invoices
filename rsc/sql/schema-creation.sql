\c user_invoices;

CREATE SCHEMA invoices;

/*--------------------------------------------------------------*/

CREATE TABLE invoices.user_auth (
   name     VARCHAR(32)
  ,password VARCHAR(32)
);

COMMENT ON TABLE invoices.user_auth IS '';
COMMENT ON COLUMN invoices.user_auth.name IS '';
COMMENT ON COLUMN invoices.user_auth.password IS '';

/*--------------------------------------------------------------*/

CREATE TABLE invoices.invoice (
   id           SERIAL
  ,amount       DECIMAL(18, 6)
      CHECK (amount > 0)
  ,document     VARCHAR(14)
  ,month        SMALLINT 
      CHECK (month <= 12)
     ,CHECK (month > 0)
  ,year         INT
      CHECK (year > 0)
  ,is_active    BOOLEAN
);

COMMENT ON TABLE invoices.invoice IS '';
COMMENT ON COLUMN invoices.invoice.id IS '';
COMMENT ON COLUMN invoices.invoice.amount IS '';
COMMENT ON COLUMN invoices.invoice.document IS '';
COMMENT ON COLUMN invoices.invoice.month IS '';
COMMENT ON COLUMN invoices.invoice.year IS '';
COMMENT ON COLUMN invoices.invoice.is_active IS '';

/*--------------------------------------------------------------*/

CREATE OR REPLACE FUNCTION validate_cpf()
    RETURNS TRIGGER AS $$
    DECLARE
      cpf_str  TEXT ARRAY;
      is_valid BOOLEAN := FALSE;
    BEGIN
    
        -- Quebra a entrada passada
        cpf_str := STRING_TO_ARRAY(cpf, '');
        
        -- Verificar tamanho do array
        IF (array_length(cpf_str, 1) == 11) THEN
          -- RETURN FALSE;
        END IF;
    
        -- Converter em array de integer
        
        -- Multiplicar o arranjo de ints com os pesos
        
        -- Verificar o 1º D.V.
        
        -- Somar o produto anterior com o 1º D.V. multiplicado com seu peso
        
        -- Verificar o 2º D.V.
        
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql
IMMUTABLE STRICT;

COMMENT ON FUNCTION validate_cpf() IS '';

/*--------------------------------------------------------------*/

CREATE TRIGGER verify_inserted_document
   BEFORE INSERT OR UPDATE
   ON invoices.invoice FOR EACH ROW
   EXECUTE PROCEDURE validate_cpf();
   
COMMENT ON TRIGGER verify_inserted_document ON invoices.invoice IS '';
