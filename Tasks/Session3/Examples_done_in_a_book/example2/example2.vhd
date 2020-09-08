library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prop01 is
	port( clk			: in  std_logic; 
		  START 		: out std_logic;
		  STATUS_VALID 	: out std_logic;
		  ER	  		: out std_logic
		);
end prop01;

architecture rtl of prop01 is
	signal cnt: unsigned(3 downto 0) := "0000";
begin

	--psl default clock is rising_edge(clk);
	--psl P1 : assert always (START -> next (not START));
	--psl P2 : assert always (STATUS_VALID -> next (not STATUS_VALID));
	--psl P3 : assert always (ER -> next (not ER));

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	with cnt select
		START <= '1' when "0000"| "0010",
			  	 '0' when others;
	
	with cnt select
		STATUS_VALID <= '1' when "0011" | "1001",
			   			'0' when others;
	
	with cnt select
		ER <= '1' when "0100" | "0101",
			  '0' when others;

end rtl; 
