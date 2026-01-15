library IEEE;
use IEEE.std_logic_1164.all;

entity addsub_tb is
end entity;

architecture behavioral of addsub_tb is
    signal cycle        : std_logic := '0';
    signal A_s, B_s     : std_logic_vector(7 downto 0);
    signal S_s          : std_logic_vector(7 downto 0);
    signal sel_s        : std_logic;
    signal C_s, V_s     : std_logic;
    signal N_s, Z_s     : std_logic;

    constant PERIOD     : time := 100 ns;
    constant OFFSET     : time := 20 ns;

    -- record type
    type stimulus_response_type is record
        operand_A : std_logic_vector(7 downto 0);
        operand_B : std_logic_vector(7 downto 0);
        sel       : std_logic;
        result_S  : std_logic_vector(7 downto 0);
        C_exp     : std_logic;
        V_exp     : std_logic;
        N_exp     : std_logic;
        Z_exp     : std_logic;
    end record;

    type stimulus_response_array_type is
        array (natural range <>) of stimulus_response_type;

    constant TEST_DATA : stimulus_response_array_type := (
        --   A          B         sel   S (exp)    C  V  N  Z
        ("00000001", "00000001", '0', "00000010", '0', '0', '0', '0'),
        ("00001111", "00000001", '0', "00010000", '0', '0', '0', '0'),
        ("11111111", "00000001", '0', "00000000", '1', '0', '0', '1'),
        ("00000101", "00000001", '1', "00000100", '1', '0', '0', '0'),
        ("00000001", "00000001", '1', "00000000", '1', '0', '0', '1'),
        ("00000000", "00000001", '1', "11111111", '0', '0', '1', '0'),
        ("01111111", "00000001", '0', "10000000", '0', '1', '1', '0'),
        ("10000000", "11111111", '0', "01111111", '1', '1', '0', '0')
    );

begin
    -- pseudo-clock
    cycle <= not cycle after PERIOD/2;

    -- DUT: direct entity instantiation (no component)
    dut: entity work.addsub
        port map(
            A   => A_s,
            B   => B_s,
            sel => sel_s,
            S   => S_s,
            C   => C_s,
            V   => V_s,
            N   => N_s,
            Z   => Z_s
        );

    -- stimuli
    stimuli : process
    begin
        wait for PERIOD;
        wait for OFFSET;

        for I in TEST_DATA'range loop
            wait until rising_edge(cycle);

            A_s   <= TEST_DATA(I).operand_A;
            B_s   <= TEST_DATA(I).operand_B;
            sel_s <= TEST_DATA(I).sel;

            wait for OFFSET;

            assert S_s = TEST_DATA(I).result_S
                report "error in S at vector " & integer'image(I)
                severity warning;

            assert C_s = TEST_DATA(I).C_exp
                report "error in C at vector " & integer'image(I)
                severity warning;

            assert V_s = TEST_DATA(I).V_exp
                report "error in V at vector " & integer'image(I)
                severity warning;

            assert N_s = TEST_DATA(I).N_exp
                report "error in N at vector " & integer'image(I)
                severity warning;

            assert Z_s = TEST_DATA(I).Z_exp
                report "error in Z at vector " & integer'image(I)
                severity warning;
        end loop;

        wait until rising_edge(cycle);
        wait for 3*PERIOD;
        assert false report "planned end of simulation" severity failure;
        wait;
    end process;
end architecture behavioral;