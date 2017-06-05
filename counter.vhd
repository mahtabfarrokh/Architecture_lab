library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity Counter is
   port( 
    rst, clk, count: in std_logic ;
    untilshift : in std_logic_vector( 5 downto 0 ) ; 
    z: out std_logic
  );
end entity;

architecture Structural of Counter is
  component  JK_FF_VHDL is
   port( J,K, rst: in  std_logic;
         Clock: in std_logic;
         Q : out std_logic);
end component ;
signal k : std_logic := '1' ;
signal j  : std_logic := '0' ; 
signal answer,Q , Q1 , Q2 , Q3 , Q4, Q5 , C , C1 , C2 , C3 , C4 , C5: std_logic := '0' ; 
signal result , res2 : std_logic_vector (5 downto 0) ; 
begin
j <= not rst ; 
k <= '1' ; 
C <=  clk ; 
C1 <= not Q ; 
C2 <= not Q1 ; 
C3 <= not Q2 ; 
C4 <= not Q3 ; 
C5 <= not Q4 ;
jk1 : JK_FF_VHDL port map (j , k, rst  ,C , Q ) ;
jk2 : JK_FF_VHDL port map (j , k, rst  , C1 , Q1 ) ;
jk3 : JK_FF_VHDL port map (j , k, rst  , C2 , Q2 ) ;
jk4 : JK_FF_VHDL port map (j , k, rst  , C3 , Q3 ) ;
jk5 : JK_FF_VHDL port map (j , k, rst  , C4 , Q4 ) ;
jk6 : JK_FF_VHDL port map (j , k, rst , C5 , Q5 ) ;
 result <=  Q5 & Q4 & Q3 & Q2 & Q1 & Q  ;
 res2 <= not ( result xor untilshift ) ; 
 answer <= ((res2(0) and res2(1) and res2(2) and res2(3) and res2(4) and res2(5) ) or answer) and (not rst) ; 
 z<= answer ;
end architecture;
