library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;


entity register_N is
	generic (N : integer := 16);
	port (reset, clk, load  : in std_logic;
		ldata : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0));
end entity;

architecture rtl of register_N is
	signal storage : std_logic_vector (N - 1 downto 0) := (others => '0');
begin
	O <= storage;
	process(clk)
	begin
		if clk'event and clk ='1' then
			if reset = '1' then
				storage <= (others => '0');
			elsif load = '1' then
				storage <= ldata;
			end if;
		end if;
	end process;
end rtl;
