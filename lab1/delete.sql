create or replace procedure deleteInMyTable(
       idd number
)
is
begin
  DELETE FROM MYTABLE
  where id = idd;
end;
