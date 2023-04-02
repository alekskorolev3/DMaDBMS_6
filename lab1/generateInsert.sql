create or replace function generateInsert(
  idd number
) return VARCHAR
is
  vv number;
begin
  SELECT VAL INTO vv FROM MYTABLE where id = idd;
  return CONCAT(CONCAT('INSERT INTO MYTABLE (VAL) VALUES (', CAST(vv AS VARCHAR)), ');');
end;
 
