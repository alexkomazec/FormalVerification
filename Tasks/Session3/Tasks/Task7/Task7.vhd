/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task7 is
	port(	clk 		 : in std_logic;
			ENDD		 : out std_logic;
			START   	 : out std_logic;
			STATUS_VALID : out std_logic;
			INSTARTSV	 : out std_logic
	);
end Task7;

architecture rtl of Task7 is
	signal cnt : unsigned(3 downto 0) := "0000";
begin

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	/*ENDD signal*/
	with cnt select
		ENDD <= '1' when "0011",
				'0' when others;
	
	/*START signal*/
	with cnt select
		START <= '1' when "0101",
			 	 '0' when others;
	
	/*STATUS_VALID signal*/	
	with cnt select
		STATUS_VALID <= '1' when "1010",
			  			'0' when others;
						
	/*INSTARTSV signal*/					
	with cnt select
		INSTARTSV <= '1' when "0011" | "0100" | "0101" | "0110" | "0111",
			  	     '0' when others;

	--psl default clock is rising_edge(clk);
	--psl P1part1 : assert always(ENDD -> (not(START) and not(STATUS_VALID)));
	--psl P1part2 : assert never(ENDD and (STATUS_VALID or START));
	
end architecture rtl;
