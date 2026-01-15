library IEEE;
use IEEE.std_logic_1164.all;

entity addsub is
    port(
        A    : in  std_logic_vector(7 downto 0);
        B    : in  std_logic_vector(7 downto 0);
        sel  : in  std_logic;                     -- 0=add, 1=sub
        S    : out std_logic_vector(7 downto 0);
        C    : out std_logic;
        V    : out std_logic;
        N    : out std_logic;
        Z    : out std_logic
    );
end entity addsub;

architecture rtl of addsub is
begin
    adding : process(A, B, sel)
        variable c_v  : std_logic;
        variable c7_v : std_logic;
        variable S_v  : std_logic_vector(7 downto 0);
        variable A_v  : std_logic_vector(7 downto 0);
        variable B_v  : std_logic_vector(7 downto 0);
    begin
        -- 1. input to variables
        A_v := A;
        B_v := B;

        -- cin: 0 for add, 1 for sub
        c_v := sel;

        -- for subtraction: use NOT B (two's complement: NOT B + 1)
        if sel = '1' then
            B_v := not B_v;
        end if;

        -- 2. ripple-carry add
        for i in 0 to 7 loop
            if i = 7 then
                c7_v := c_v;        -- carry into MSB
            end if;

            S_v(i) := A_v(i) xor B_v(i) xor c_v;

            c_v := (A_v(i) and B_v(i)) or
                   (A_v(i) and c_v)    or
                   (B_v(i) and c_v);
        end loop;

        -- 3. outputs + flags
        S <= S_v;
        C <= c_v;                   -- carry out
        V <= c_v xor c7_v;          -- overflow = co XOR c7
        N <= S_v(7);                -- negative flag

        if S_v = "00000000" then    -- zero flag
            Z <= '1';
        else
            Z <= '0';
        end if;
    end process adding;

end architecture rtl;
