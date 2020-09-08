/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Task10 is
	port(	clk 		 : in  std_logic;
			REQ			 : out std_logic;
			ACK		   	 : out std_logic
	);
end Task10;

architecture rtl of Task10 is
	signal cnt : unsigned(3 downto 0) := "0";
begin

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	/*REQ signal*/
	with cnt select
		REQ <= '1' when "0001",
			   '0' when others;
	
	/*ACK signal*/
	with cnt select
		ACK <= '1' when "0110",
			   '0' when others;
	
	--psl default clock is rising_edge(clk);
	--psl P1 : assert always(REQ -> next[5](ACK));
	--psl P2 : assert always(REQ |-> next[4](ACK));
	/*P1 = P2*/
	
end architecture rtl;
