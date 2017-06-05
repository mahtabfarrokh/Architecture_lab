library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity D_flipflop is 
port ( D : in std_logic ;
	clock : in std_logic ;
	Q : out std_logic );
end entity ;

architecture rtl of D_flipflop is 

component JK_FF_VHDL is
   port( J,K, rst: in  std_logic;
         Clock: in std_logic;
         Q : out std_logic);
end component;
signal notD :std_logic ;
begin 

notD <= not D ;
z : JK_FF_VHDL port map (D,notD,'0',clock,Q);
end architecture ;