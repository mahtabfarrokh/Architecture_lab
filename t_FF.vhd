library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity T_FF is
   port( T: in  std_logic;
         Clock: in std_logic;
         Q,Qbar : out std_logic);
end T_FF;

architecture func of T_FF is
  signal t1,c1,nt,nc : std_logic ;
begin 
  t1 <= t and Clock ;
  c1 <= t and Clock ;
  nt <= t1 nor nc ;
  nc <= c1 nor nt ;
  Q <= nt;
  Qbar <= nc ;
end architecture ;

