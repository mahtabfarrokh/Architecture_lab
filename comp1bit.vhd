library IEEE  ;
use IEEE.std_logic_1164.all ;



entity comp1bit is 
  port(
    a,b :in std_logic;
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end entity;
architecture func of comp1bit is
  signal tmpeq :Std_logic ;
  begin 
    tmpeq <= ( a and b ) or ((not a ) and (not b));
    g <=( a and (not b) ) or ( tmpeq and gin ) ;
    eq <= tmpeq and eqin ;
    l <= (( b and (not a) ) or ( tmpeq and lin )) ;



end func ;
  

