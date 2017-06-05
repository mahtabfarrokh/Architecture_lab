
library IEEE  ;
use IEEE.std_logic_1164.all ;



entity comp4bit is 
  port(
    a,b :in std_logic_vector(3 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end entity;
architecture func of comp4bit is
  
  component comp2bit is 
  port(
    a,b :in std_logic_vector(1 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end component;
  signal g1,e1,l1 :std_logic ;
   begin 
     q1  : comp2bit port map(a(3 downto 2),b(3 downto 2),g1,e1,l1,g,l,eq);
       q2  : comp2bit port map(a(1 downto 0),b(1 downto 0),gin,eqin,lin,g1,l1,e1);
  end func ;
  



