library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prop01 is
	port( clk			: in  std_logic;
		  ENDD			: out std_logic;
		  STATUS_VALID	: out std_logic; 
		  READY			 : out std_logic
		);
end prop01;

architecture rtl of prop01 is
	signal cnt: unsigned(3 downto 0) := "0000";
begin

	--psl default clock is rising_edge(clk);
	--psl P1 : assert always (ENDD -> next ((not ENDD) or (ENDD and READY and STATUS_VALID)));

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + "0001";
		end if;
	end process;

	with cnt select
		ENDD <= '1' when "0010"| "0111" | "1000",
			    '0' when others;
	
	with cnt select
		STATUS_VALID <= '1' when "0011" | "1000",
			   			'0' when others;
	
	with cnt select
		READY <= '1' when "1000",
				 '0' when others;

end rtl; 
