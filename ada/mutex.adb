with Ada.integer_text_IO; use Ada.integer_text_IO;

procedure mutex is
    c: integer;
    task type P;

    task body P is
    begin 
        -- apparently you don't need to declare i anywhere
        for i in 1..20 loop
            c := c + 1;
        end loop;
    end P;
begin
    c := 0;
    -- making a block statement so put the execution of procedures and
    -- put() occur sequentially (the procedures do execute concurrently)
    declare 
        P1, P2: P;
    begin 
        null;
    end;
    put(c);
end mutex;
