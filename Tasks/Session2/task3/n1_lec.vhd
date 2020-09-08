library ieee;
use ieee.std_logic_1164.ALL;
entity n1_lec is
 port (
	 y : out std_logic;
	 z : out std_logic; 
	 a : in std_logic_vector ( 3 downto 0 )
 );
end n1_lec;

architecture GLVL of n1 is
begin
 y1 : GEN_LUT4
 generic map(
 INIT => X"??FF"
 )
 port map (
 I0 => a(1),
 I1 => a(0),
 I2 => a(3),
 I3 => a(2),
 O => y
 );
 Mrom_z11 : GEN_LUT4
 generic map(
 INIT => X"??87"
 )
 port map (
 I0 => a(2),
 I1 => a(3),
 I2 => a(0),
 I3 => a(1),
 O => z
 );
end GLVL;
