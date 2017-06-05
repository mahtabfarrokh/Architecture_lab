


library IEEE  ;
use IEEE.std_logic_1164.all ;



entity comp8bit is 
  port(
    a,b :in std_logic_vector(7 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end entity;
architecture func of comp8bit is
  
  component comp4bit is 
  port(
    a,b :in std_logic_vector(3 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end component;
  signal g1,e1,l1 :std_logic ;
   begin 
     q1  : comp4bit port map(a(7 downto 4),b(7 downto 4),g1,e1,l1,g,l,eq);
       q2  : comp4bit port map(a(3 downto 0),b(3 downto 0),gin,eqin,lin,g1,l1,e1);
  end func ;
  



