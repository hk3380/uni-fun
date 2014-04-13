with Ada.integer_text_IO; use Ada.integer_text_IO;
with Ada.text_io;

procedure Bounded_Buffer is

    -- Buffer size
    SIZE : CONSTANT := 10;
    type bufferArray is array (1..SIZE) of Integer;

    protected Buffer is

        -- Entry for writers to put values inside the buffer
        entry Put (x: in integer);

        -- Entry for readers to take values outside the buffer
        entry Take (x: out  integer);

        private
            -- "Anonymous arrays not allowed as components"
            values:bufferArray;

            -- How much of the buffer is occupied
            occupied: integer := 0;

            -- Keep track what's the next element to look at
            toRead: integer := 1;
            toWrite: integer := 1;

    end Buffer;

    protected body Buffer is

        -- Guarded entry for writers to put new data
        entry Put(x: in integer) when occupied < SIZE is
        begin
            values(toWrite) := x;
            occupied := occupied + 1;

            if toWrite >= SIZE then
                -- Circular buffer
                toWrite := 1;
            else 
                toWrite := toWrite + 1;
            end if;
        end Put;

        -- Guarded entry for readers to take away data
        entry Take (x: out integer) when occupied /= 0 is
        begin
            x := values(toRead);
            occupied := occupied - 1;

            if toRead >= SIZE then
                -- Still circular buffer :^)
                toRead := 1;
            else
                toRead := toRead + 1;
            end if;
        end Take;
    end Buffer;

    -- Creating the consumers and the producers
    task type Producer;
    task type Consumer;

    task body Consumer is
        value: integer;
    begin
        for i in 1..10 loop
            Buffer.Take(value);
            put(value);
        end loop;
    end Consumer;

    task body Producer is
    begin
        -- Generating random numbers seems complicated
        for i in 1..10 loop
            Buffer.Put(i);
            put (i);
        end loop;
    end Producer;

    Consumers: array (1..10) of Consumer;
    Producers: array (1..20) of Producer;
begin
    null;
end Bounded_Buffer;
