library IEEE;
use IEEE.std_logic_1164.all;

entity mux4 is
	generic (N : integer := 16);
	port (I00, I01, I10, I11 : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic_vector (1 downto 0));
end entity;

architecture rtl of mux4 is
  signal s1 ,s0 : std_logic_vector(15 downto 0 ) ;
begin
  s1 <= s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) ;
  s0 <= s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) ;
	 O <= ((I00 and (not s1) and (not s0) )or (I01 and (not s1) and (s0)) or (I10 and (s1) and (not s0)) or (I11 and (s1) and (s0)) );	
	 
	 end rtl;
