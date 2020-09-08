library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity prop01 is
    port(
        clk : in  std_logic;
        REQ : out std_logic;
        ACK : out std_logic
        );
end prop01;
architecture rtl of prop01 is
    signal cnt : unsigned(3 downto 0) := X"0";
begin
    -- psl default clock is rising_edge(clk);
    -- psl P1a : assert always (REQ -> next (ACK before! REQ));
    -- psl P1b : assert always (REQ -> next ((not REQ) until ACK));
    -- psl P2 : assert always (REQ -> next (not REQ));
    -- psl P3 : assert always (ACK -> next (not ACK));
    cnt_p : process(clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + X"1";
        end if;
    end process cnt_p;
    process(cnt)
    begin
        case cnt is
            when X"1" => REQ <= '1';
                         ACK <= '0';
            when X"3" => REQ <= '0';
                         ACK <= '1';
            when X"5" => REQ <= '1';
                         ACK <= '0';
            when X"9" => REQ <= '0';
                         ACK <= '1';
            when X"A" => REQ <= '1';
                         ACK <= '0';
            when X"B" => REQ <= '0';
                         ACK <= '1';
            when others => REQ <= '0';
                           ACK <= '0';
        end case;
    end process;
end rtl; 
