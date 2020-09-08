/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task2 is
	port( clk	: in  std_logic;
	      ER	: out std_logic
		);
end Task2;

architecture rtl of Task2 is
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
		ER <= '1' when "0001"| "0010" | "0110" | "0111" | "1000" | "1001",
		      '0' when others;
			  
	--psl default clock is rising_edge(clk);
	--psl P1 : assert never{ER[*4]};
	--psl P2 : assert always{not(ER[*4])};
	/*P1 = P2*/
end architecture rtl; 
