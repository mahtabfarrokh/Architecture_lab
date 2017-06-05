library IEEE;
use IEEE.std_logic_1164.all;

entity mux2 is
	generic (N : integer := 16);
	port (I0 , I1 : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic );
end entity;

architecture func of mux2 is
  signal s0 : std_logic_vector(15 downto 0 ) ;
begin
  s0 <= s & s & s & s & s & s & s & s & s & s & s & s & s & s & s & s ;
	 O <= ((I0  and (not s0) )or (I1 and (s0))) ;	
	 
end func ;


