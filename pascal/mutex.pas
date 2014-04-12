program mutex;
var 

process P1;
var

begin
   flag1 := true; 

   while flag2 do
       turn := 1;

       if turn and flag1 then
           c := c + 1;

        turn := 2;
        flag1 := false

end

process P2;
var

begin
    flag2 := true;

    while flag1 do
       turn := 2;

       if turn and flag2 then
           c := c + 1;

        turn := 1;
        flag2 := false;
end

begin
end.
