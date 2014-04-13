-- Barrier problem ada version
procedure BarrierProgram is 

-- monitor-like ada structure
-- protected module declaration
protected type Barrier is  
    entry Wait;
private
    Releasing: Boolean := False;
end Barrier;

-- protected module body
protected body Barrier is 
    entry Wait
        -- entry guard
        when Releasing or Wait'Count = 20 is
    begin 
        -- release everyone else
        Releasing := True;
        -- lock it again
        if Wait'Count = 0 then
            Releasing := False;
        end if;
    end Wait;
end Barrier;

begin
    null;
end BarrierProgram;
