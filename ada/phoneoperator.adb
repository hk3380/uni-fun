with Ada.Text_IO; use Ada.Text_IO;

-- A phone operator program kind of thing
procedure phoneoperator is

   -- Variables used
   number: integer;

   -- Give name, get number
   task Operator is
       entry track(name: in String; number: out integer);
   end Operator;

   -- Task is started at startup and looping for messages
   task body Operator is
   begin
       loop
           -- accepts track calls
           accept track(name: in String; number: out integer) do
               -- some simulation of tracking
               put_line ("The count is " & Integer'Image (track'Count));
               if name = "James" then
                   number := 1;
                   put_line (name & "'s number is"
                                   & (Integer'Image (number)));
               else
                   number := 0;
                   put_line (name & "'s number is"
                                   & (Integer'Image (number)));
               end if;
           end track;
       end loop;
   end Operator;

begin
    Operator.track("Johhny", number);
    Operator.track("James", number);
    Operator.track("Jimmy", number);
end phoneoperator;
