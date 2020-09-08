library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity prop01 is
   port(
      clk : in std_logic;
      REQ : out std_logic;
      ACK : out std_logic
   );
end prop01;
architecture rtl of prop01 is
   signal cnt : unsigned(3 downto 0) := X"0";
begin
   -- psl default clock is rising_edge(clk);
   -- psl P1 : assert always (ACK -> prev(REQ, 3));
   process(clk)
   begin
      if rising_edge(clk) then
         cnt <= cnt + X"1";
      end if;
   end process;
   process(cnt)
   begin
      case cnt is
         when X"5" => REQ <= '1';
         when others => REQ <= '0';
      end case;
   end process;
   process(cnt)
   begin
      case cnt is
         when X"8" => ACK <= '1';
         when others => ACK <= '0';
      end case;
   end process;
end rtl; 
