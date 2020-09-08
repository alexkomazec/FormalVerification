/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;

entity task2 is
    port(
		/*Inputs*/
         a    	: in  std_logic;
         b    	: in  std_logic;
         c    	: in  std_logic;
         d    	: in  std_logic;
         e    	: in  std_logic;
         f    	: in  std_logic;
		 g    	: in  std_logic;
		 h    	: in  std_logic;

		/*Outputs*/
         o1    	: out std_logic;
         o2    	: out std_logic;
		 
		/*Clock and Reset*/
		 rst 	: in  std_logic;
         clk   	: in  std_logic;
         );
end task2;

architecture rtl of task2 is

	/*D2_4E	d0 signals*/
	signal	d2_4e_d0_d0		: 	std_logic;
	signal	d2_4e_d0_d1		: 	std_logic;
	signal	d2_4e_d0_d3		: 	std_logic;
	signal 	d2_4e_d0_d3		:	std_logic;
	signal	d2_4e_d0_a1a0 	:	std_logic_vector(3 downto 0);

	/*D2_4E	d1 signals*/
	signal 	d2_4e_d1_d0		: std_logic;
    signal	d2_4e_d1_d1		: std_logic;
	signal	d2_4e_d1_d2		: std_logic;
	signal	d2_4e_d1_d3		: std_logic;
	signal 	d2_4e_d1_a1a0	: std_logic_vector(1 downto 0);

	/*M16_1E signals*/
	signal m16_1e_sel		: std_logic_vector(3 downto 0);
	
	/*FDR signals*/
    signal o1_reg, o1_next 			: std_logic;
    signal o2_reg, o2_next 			: std_logic;

begin
    
	/*-----------------Bool's circuit-----------------------*/

	/*D2_4E	d0*/
	d2_4e_d0_a1a0 	<= f & e;
	d2_4e_d0_d0 	<= '1' when d2_4e_d0_a1a0 = "00" else '0';
	d2_4e_d0_d1 	<= '1' when d2_4e_d0_a1a0 = "01" else '0';
	d2_4e_d0_d3 	<= '1' when d2_4e_d0_a1a0 = "10" else '0';
	d2_4e_d0_d3 	<= '1' when d2_4e_d0_a1a0 = "11" else '0';

	/*D2_4E	d1*/
	d2_4e_d1_a1a0 	<= h & g;
	d2_4e_d1_d0 	<= '1' when d2_4e_d1_a1a0 = "00" else '0';
	d2_4e_d1_d1 	<= '1' when d2_4e_d1_a1a0 = "01" else '0';
	d2_4e_d1_d2 	<= '1' when d2_4e_d1_a1a0 = "10" else '0';
	d2_4e_d1_d3 	<= '1' when d2_4e_d1_a1a0 = "11" else '0';

	/*M16_1E*/
	m16_1e_sel <= d & c & b & a;
	with m16_1e_sel select
        o1_next <= d2_4e_d0_d0 when "0000",
				   d2_4e_d0_d1 when "0001",
				   d2_4e_d0_d3 when "0010",
				   d2_4e_d0_d3 when "0011",
				   d2_4e_d1_d0 when "0100",
				   d2_4e_d1_d1 when "0101",
				   d2_4e_d1_d2 when "0110",
				   d2_4e_d1_d3 when "0111",
				   '1'  when others;
	
	/*FDR*/
    FDR  : process(clk, rst)
    begin
        if (rst = '1') then
            o1_reg <= '0';
            o2_reg <= '0';
        elsif rising_edge(clk) then
            o1_reg <= o1_next;
            o2_reg <= o2_next;
        end if;
    end process FDR;

    o1 <= o1_reg;

	/*-----------------Bool's function-----------------------*/
    
	o2_next <= ((((not a) and (not b) and (not c) and (not e) and (not f)) or (a and (not b) and (not c) and e and (not f)) or ((not a) and b and (not c) and (not e) and f) or (a and b and (not c) and e and f) or ((not a) and (not b) and c and (not g) and (not h)) or (a and (not b) and c and g and (not h)) or ((not a) and b and c and (not g) and h) or (a and b and c and g and h)) and (not d)) or d;
	o2 <= o2_reg;

	-- psl default clock is rising_edge(clk);
    -- psl P1 : assert always (o1 = o2);
end architecture rtl;
