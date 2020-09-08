/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task4 is
	port( clk	: in  std_logic;
		  RDY	: out std_logic;
	      START	: out std_logic
		);
end Task4;

architecture rtl of Task4 is
	signal cnt: unsigned(3 downto 0) := "0000";
begin

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;
	
	/*RDY signal*/
	with cnt select
		RDY <= '1' when "0110",
		       '0' when others;
	
	/*START signal*/
	with cnt select
		START <= '1' when "0010",
		         '0' when others;
	   
	--psl default clock is rising_edge(clk);
	--psl P1 : assert ((not RDY) until START);
	
end architecture rtl; 
