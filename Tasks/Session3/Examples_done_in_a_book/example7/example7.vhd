library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity prop01 is
    port(
        clk          : in  std_logic;
        ER           : out std_logic;
        INSTARTSV    : out std_logic;
        START        : out std_logic;
        STATUS_VALID : out std_logic
        );
end prop01;
architecture rtl of prop01 is
    signal cnt : unsigned(3 downto 0) := X"0";
begin
    -- psl default clock is rising_edge(clk);
    -- psl P1a : assert always (ER -> INSTARTSV);
    -- psl P1b : assert always (not INSTARTSV -> not ER);
    cnt_signal : process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + X"1";
        end if;
    end process cnt_signal;
    with cnt select
        ER <= '1' when X"7",
        	  '0' when others;
    with cnt select
        INSTARTSV <= '1' when X"2"|X"3"|X"4"|X"5"|X"6"|X"7"|X"8",
        			 '0' when others;
    with cnt select
        START <= '1' when X"1",
        		 '0' when others;
    with cnt select
        STATUS_VALID <= '1' when X"8",
        				'0' when others;
end rtl; 
