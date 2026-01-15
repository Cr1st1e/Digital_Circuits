------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits Winter Term 2025
--			Exercise 3
--
-- @name:   seven_segment.vhd
-- @author: 
-- @description: control unit for the seven segment display of the 
--               basys 3 board
--				 DESIGN FILE
--
-- (c) 2025 HAW Hamburg
--
------------------------------------------------------------------

---------------------------------------------
-- libraries
library ieee;
use ieee.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;

---------------------------------------------
-- entity
entity seven_segment is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           
           LEDs : out STD_LOGIC_VECTOR(7 downto 0);
           DIGIT_select : out STD_LOGIC_VECTOR(3 downto 0);
           SW : in STD_LOGIC_VECTOR(7 downto 0)
           
           );
end seven_segment;


---------------------------------------------
-- architecture
architecture rtl of seven_segment is


---------------------------------------------
-- signal declaration

-- TODO: Preparation: Update the bit patterns of the constants for the 7-segment LEDs
constant ZERO : std_logic_vector(7 downto 0)  := "11000000";
constant ONE : std_logic_vector(7 downto 0)   := "11111001";
constant TWO : std_logic_vector(7 downto 0)   := "10100100";
constant THREE : std_logic_vector(7 downto 0) := "10110000";
constant FOUR : std_logic_vector(7 downto 0)  := "10011001";
constant FIVE : std_logic_vector(7 downto 0)  := "10010010";
constant SIX : std_logic_vector(7 downto 0)   := "10000010";
constant SEVEN : std_logic_vector(7 downto 0) := "11111000";
constant EIGHT : std_logic_vector(7 downto 0) := "10000000";
constant NINE : std_logic_vector(7 downto 0)  := "10010000";

signal current_state,next_state : std_logic_vector(1 downto 0);

signal current_cnt,next_cnt :unsigned(27 downto 0); 

signal disp_sel : std_logic_vector(2 downto 0); 
begin

---------------------------------
-- sequential process
sync : process(clk,rst)
begin

--top 2 bit
--disp_sel <= std_logic_vector(current_cnt(27 downto 25));  

-- TODO
if rst ='1' then
    current_cnt<= (others =>'0');
    current_state<="00";
 elsif rising_edge(clk) then -- resister the switch input first
    current_cnt<=next_cnt;
    current_state<=next_state;
end if;
end process;

---------------------------------
-- combinatorial process delta
delta : process(current_cnt,SW)
begin

-- TODO
    next_state <= SW(1 downto 0);
    next_cnt <= current_cnt+1;

end process;


---------------------------------
-- combinatorial process lambda
lambda : process(current_cnt,current_state)

begin
-- TODO
    case current_state is
        when "00" =>
            DIGIT_select<="1110";
        when "01" =>
            DIGIT_select<="1101";
        when "10" =>
            DIGIT_select<="1011";
        when "11" =>
            DIGIT_select<="0111"; 
    end case; 
    case current_cnt(27 downto 25) is
        when "000" =>
            LEDs<=ZERO;
        when "001" =>
            LEDs<=ONE;
        when "010" =>
            LEDs<=TWO;
        when "011" =>
            LEDs<=THREE;
        when "100" =>
            LEDs<=FOUR;
        when "101" =>
            LEDs<=FIVE;
        when "110" =>
            LEDs<=SIX;
        when "111" =>
            LEDs<=SEVEN; 
     end case;
end process;
end rtl;
