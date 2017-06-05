
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regfile is
	generic (N : integer := 3;
		M : integer := 16);
	port (readaddr1, readaddr2 : in std_logic_vector (N - 1 downto 0);
		writeaddr : in std_logic_vector (N - 1 downto 0);
		data : in std_logic_vector (M - 1 downto 0);
		write, clk , immediate : in std_logic;
		O1, O2 : out std_logic_vector (M - 1 downto 0));
end entity;

architecture rtl of regfile is
	type mem is array (natural range <>) of std_logic_vector (M - 1 downto 0);
	constant memsize : integer := 2 ** N;
	signal memory : mem (0 to memsize - 1) := (others => (others => '0'));
begin	
	process (clk)
			begin
		if clk'event and clk = '1' then
			if write = '1' then
			   if immediate = '0' then 
				    memory(to_integer(unsigned(writeaddr))) <= data;
				 else 
				    memory(to_integer(unsigned(readaddr2))) <= data;
				 end if ; 
			else
				O1 <= memory(to_integer(unsigned(readaddr1)));
				O2 <= memory(to_integer(unsigned(readaddr2)));
			end if;
		end if;
	end process;
end architecture rtl;