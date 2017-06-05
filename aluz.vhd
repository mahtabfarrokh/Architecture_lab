library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity ALUz is
    port (A, B : in  std_logic_vector (15 downto 0);
		--OP : in  std_logic_vector (3 downto 0);
		func : in  std_logic_vector (3 downto 0);
		rst,clk : in std_logic ;
		AnsAlu : out  std_logic_vector (15 downto 0);
		gout,eqout,readyAnswerShift : out std_logic  
		);
	--	cond : out  std_logic);
end entity;

architecture rtl of ALUz is
	Signal tResult : std_logic_vector (15 downto 0);
	Signal sumResult,subResult : std_logic_vector (15 downto 0);
	Signal cout , borrowout : std_logic;
	Signal tCond:   std_logic;
	component shiftComponent is port(
  untilShift : in std_logic_vector(5 downto 0);
  rst,clk : in std_logic;
  src1 : in std_logic_vector(15 downto 0 ) ;
  shraz , shllz,shrlz : out std_logic_vector(15 downto 0 ) ;
  z : out std_logic  
 );
 end component;

component FullAdderVector is
  generic (N: integer := 16);
   port(
    a, b: in std_logic_vector(N-1 downto 0);
      sum: out std_logic_vector(N-1 downto 0);
    cout: out std_logic
  );
end component;
component mux8 is
	generic (N : integer := 16);
	port (I000, I001, I010, I011,I100, I101, I110, I111  : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic_vector (2 downto 0));
end component;
component mux16 is
  port (  I0000, I0001, I0010, I0011, I0100, I0101,
                I0110, I0111 , I1000, I1001, I1010, I1011, I1100, I1101,
                I1110, I1111: in std_logic_vector (15 downto 0);
    O : out std_logic_vector (15 downto 0);
    S : in  std_logic_vector (0 to 3));

end component;
component comp16bit is 
  port(
    a,b :in std_logic_vector(15 downto 0);
    gin,eqin,lin : in std_logic ;
    g,l,eq : out std_logic 
  
  
  );
end component ;
component sub is
        port( 
    a, b: in  std_logic_vector(15 downto 0);
    sub: out std_logic_vector(15 downto 0);
    borrowout: out std_logic
    
      );
end component;


component mul16bit is
port( a,b: in std_logic_vector(7 downto 0);
		p: out std_logic_vector(15 downto 0)
		);
end component;

signal untilshift : std_logic_vector (15 downto 0) ; 
signal orz,andz,xorz,norz,mul,tmp,gzz,eqzz,lzz ,slt,sllz,srlz,sraz: std_logic_vector(15 downto 0 );
signal gz,eqz,lz , cc :std_logic ;
begin
z1 : FullAdderVector port map (A,B,sumResult,cout);
z2 : sub port map (A, B,subResult , borrowout );
z6 : FullAdderVector port map (B,"1111111111111111",untilshift,cc);
z5 : comp16bit port map (A,B,'0','1','0',gz,eqz,lz);  
--z6 : ShiftLeft port map (A , slen,sllz);
--slen <= func(3) and func(2) and (not func(1)) and (not func(0));
--z7 : shiftrightarith port map (A , srAen,sraz);
--srAen <= func(3) and func(2) and ( func(1)) and (not func(0));
--z8 : Shiftrightlogic port map(A , sren,srlz);
--sren <= func(3) and func(2) and (not func(1)) and ( func(0));
z4 : mul16bit port map (A(7 downto 0 ), B(7 downto 0),mul );
z9 : shiftComponent port map (untilshift(5 downto 0) , rst , clk,A , sraz , sllz,srlz ,readyAnswerShift ) ;
  -- compResult not defined :/
z3 : mux16 port map(sumResult,subResult,andz,orz,xorz,mul,slt,tmp,tmp,sumResult,andz,orz,sllz,srlz,sraz,tmp,ansAlu,func);
gzz <= gz &gz &gz &gz &gz &gz &gz &gz &gz &gz &gz &gz &gz &gz &gz &gz ;
eqzz<=eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz &eqz  ;
lzz <= lz &lz &lz &lz &lz &lz &lz &lz &lz &lz &lz &lz &lz &lz &lz &lz ;
slt <= ((gzz  and A) or(eqzz and A) or (lzz and B)) ;
orz <= a or b;
andz<= a and b;
xorz<= a xor b;
norz<= a nor b;
gout <= gz ;
eqout <= eqz ;	
end architecture;
