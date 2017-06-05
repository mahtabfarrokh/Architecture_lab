
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
    port(
     a, b, cin: in std_logic;
     s, cout: out std_logic
   );
end entity;

architecture Structural of FullAdder is
begin
  s <= a xor b xor cin;
  cout <= ((a xor b) and (cin)) or (a and b);
end architecture;