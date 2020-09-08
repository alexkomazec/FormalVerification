/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task3 is
	port( clk	: in  std_logic;
	      ER	: out std_logic;
	      RDY	: out std_logic
		);
end Task3;

architecture rtl of Task3 is
	signal cnt: unsigned(3 downto 0) := "0000";
begin
	
	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	/*ER signal*/
	with cnt select
		ER <= '1' when "0001"| "0101" | "0110" | "1001",
		      '0' when others;
	
	/*RDY signal*/
	with cnt select
		RDY <= '1' when "0001"| "0010" | "0110" | "1001",
		       '0' when others;
			   
	--psl default clock is rising_edge(clk);
	--psl P1 : assert always((ER and RDY) -> next((not ER) or (not RDY)) or ((not ER) and (not RDY)));
	
end architecture rtl; 
