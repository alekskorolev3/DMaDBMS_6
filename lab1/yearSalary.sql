create or replace function yearSalary(
       amount number,
       percent number
) return number
is
  p number;
begin

  if (amount <= 0) then
    dbms_output.put_line('Invalid amount!');
    return 0;
  end if;
  
  if (percent < 0) then
    dbms_output.put_line('Invalid percent!');
    return 0;
  end if;

  if mod(percent, 1) != 0 then
    p:= 1 + percent;
  else 
    p:= 1 + percent / 100;
  end if;
  return p * 12 * amount;  
end;
