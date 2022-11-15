-- support function with recursion
CREATE OR REPLACE FUNCTION recursion(value numeric DEFAULT 10)
RETURNS numeric
AS $$
  BEGIN
    IF value = 1 OR value = 2 THEN
    RETURN 1;
    END IF;
    RETURN recursion(value - 1) + recursion(value - 2);
    END;
$$ LANGUAGE plpgsql;

-- main function with loop
CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop numeric DEFAULT 10)
    RETURNS TABLE(valu integer)
AS $$
    DECLARE
    arr integer ARRAY [0];
    finish integer;
    BEGIN
-- function only works until 35 of fibonacci numbers
        FOR i IN 1..35
            LOOP
            arr = array_append(arr, recursion(i));
            finish := max(gg.bb) FROM (SELECT unnest(arr) AS bb) AS gg;
            IF (finish > pstop) THEN
                arr = array_remove(arr, finish);
                EXIT;
            END IF;

            END LOOP;
        RETURN QUERY
        SELECT *
        FROM unnest(arr);
    END;
$$
LANGUAGE plpgsql;

-- argument is values for maximum value in fibonacci series
SELECT gg.valu FROM fnc_fibonacci(15632) AS gg;
