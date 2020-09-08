/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task6 is
	port(	clk 	: in std_logic;
			ENDD	: out std_logic;
			STOP    : out std_logic;
			ER		: out std_logic;
			RDY		: out std_logic
	);
end Task6;

architecture rtl of Task6 is
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
		ENDD <= '1' when "0010",
				 '0' when others;
	
	/*STOP signal*/
	with cnt select
		STOP <= '1' when "0101",
				'0' when others;
	
	/*ER signal*/
	with cnt select
		ER <= '1' when "1010",
			  '0' when others;

	/*RDY signal*/
	with cnt select
		RDY <= '1' when "0001"| "0010"| "0100" | "01001"| "0110" | "1001" | "1010",
			   '0' when others;
	
	--psl default clock is rising_edge(clk);
	--psl P1part1 : assert always((ENDD or STOP or ER) -> RDY);
	--psl P1part2 : assert never((not RDY) and (ENDD or STOP or ER));
	
end architecture rtl;
