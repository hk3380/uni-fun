with Ada.integer_text_IO; use Ada.integer_text_IO;
with Ada.text_io;

procedure readerswriters is
    -- protected object because that's what SO told me
    protected Homework is
        -- Entries for writing and reading
        entry Write;
        entry Read;

        -- Party stoppers
        procedure StopWriting;
        procedure StopReading;

        private
            -- Whether anyone's writing atm 
            writing: boolean := false;

            -- Readers counter
            readers: integer := 0; 

            -- Queue
            activeReaders: integer := 0;
            waitingWriters: integer := 0;
    end Homework;

    protected body Homework is

        -- Write when no one else is reading and no readers are active
        entry Write
         when (not writing and activeReaders = 0) is
        begin
            writing := true;
            Ada.Text_IO.Put_Line ( "Writing DND ");
        end Write;

        -- Read when the cool kids aren't watching
        entry Read 
         when (not writing and Write'Count = 0) is
         begin
            readers:= readers + 1;
            Ada.Text_IO.Put_Line ( "Reading here ");
        end Read;

        -- Stop writing whenever
        procedure StopWriting is
        begin
            writing := false;
            Ada.Text_IO.Put_Line ( "Done my homework mom ");
        end StopWriting;

        -- Let the others now that you took a brea
        procedure StopReading is
        begin
            readers := readers - 1;
            Ada.Text_IO.Put_Line( "Read my SICP today ");
        end StopReading;
    end Homework;

    -- Spawn some nerds
    task type Writer;
    task type Reader;

    -- Behaved writers
    task body Writer is
    begin
        -- Allow a few readers to squeeze in
        delay 0.001;
        Homework.Write;
        delay 1.0;
        Homework.StopWriting;
    end Writer;

    -- Unsatiable readers
    task body Reader is
    begin
        Homework.Read;
        Homework.StopReading;
    end Reader;

    Readers: array (1..10) of Reader;
    Writers: array (1..5) of Writer;
begin
    null;
end readerswriters;
