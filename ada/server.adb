with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Strings.Unbounded.Text_IO; use Ada.Strings.Unbounded.Text_IO;
with Ada.Text_IO; use Ada.Text_Io;

-- Ada web server
procedure server is

    -- Custom type for Ips
    type Octet is range 0..255;
    type IP_Address is array(1..4) of Octet;
    type IP_Addresses is array (Integer range <>) of IP_Address;
    IP: IP_Addresses (1..3);

    -- Server supports HTTP and FTP connections
    task Server is
        entry HTTP (ClientIP: in IP_Address; response: out Unbounded_String);
        entry FTP (ClientIP: in IP_Address; response: out Unbounded_String);
    end Server;

    task body Server is
    begin
        loop
            select
                accept HTTP (ClientIP: in IP_Address; response: out Unbounded_String) do
                    -- This won't actully guard shit if 127 isn't the first ip accepted
                    if (Octet'Image(ClientIP(1))) /= (Integer'Image(127)) then
                        -- I'm a hacker
                        response := To_Unbounded_String("<script>alert('XSS injected nerd')</script>");
                    else put("Nice try me");
                    end if;
                end HTTP;
            or
                -- Get v&
                accept FTP (ClientIP: in IP_Address; response: out Unbounded_String) do
                    response := To_Unbounded_String("Downloading illegalporn.jpeg...");
                    response := response & To_Unbounded_String("100%");
                end FTP;
            or 
                -- This also occurs when there are no requests but eh
                delay 10.0;
                put_line("Server not responding");
            end select;
        end loop;
    end Server;

    response: Unbounded_String;

begin
    -- Test a bunch of IPs
    IP(1) := (127,0,0,1);
    IP(2) := (192,168,0,7);
    IP(3) := (82,12,153,13);

    -- Connect to the server
    Server.HTTP(IP(1), response);
    put_line (response);
    Server.HTTP(IP(2), response);
    put_line (response);
    Server.FTP(IP(3), response);
    put_line (response);
end server;
