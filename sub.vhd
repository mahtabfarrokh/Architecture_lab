LIBRARY IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity sub is
        port( 
    a, b: in  std_logic_vector(15 downto 0);
    sub: out std_logic_vector(15 downto 0);
    borrowout: out std_logic
    
      );
end entity;

architecture sub1 of sub is

component fullAdderVector is 
generic (N: integer := 16);
   port(
    a, b: in std_logic_vector(N-1 downto 0);
      sum: out std_logic_vector(N-1 downto 0);
    cout: out std_logic
  );
      end component;

  signal c0, c1: std_logic;
  signal ib: std_logic_vector(15 downto 0);
  signal ic: std_logic_vector(15 downto 0):= "0000000000000000";
  signal sum0, sum1: std_logic_vector(15 downto 0);
begin

  ib <= not(b); 
  s0: fullAdderVector port map(a, ib, sum0, c0); -- two comp then add
  s1: fullAdderVector port map(sum0, "0000000000000001", sum1, c1);
 -- sum1 <= sum0 - cin;
  borrowout<= c0 xor c1;
  
  sub<= sum1;
end sub1;
