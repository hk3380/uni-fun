with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

-- Encapsulated shared variable with task entries
-- Selective wait
procedure encapsulatedvariable is
    task type Encapsulated_Variable is
        -- Store a new value
        entry Store (value: in integer);
        -- Get the value
        entry Fetch (value: out integer);
    end Encapsulated_Variable;

    task body Encapsulated_Variable is 
        data: integer;
    begin
        -- Store an initial value;
        accept Store (value: in integer) do
            data := value;
        end Store;
        put (data);

        -- Continue accepting commands of update and fetch
        loop
            select
                accept Store (value: in integer) do
                    data := value;
                end Store;
            or
                accept Fetch (value: out integer) do
                    value := data;
                end Fetch;
            end select;
        end loop;

    end Encapsulated_Variable;

    -- For testing purposes
    a: Encapsulated_Variable;
    x: integer;

begin
    a.Store(5);
    a.Fetch(x);

    put(0);
    put (x);
end;


