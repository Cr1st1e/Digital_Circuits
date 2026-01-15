------------------------------------------------------------------
--
-- [IE3-DI] Digital Circuits Winter Term 2025
--			Exercise 2
--
-- @name:   adder.vhd
-- @author: 
-- @description: Ripple-Carry-Adder Unit
--				 DESIGN FILE
--
-- (c) 2025 HAW Hamburg
--
------------------------------------------------------------------

---------------------------------
-- libraries / packages 
library IEEE;
use IEEE.std_logic_1164.all;

---------------------------------
-- entity
entity adder is
	port( 	
		A  	 : IN  std_logic_vector(7 downto 0);	-- Operand A (bitwidth 8)
     	B  	 : IN  std_logic_vector(7 downto 0);    -- Operand B (bitwidth 8)
        ci	 : IN  std_logic;						-- Carry In (bitwidth 1)

		S 	 : OUT std_logic_vector(7 downto 0);	-- Sum (bitwidth 8)
        co	 : OUT std_logic						-- Carry Out (bitwidth 1)
		);
end entity;

---------------------------------
-- architecture
architecture rtl of adder is
begin

---------------------------------
-- combinatorial process
adding: process(A, B, ci)

-- variable declarations
variable c_v : std_logic;
variable S_v : std_logic_vector(7 downto 0);
variable A_v, B_v : std_logic_vector(7 downto 0);
begin
	-- 1. signal to variable assignment
	-- TODO
	A_v := A;
	B_v := B;
	c_v := ci;
	
	-- 2. data processing: ripple-carry adder
	-- TODO
    -- This loop iterates 8 times, building one Full Adder each time.
    -- The 'c_v' variable ripples the carry from one stage to the next.
	FOR i IN 0 TO 7 LOOP
		S_v(i) := A_v(i) XOR B_v(i) XOR c_v;
		c_v := (A_v(i) AND B_v(i)) OR (A_v(i) AND c_v) OR (B_v(i) AND c_v);
	END LOOP;
	
	-- 3. variable to signal re-assignment
	-- TODO
	S <= S_v;
	co <= c_v;
	
end process;
end architecture rtl;