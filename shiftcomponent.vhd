
library IEEE;
use IEEE.std_logic_1164.all;
entity shiftComponent is port(
  untilShift : in std_logic_vector(5 downto 0);
  rst,clk : in std_logic;
  src1 : in std_logic_vector(15 downto 0 ) ;
  shraz , shllz,shrlz : out std_logic_vector(15 downto 0 ) ;
  z : out std_logic  
 );
 end entity ;

architecture rtl of shiftComponent is
  
component mux2 is
	generic (N : integer := 16);
	port (I0, I1: in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic);
end component;

component Counter is
   port( 
    rst, clk, count: in std_logic ;
    untilshift : in std_logic_vector( 5 downto 0 ) ; 
    z: out std_logic
  );
end component;
component ShiftLeft is 
   port( 
    i : in std_logic_vector(15 downto 0);
    shift : in std_logic;
    o : out std_logic_vector(15 downto 0)
  );
end component;
component Shiftrightlogic is 
   port( 
    i : in std_logic_vector(15 downto 0);
    shift : in std_logic;
    o : out std_logic_vector(15 downto 0)
  );
end component;
component Shiftrightarith is 
   port( 
    i : in std_logic_vector(15 downto 0);
    shift : in std_logic;
    o : out std_logic_vector(15 downto 0)
  );
end component;


component D_FF16 is port(
i : in std_logic_vector(15 downto 0 );
clock : in std_logic ;
o : out std_logic_vector(15 downto 0)
);
end component ;


signal middShift1,middShift11,middShift111 : std_logic_vector(15 downto 0 );
signal middShift2,middShift22,middShift222 : std_logic_vector(15 downto 0 );
signal middShift3,middShift33,middShift333 : std_logic_vector(15 downto 0 );
signal count : std_logic ;
signal muxSelect : std_logic ;
begin 
  count <= not rst ;
  muxSelect <= not rst ;
  c : Counter port map(rst ,clk,count , untilShift,z);
  sh1 : ShiftLeft port map (middShift1 , count, middshift11);
  sh2 : Shiftrightlogic port map (middshift2,count,middshift22);
  sh3 : Shiftrightarith port map (middshift3 , count , middshift33 ) ;
  mux11 : mux2 port map(src1 , middshift111 , middshift1 , muxSelect);
  mux22 : mux2 port map(src1 , middshift222 , middshift2 , muxSelect);
  mux33 : mux2 port map(src1 , middshift333 , middshift3 , muxSelect); 
  DFF1 : D_FF16 port map(middshift11, clk ,middshift111);
  DFF2 : D_FF16 port map(middshift22, clk ,middshift222);
  DFF3 : D_FF16 port map(middshift33, clk ,middshift333);
  shllz <= middShift11 ;
  shrlz <= middshift22 ;
  shraz <= middshift33 ;

end architecture ;