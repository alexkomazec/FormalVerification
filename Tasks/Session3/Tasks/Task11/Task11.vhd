/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Task11 is
	port(	clk	: in std_logic;
			rst : in std_logic
	);
end entity;
architecture beh of Task11 is
	constant W : natural := 4;
	signal buf_temp1 : std_logic_vector(W-1 downto 0) := x"0";
	signal buf_temp2 : std_logic_vector(W-1 downto 0) := x"0";
 	signal p11, p12 : std_logic;
 	signal p21, p22 : std_logic;
 	signal p31 : std_logic;
 	signal p41 : std_logic;
 	signal p51, p52 : std_logic;
 	signal cnt : unsigned(W-1 downto 0) := x"0";
	
begin

	process (clk,rst)
 	begin
		if (rst = '1')then
			cnt <= x"0";
 		elsif rising_edge(clk) then
 			cnt <= cnt + to_unsigned(1,W);
 		end if;
	end process;

	process (clk,cnt,rst)
    begin
		if (rst = '1')then
			p11 <= '0';
 		elsif rising_edge(clk) then
			case cnt is
				when x"6" => p11 <= '1';
				when others => p11 <= '0';
			end case;
        end if;
    end process;

	process (clk,cnt,rst)
    begin
		if (rst = '1')then
			p12 <= '0';
 		elsif rising_edge(clk) then
			case cnt is
				when x"A" => p12 <= '1';
				when others => p12 <= '0';
			end case;
        end if;
    end process;

	process (clk,cnt,rst)
    begin
		if (rst = '1')then
			p21 <= '0';
			buf_temp1 <= X"0";
			buf_temp2 <= X"0";
 		elsif rising_edge(clk) then
			case cnt is
				when x"0" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"1" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"2" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"3" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"4" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"5" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"6" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when x"7" => p21 <= '0';buf_temp1 <= std_logic_vector(unsigned(buf_temp1) + 1);
				when others => p21 <= '1';buf_temp2 <= std_logic_vector(unsigned(buf_temp2) + 1);
			end case;
        end if;
    end process;

	process(clk,cnt,rst)begin
		if (rst = '1')then
			p22 <= '1';
 		elsif rising_edge(clk)	then
			case cnt is
				when x"0" => p22 <= '1';
				when x"1" => p22 <= '1';
				when x"2" => p22 <= '1';
				when x"3" => p22 <= '1';
				when x"4" => p22 <= '1';
				when x"5" => p22 <= '1';
				when x"6" => p22 <= '1';
				when x"7" => p22 <= '1';
				when others => p22 <= '0';
			end case;
		end if;
	end process;

	process (clk,cnt,rst)
    begin
		if (rst = '1')then
			p41 <= '0';
 		elsif rising_edge(clk) then
			case cnt is
				when x"E" => p41 <= '0';
				when x"F" => p41 <= '0';
				when others => p41 <= '1';
			end case;
        end if;
    end process;
	
	process(clk,cnt)
	begin
		if(rising_edge(clk)) then
			p51 <= cnt(1);
    		p52 <= cnt(2);
			p31 <= cnt(1) xor cnt(0); 
			
		end if; 
	end process;

	--psl default clock is rising_edge(clk);
	--psl P1part1: assert always(p11 -> next not(p11));
	--psl P1part2: assert always(p12 -> next not(p12));
	--psl P1part3: assert always(p11 -> eventually! p12);
	--psl P2part1: assert never(p21 and p22);
	--psl P2part2: assert never(not(p22) and not(p21));
	--psl P3 : assert always (cnt = x"0") -> (temp1 = temp2);
	--psl P5 : assert eventually! not(p41);
	--psl P6 : assert always eventually! not(p41);
	--psl P7part1: assert never{p51 and p52; not (p51) and p52};
	--psl P7part2: assert never{p51 and not(p52); not (p51) and not(p52)};
	--psl P8part1: assert never{p52 and p51; p52 and p51};
	--psl P8part2: assert never{p52 and not(p51); p52 and not(p51)};
	--psl P8part3: assert never{not (p52) and p51; not(p52) and p51};
	--psl P8part4: assert never{not (p52) and not(p51); not(p52) and not(p51)};
	
end architecture Task11;
