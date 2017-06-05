library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity JK_FF_VHDL is
   port( J,K: in  std_logic;
         Clock: in std_logic;
         Q : out std_logic);
end JK_FF_VHDL;

architecture func of JK_FF_VHDL is
   signal temp : std_logic := '0' ; 
    signal tempbar : std_logic := '0' ; 
   signal and1 , and2 : std_logic ;
begin
      and1 <= temp and clock and k ; 
      and2 <= tempbar and clock and j ; 
      temp <= tempbar nor and1 ; 
      tempbar <= temp nor and2 ; 
      Q <= temp ; 
end func ;
