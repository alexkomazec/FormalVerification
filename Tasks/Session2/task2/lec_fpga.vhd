/**
* @author Aleksandar Komazec
*
* @date - 9/8/2020
*/

library ieee;
use ieee.std_logic_1164.all;

entity lec_fpga is
	port(	
			/*Inputs*/
			a		: in	std_logic;
			b		: in	std_logic;
			c		: in	std_logic;
			d		: in	std_logic;
			e		: in	std_logic;
			f		: in	std_logic;

			/*Outputs*/
			o1	: out	std_logic;
			o2	: out	std_logic;

			/*Clock and Reset*/
			rst		: in	std_logic;
			clk		: in	std_logic;
	);
end entity lec_fpga;

architecture rtl of lec_fpga is

	/*M8_1E select signal*/
	signal m8_1e_sel	:	std_logic_vector(2 downto 0);

	/*LUT4 signals*/
	signal	lut4_1  	:	std_logic;
	signal	lut4_2  	:	std_logic;
	signal	lut4_3  	:	std_logic;

	/*FDR common signals*/
	signal 	o1_reg		:	std_logic;
	signal	o1_next		:	std_logic;
	signal	o2_reg		:	std_logic;
	signal 	o2_next		:	std_logic;
begin

	--ps1 default clock is rising_edge(clk);
	--psl P1 : assert always (o1 = o2);
	
	/*-----------------Bool's MUX circuit-----------------------*/
	
	/*M8_1E*/
	with m8_1e_sel m8_1e_select
		o1_next <=	b  when "000",
					b  when "001",
					c  when "010",
					a  when "011",
			   	   '1' when "100",
				   '0' when "101",
				   '1' when "110",
				   '0' when others;
	m8_1e_sel <= d & e & f;
	
	/*-----------------Bool's LUT circuit-----------------------*/

	/*LUT4 1*/
	look_up_table_1 : entity work.lut4
		generic map(INIT => "0101001101010000")
		port map( 	I0 => f,
					I1 => e,
					I2 => d,
					I3 => b,
					O  => lut4_1);

	/*LUT4 2*/
	look_up_table_2 : entity work.lut4
		generic map(INIT => "0000010000000000")
		port map( 	I0 => f,
					I1 => e,
					I2 => d,
					I3 => c,
					O  => lut4_2);

	/*LUT4 3*/
	look_up_table_3 : entity work.lut4
		generic map(INIT => "0000100000000000")
		port map( 	I0 => f,
					I1 => e,
					I2 => d,
					I3 => a,
					O  => lut4_3);

	/*LUT4 4*/
	look_up_table_4 : entity work.lut4
		generic map(INIT => "1111111111111110")
		port map( 	I0 => lut4_2,
					I1 => lut4_1,
					I2 => lut4_3,
					I3 => '0',
					O  => o2_next);

	/*-----------------Common FDR for MUX circuit and LUT circuit----------------*/
	/*FDR*/
	reg_proc : process(clk, rst)
	begin
		if(rst = '1')then
			o1_reg <= '0';
			o2_reg <= '0';
		elsif rising_edge(clk) then
			o1_reg <= o1_next;
			o2_reg <= o2_next;
		end if;
	end process reg_proc;
	o1 <= o1_reg;
	o2 <= o2_reg;

end architecture rtl;
	
