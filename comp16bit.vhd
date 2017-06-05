


library IEEE  ;
use IEEE.std_logic_1164.all ;



entity comp16bit is 
  port(
    a,b :in std_logic_vector(15 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end entity;
architecture func of comp16bit is
  
  component comp8bit is 
  port(
    a,b :in std_logic_vector(7 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
  end component;
  signal g1,e1,l1 :std_logic ;
   begin 
     q1  : comp8bit port map(a(15 downto 8),b(15 downto 8),g1,e1,l1,g,l,eq);
       q2  : comp8bit port map(a(7 downto 0),b(7 downto 0),gin,eqin,lin,g1,l1,e1);
  end func ;
  





