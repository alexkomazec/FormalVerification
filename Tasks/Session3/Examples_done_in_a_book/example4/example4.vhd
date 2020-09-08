library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prop01 is
	port( clk	: in std_logic;
		  START : out std_logic;
		  ENDD  : out std_logic 
		);
end prop01;

architecture rtl of prop01 is
	signal cnt : unsigned(4 downto 0) := "00000";
begin
	--psl default clock is rising_edge(clk);
	--psl P1: assert ((not ENDD) until START);
	--psl P2: assert always (START -> next (ENDD before START));

	cnt_signal : process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + 1;
		end if;
	end process cnt_signal;

	with cnt select
		START <= '1' when "00010",
				 '0' when others;

	with cnt select
		ENDD <= '1' when "01000",
				'0' when others;
end rtl;
