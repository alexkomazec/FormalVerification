library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity prop01 is
    port(
        clk  : in  std_logic;
        RDY  : out std_logic;
        ENDD : out std_logic;
        STOP : out std_logic;
        ER   : out std_logic
        );
end prop01;
architecture rtl of prop01 is
    signal cnt : unsigned(3 downto 0) := X"0";
begin
    -- psl default clock is rising_edge(clk);
    -- psl P1 : assert eventually! (RDY);
    -- psl P2 : assert always (RDY -> eventually! (not RDY));
    -- psl P3b : assert always {RDY; not RDY} |-> {prev(ENDD or STOP or ER)};
    process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + X"1";
        end if;
    end process;
    with cnt select
        RDY <= '1' when X"1"|X"2"|X"3",
        	   '0' when others;
    ENDD <= '0';
    with cnt select
        STOP <= '1' when X"3",
        		'0' when others;
    ER <= '0';
end rtl;
