library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ShiftRegister is 
  generic (N: integer := 16);
   port( 
     di: in std_logic_vector(N-1 downto 0);
    si, clk, load, shift, clr: in std_logic;
    do: out std_logic_vector(N-1 downto 0)
  );
end entity;

architecture Structural of ShiftRegister is
  
  signal output : std_logic_vector(15 downto 0 ) ;
begin
do <= output ;
  process(clk, clr)
  begin  
    
    if clr = '1' then  
      output <= (others => '0');
    elsif clk'event and clk ='1' then
      if shift = '1' then
        output <= si & output(N-1 downto 1);
      elsif load = '1' then
        output <= di;
      end if;
    end if;
  end process;

end architecture;