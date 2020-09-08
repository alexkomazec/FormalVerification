library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity prop01 is
   port(
      clk : in std_logic;
      RD  : out std_logic;
      WR  : out std_logic
   );
end prop01;
architecture rtl of prop01 is
   signal cnt : unsigned(3 downto 0) := X"0";
begin
   -- psl default clock is rising_edge(clk);
   -- psl P1a : assert always (not (RD and WR));
   -- psl P1b : assert never (RD and WR);
   cnt_signal : process(clk)
   begin
      if rising_edge(clk) then
         cnt <= cnt + X"1";
      end if;
   end process cnt_signal;
   with cnt select
      RD <= '1' when X"1"|X"5"|X"A",
            '0' when others;
   with cnt select
      WR <= '1' when X"2"|X"5"|X"8",
            '0' when others;
end rtl; 
