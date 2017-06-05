

library IEEE  ;
use IEEE.std_logic_1164.all ;



entity comp2bit is 
  port(
    a,b :in std_logic_vector(1 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end entity;
architecture func of comp2bit is
  
  component comp1bit is 
  port(
    a,b :in std_logic;
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end component;
  signal g1,e1,l1 :std_logic ;
   begin 
     q1  : comp1bit port map(a(1),b(1),g1,e1,l1,g,l,eq);
       q2  : comp1bit port map(a(0),b(0),gin,eqin,lin,g1,l1,e1);
  end func ;
  

