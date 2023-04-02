create or replace procedure updateMyTable(
       idd number,
       value number
)
is
begin
  UPDATE MYTABLE
  SET val = value where id = idd;
end;
