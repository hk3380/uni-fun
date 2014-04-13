with Ada.integer_text_IO; use Ada.integer_text_IO;
with Ada.text_io;

procedure consumersProducers is
    --  how many consumers needed for a release
    numConsumers : CONSTANT := 5;
    -- this probably sholdn't be a global but hey
    ready: boolean := false;

    protected barrier is
        -- Gets the written value
        entry read (thevalue: out integer);
        -- Writes the value
        procedure write (thevalue: in integer);

    private value: integer;
            permission: boolean := false;
    end barrier;

    protected body barrier is
        -- Read when you received permission from writer
        entry read (thevalue: out integer)
            when permission is
        begin
                -- Use new value
                thevalue := value;

                -- After everyone gets the value, the barrier is down again
                if read'count = 0 then
                    permission := false;
                end if;
        end read;

        procedure write (thevalue: in integer) is
        begin
            value := thevalue;
            if ready then
                -- Give readers permission to read the new value
                permission := true;
                -- Take a break
                ready := false;
            end if;
        end write;
    end barrier;

    -- Consumer task to read the value from the barrier
    task type consumer;

    task body consumer is
        value: integer;

    begin
        -- This basically simulates consumers
        for i in 1..numConsumers loop
            barrier.read(value);
            put(value);
        end loop;

    end consumer;

    -- Producer task to write the value to the barrier
    task producer;

    task body producer is
    begin
        -- Give consumers enough time to queue up
        -- Foolproof formula gotten from my arse
        delay numConsumers * 0.202821;

        -- Allow the producer to write as everyone is ready
        ready := true;
        barrier.write(10);

    end producer;

    consumers : array  (1..numConsumers) of consumer;

begin
    null;
end consumersProducers;
