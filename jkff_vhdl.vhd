library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity JK_FF_VHDL is
   port( J,K, rst: in  std_logic;
         Clock: in std_logic;
         Q : out std_logic);
end JK_FF_VHDL;

architecture behavioral of JK_FF_VHDL is
   begin
PROCESS(CLOCK, rst)
variable TMP: std_logic;
begin
if(rst = '1')then
TMP:='0';
end if;
  
if(CLOCK='1' and CLOCK'EVENT) then
if(J='0' and K='0')then
TMP:=TMP;
elsif(J='1' and K='1')then
TMP:= not TMP;
elsif(J='0' and K='1')then
TMP:='0';
else
TMP:='1';
end if;
end if;
Q<=TMP;
end PROCESS;
end behavioral;
