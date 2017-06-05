library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_signed.ALL;

entity FullAdderVector is
  generic (N: integer := 16);
   port(
    a, b: in std_logic_vector(N-1 downto 0);
      sum: out std_logic_vector(N-1 downto 0);
    cout: out std_logic
  );
end entity;

architecture Structural of FullAdderVector is
  
  signal mid: std_logic_vector(N downto 0);

  component FullAdder is
    port(
      a, b, cin: in std_logic;
      s, cout: out std_logic
    );
  end component;

begin
  
  mid(0) <= '0';
  cout <= mid(N);

  FG: for i in 0 to N-1 generate
    FA: FullAdder port map(a(i), b(i), mid(i),  sum(i), mid(i+1)); 
  end generate;

end architecture;
