CREATE OR REPLACE FUNCTION PART_PHONE(
    str TEXT
)
    RETURNS TEXT AS
$$
SELECT '+'
           || SUBSTRING(str FROM 1 FOR 4)
           || '*******'
    ;
$$
    LANGUAGE SQL IMMUTABLE
                 SECURITY INVOKER;

CREATE OR REPLACE FUNCTION PART_EMAIL(
    str TEXT
)
    RETURNS TEXT AS
$$
SELECT SUBSTRING(str FROM 1 FOR 2)
           || '***'
           || '@'
           || SUBSTRING(str FROM 6 FOR 2)
           || '***'
           || '.'
           || SUBSTRING(str FROM 11)
    ;
$$
    LANGUAGE SQL IMMUTABLE
                 SECURITY INVOKER;

