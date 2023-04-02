create or replace function checkOdd return VARCHAR
is
  ch number;
  nech number;
begin
  SELECT COUNT(VAL) INTO nech from MYTABLE where mod(VAL ,2) = 1;
  SELECT COUNT(VAL) INTO ch from MYTABLE where mod(VAL ,2) = 0;
  if ch > nech then
    return 'True';
  elsif ch < nech then
    return 'False';
  else
    return 'Equal';
  end if;
end;
  
       
