library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity datapath is
  port (clk: in std_logic);
end entity ; 
architecture func of datapath is
COMPONENT ALUz is
    port (A, B : in  std_logic_vector (15 downto 0);
		func : in  std_logic_vector (3 downto 0);
		rst,clk : in std_logic ;
		AnsAlu : out  std_logic_vector (15 downto 0);
		gout,eqout,readyAnswerShift : out std_logic  
		);
end COMPONENT;

COMPONENT memory is
	port (address : in std_logic_vector (15 downto 0);
		data_in : in std_logic_vector (15 downto 0);
		data_out : out std_logic_vector (15 downto 0);
		clk, read, write : in std_logic);
end COMPONENT;
COMPONENT regfile is
	generic (N : integer := 3;
		M : integer := 16);
	port (readaddr1, readaddr2 : in std_logic_vector (N - 1 downto 0);
		writeaddr : in std_logic_vector (N - 1 downto 0);
		data : in std_logic_vector (M - 1 downto 0);
		write, clk , immediate: in std_logic;
		O1, O2 : out std_logic_vector (M - 1 downto 0));
end COMPONENT;
COMPONENT register_N is
	generic (N : integer := 16);
	port (reset, clk, load  : in std_logic;
		ldata : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0));
end COMPONENT;
component mux4 is
	generic (N : integer := 16);
	port (I00, I01, I10, I11 : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic_vector (1 downto 0));
end component;
component control is 
  port (
    clk ,READYANSWERSHIFT, greater , equal: in std_logic ; 
    IR : in std_logic_vector(15 downto 0) ; 
    funcalu : out std_logic_vector(3 downto 0) ;
    writeReg ,  readmem , writemem : out std_logic ;
    controlBusMux , controlpcMux:out std_logic_vector (1 downto 0) ;
    resetpc , loadpc , loadIR , immediate , RESETSHIFT , admem :out std_logic    
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
component mux2 is
	generic (N : integer := 16);
	port (I0 , I1 : in std_logic_vector (N - 1 downto 0);
		O : out std_logic_vector (N - 1 downto 0);
		S : in  std_logic );
end component;
signal D2 , O1, O2, ALUres, pcin, pcout, Rin, Rout, Iin , IRout ,
Iout, Jin, Jout , memout , pcincrement , address_memory : std_logic_vector(15 downto 0); 
signal Cfunc : std_logic_vector (3 downto 0) ;
signal equal , greater , readmem , writemem  : std_logic;  
signal BUSm  : std_logic_vector (15 downto 0); 
signal  SI , SI2 , IRextend : std_logic_vector (15 downto 0); 
signal READYANSWERSHIFT, RESETALU , writeReg : std_logic ;
signal controlBusMux , controlpcMux: std_logic_vector (1 downto 0) ;
signal resetpc , loadpc , loadIR , resetIR , roohava2 , immediate , admem : std_logic ;

  begin
    ALU : ALUz port map (O1 , D2 ,Cfunc ,RESETALU , CLK , ALUres , greater , equal , READYANSWERSHIFT); 
    mem : memory port map (address_memory , BUSm , memout ,clk, readmem , writemem );
    regf : regfile port map (IRout(11 downto 9) , IRout(8 downto 6) , IRout(5 downto 3) , BUSm , writeReg , clk ,immediate, O1 ,O2);
    pc : register_N port map (resetpc , clk , loadpc , pcin , pcout);
    IR : register_N port map ('0' , clk , loadIR , Busm , IRout);
    Rjump : register_N port map ('0' , clk , '1' , O1 , Rout);
    Ijump : register_N port map ('0' , clk , '1' , Iin , Iout); 
    JJump : register_N port map ('0' , clk , '1' , Jin , Jout);
    busMuxout : mux4 port map (BUSm , memout , ALUres  , O2 ,BUSm , controlBusMux );
    pcmux : mux4 port map ( pcincrement , Rout , Iout , Jout , pcin , controlpcMux ); 
    ad1 : FullAdderVector port map(pcout , "0000000000000100" , SI  , roohava2 );
    ad2 : FullAdderVector port map(IRextend , IRextend , SI2 , roohava2 );
    ad3 : FullAdderVector port map(SI , SI2 , Iin ,  roohava2);
    ad4 : FullAdderVector port map(pcout , "0000000000000001" , pcincrement , roohava2 );
    ImALU : mux2 port map (O2 ,IRextend , D2 , immediate );  
    adrmem : mux2 port map (pcout , ALUres , address_memory ,admem); 
    ctrl : control port map (clk ,READYANSWERSHIFT, greater , equal, IRout , Cfunc , writeReg , readmem , writemem ,
            controlBusMux , controlpcMux , resetpc , loadpc , loadIR , immediate , RESETALU , admem ); 
    IRextend <= IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5)&IRout(5 downto 0) ; 
    Jin <= pcout(15 downto 13)& IRout(11 downto 0)&'0' ; 
end func ;