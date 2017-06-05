library IEEE;
use IEEE.std_logic_1164.all;

entity mux8 is
	generic (N : integer := 16);
	port (I000, I001, I010, I011,I100, I101, I110, I111  : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic_vector (2 downto 0));
end entity;

architecture rtl of mux8 is
  signal s2,s1 ,s0 : std_logic_vector(15 downto 0 ) ;
begin
  s1 <= s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) & s(1) ;
  s0 <= s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) & s(0) ;
	s2 <= s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) & s(2) ; 
	 O <= ((I000 and (not s1) and (not s0) and (not s2) )or (I001 and (not s1) and (s0) and (not s2)) or (I010 and (s1) and (not s0) and (not s2)) or (I011 and (s1) and (s0) and (not s2))or
    (I100 and (not s1) and (not s0) and (s2) )or (I101 and (not s1) and (s0) and ( s2)) or (I110 and (s1) and (not s0) and ( s2)) or (I111 and (s1) and (s0) and (s2))); 	
	 
	 end rtl;

