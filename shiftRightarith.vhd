library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Shiftrightarith is 
   port( 
    i : in std_logic_vector(15 downto 0);
    shift : in std_logic;
    o : out std_logic_vector(15 downto 0)
  );
end entity;

architecture func of Shiftrightarith is
  begin
    o(0) <= (shift and i(1) ) or ((not shift) and i(0)) ; 
    o(1) <= (shift and i(2) ) or ((not shift) and i(1)) ; 
    o(2) <= (shift and i(3) ) or ((not shift) and i(2)) ; 
    o(3) <= (shift and i(4) ) or ((not shift) and i(3)) ; 
    o(4) <= (shift and i(5) ) or ((not shift) and i(4)) ; 
    o(5) <= (shift and i(6) ) or ((not shift) and i(5)) ; 
    o(6) <= (shift and i(7) ) or ((not shift) and i(6)) ; 
    o(7) <= (shift and i(8) ) or ((not shift) and i(7)) ; 
    o(8) <= (shift and i(9) ) or ((not shift) and i(8)) ; 
    o(9) <= (shift and i(10) ) or ((not shift) and i(9)) ; 
    o(10) <= (shift and i(11) ) or ((not shift) and i(10)) ; 
    o(11) <= (shift and i(12) ) or ((not shift) and i(11)) ; 
    o(12) <= (shift and i(13) ) or ((not shift) and i(12)) ; 
    o(13) <= (shift and i(14) ) or ((not shift) and i(13)) ; 
    o(14) <= (shift and i(15) ) or ((not shift) and i(14)) ; 
    o(15) <= i(15) ; 
end func ;
