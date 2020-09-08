/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task1 is
	port( clk	: in  std_logic;
		  RT	: out std_logic;
		  RDY	: out std_logic; 
		  START : out std_logic;
		  ENDD  : out std_logic
		);
end Task1;

architecture rtl of Task1 is
	signal cnt: unsigned(3 downto 0) := "0000";
begin

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	/*RT signal*/
	with cnt select
		RT <= '1' when "0000"| "0001" | "0010" | "0011" | "1000",
			  '0' when others;
	
	/*RDY signal*/
	with cnt select	
		RDY <= '1' when "0101",
		   	   '0' when others;
	
	/*START signal*/
	with cnt select
		START <= '1' when "0100",
				 '0' when others;
	
	/*ENDD signal*/
	with cnt select
		ENDD <= '1' when "0110",
				'0' when others;

	--psl default clock is rising_edge(clk);
	--psl P1 : assert (RT -> not (RDY or START or ENDD) until fell(RT));
	
end architecture rtl; 
