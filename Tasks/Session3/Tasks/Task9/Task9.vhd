/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task9 is
	port(	clk 		 : in std_logic;
			RDY			 : out std_logic;
			START   	 : out std_logic;
			INTERRUPT	 : out std_logic
	);
end Task9;

architecture rtl of Task9 is
	signal cnt : unsigned(3 downto 0) := "0";
begin

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	/*RDY signal*/
	with cnt select
		RDY <= '1' when "0010"|"0011"|"0100"|"0101"|"0110"|"0111",
			   '0' when others;

	/*START signal*/
	with cnt select
		START <= '1' when "0101" | "0110" | "0111",
			  	 '0' when others;

	/*INTERRUPT signal*/
	with cnt select
		INTERRUPT <= '1' when "0111",
			  	     '0' when others;
	
	--psl default clock is rising_edge(clk);
	--psl P1: assert never {START and not(INTERRUPT); not (START)};
	--psl P2: assert never {RDY and not(INTERRUPT); not (RDY)};
	--psl P3: assert always {(INTERRUPT) -> (not(RDY) and not(START))};
	
end architecture rtl;
