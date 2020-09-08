/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task8 is
	port(	clk 		 : in  std_logic;
			RT			 : out std_logic;
			ENABLE   	 : out std_logic
	);
end Task8;

architecture rtl of Task8 is
	signal cnt : unsigned(3 downto 0) := "0000";
begin

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	/*RT signal*/
	with cnt select
		RT <= '1' when "0000" | "0001" | "0010",
			  '0' when others;

	/*ENABLE signal*/
	with cnt select
		ENABLE <= '1' when X"0111",
			  	  '0' when others;

	--psl default clock is rising_edge(clk);
	--psl P1part1 : assert always(ENABLE -> prev(not(RT), 2));
	--psl P1part1 : assert always(RT -> not(ENABLE));
	
end architecture Task8;
