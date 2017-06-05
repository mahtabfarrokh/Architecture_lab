library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memory is
	port (address : in std_logic_vector (15 downto 0);
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0);
		clk, read, write : in std_logic);
end entity;

architecture behavioral of memory is
	type mem is array (natural range <>) of std_logic_vector (15 downto 0);
begin
	process (clk)
		constant memsize : integer := 2 ** 16;
		variable memory : mem (0 to memsize - 1) := (
	 --	"0000000001010000",  -- ADD 
	 --	"0100000001000100",  -- for shift 4 left 
	 -- "0001000001000111",  -- ADD IMMIDIATE
	 -- "1001000001000001",  -- bRANCH IF EQUAL 
	    "0111000001000000",
 			others => "0000000000000000"
		);
	begin
		if  clk'event and clk = '1' then
			if read = '1' then -- Reading :)
				data_out <= memory(to_integer(unsigned(address)));
			elsif write = '1' then -- Writing :)
				memory(to_integer(unsigned(address))) := data_in;
			end if;
		end if;
	end process;
end architecture behavioral;
