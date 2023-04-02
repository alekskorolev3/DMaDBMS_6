create or replace procedure insertMyTable(
       value number
)
is
begin
  INSERT INTO MYTABLE(val) VALUES(value);
end;
