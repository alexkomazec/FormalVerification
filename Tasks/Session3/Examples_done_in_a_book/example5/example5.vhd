library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity prop01 is
	port(	clk 	: in std_logic;
			START	: out std_logic;
			RDY     : out std_logic;
			ENDD	: out std_logic;
			STOP	: out std_logic;
			ER		: out std_logic
	);
end prop01;

architecture beh of prop01 is
	signal cnt : unsigned(3 downto 0) := X"0";
begin
	--psl default clock is rising_edge(clk);
	--psl P1a : assert always ({not START; START} |-> {RDY});
	--psl P2a : assert always ({RDY and (ENDD or STOP or ER)} |=> {not RDY});
	--psl P2b : assert always ({RDY; not RDY} |-> {prev(ENDD or STOP or ER)});

	process(clk)
	begin
		if rising_edge(clk) then
			cnt <= cnt + X"1";
		end if;
	end process;

	with cnt select
		START <= '1' when X"1"|X"8",
				 '0' when others;

	with cnt select
		RDY <= '1' when X"0"|X"1"|X"2"|X"3"|X"7"|X"8"|X"9",
			   '0' when others;

	with cnt select
		ENDD <= '1' when X"3",
				'0' when others;

	with cnt select
		STOP <= '1' when X"9",
				'0' when others;

	ER <='0';

end beh;
