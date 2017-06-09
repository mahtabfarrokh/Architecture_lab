library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;
entity control is 
  port (
    clk , READYANSWERSHIFT, greater , equal: in std_logic ; 
    IR : in std_logic_vector(15 downto 0) ; 
    funcalu : out std_logic_vector(3 downto 0) ;
    writeReg ,  readmem , writemem : out std_logic ;
    controlBusMux , controlpcMux:out std_logic_vector (1 downto 0) ;
    resetpc , loadpc , loadIR , immediate , RESETSHIFT , admem  :out std_logic    
  );
end entity; 
architecture func of control is 
 type state is (S0, S1, S2, S3, S4 , SR0 , SJ0 , SI0 , SIShift1 , SIShift2);
	signal current_state : state;
	signal next_state : state;
begin 
  -- next to current
	process (clk)
	begin
		if clk'event and clk = '1' then
			   current_state <= next_state;
		end if;
	end process;
	
	-- next based on state
	process (current_state)
	begin
		case current_state is
			when S0 =>
				next_state <= S1;
			when S1 =>
			  RESETSHIFT <= '1' ; 
				readmem <= '1' ; 
				writemem <= '0' ; 
				funcalu <= "1000" ; 
				controlpcMux  <= "00" ; 
				controlBusMux <= "01" ; 
				resetpc <= '0' ; 
				loadpc <= '0' ; 
			  loadIR <= '0' ;
 				writeReg <= '0' ; 
 				immediate <= '0';
 				admem <= '0' ;
 				next_state <= S2 ;
			when S2 =>
			  RESETSHIFT <= '1' ; 
			  admem <= '0' ;
			  readmem <= '0' ; 
				writemem <= '0' ; 
				funcalu <= "1000" ; 
				controlpcMux  <= "00" ; 
				controlBusMux <= "01" ; 
				resetpc <= '0' ;
				--pc ?  
				loadpc <= '1' ; 
			        loadIR <= '1' ;
 				writeReg <= '0' ; 
 				immediate <= '0';
				next_state <= S3;
			when S3 =>
			  admem <= '0' ;
			  RESETSHIFT <= '1' ; 
			  readmem <= '0' ; 
				writemem <= '0' ; 
				funcalu <= "1000" ; 
				controlpcMux  <= "00" ; 
				controlBusMux <= "01" ; 
				resetpc <= '0' ;
				--pc ?  
				loadpc <= '0' ; 
			        loadIR <= '1' ;
 				writeReg <= '0' ; 
 				immediate <= '0';
			  next_state <= S4;
			when S4 => 
			  admem <= '0' ;
			  RESETSHIFT <= '1' ; 
			  readmem <= '0' ; 
				writemem <= '0' ; 
				funcalu <= "1000" ; 
				controlpcMux  <= "00" ; 
				controlBusMux <= "00" ; 
				resetpc <= '0' ; 
				loadpc <= '0' ; 
			  loadIR <= '0' ;
 				writeReg <= '0' ;
 				if IR(15 downto 12) = "1111" then
					next_state <= SJ0;
					immediate <= '0';
				elsif  IR(15 downto 12) = "0000" then
					next_state <= SR0;
					immediate <= '0';
				else
					next_state <= SI0;
					immediate <= '1';
				end if;
			when SJ0 => 
			  RESETSHIFT <= '1' ;
        admem <= '0' ; 
			  readmem <= '0' ; 
				writemem <= '0' ; 
				funcalu <= "1000" ; 
				controlpcMux  <= "11" ; 
				controlBusMux <= "00" ; 
				resetpc <= '0' ; 
				loadpc <= '1' ; 
			  loadIR <= '0' ;
 				writeReg <= '0' ;
 				immediate <= '0';
			  next_state <= S0;
			when SR0 =>
			  RESETSHIFT <= '1' ; 
			  readmem <= '0' ; 
				writemem <= '0' ; 
				resetpc <= '0' ; 
				controlBusMux <= "00" ; 
			  loadIR <= '0' ;
			  immediate <= '0';
			  admem <= '0' ;
			  if IR(2 downto 0) = "111" then
			        funcalu <= "1000"  ; 
			        controlpcMux  <= "01" ; 
			        controlBusMux <= "00" ;
			        writeReg <= '0' ;
			        loadpc <= '1' ;
			   elsif IR(2 downto  0) = "110" then 
			     if greater = '1' then 
			       controlBusMux <= "11" ;
			     end if ; 
			   else 
			      writeReg <= '1' ;
			      loadpc <= '0' ;
			      funcalu <= '0' & IR (2 downto 0)  ; 
			      controlBusMux <= "10" ; 
			      controlpcMux  <= "00" ; 
			   end if ;
			  next_state <= S0;
			when SI0 => 
			  
			  if IR (15 downto 12)="0001" or IR (15 downto 12)="0010" or IR (15 downto 12)="0011" then 
			      immediate <= '1';
			      RESETSHIFT <= '1' ; 
			      funcalu <= '1' & IR (14 downto 12)  ; 
			      writeReg <= '1' ;
			      readmem <= '0' ; 
				    writemem <= '0' ; 
			      controlBusMux <= "10" ; 
			      controlpcMux  <= "00" ; 
			      next_state <= S0;
			      admem <= '0' ;
			  elsif  IR (15 downto 12)="0100" or IR (15 downto 12)="0101" or IR (15 downto 12)="0110" then
			       immediate <= '1';
			       next_state <= SIshift1;
			       
			  elsif (IR (15 downto 12)="1001" and equal= '1') or
			        (IR (15 downto 12)="1010" and equal= '0') or 
			        (IR (15 downto 12)="1011" and equal= '0' and greater ='0') or
			        (IR (15 downto 12)="1100" and greater= '1') or 
			        (IR (15 downto 12)="1101" and (equal= '1' or greater = '0')) or 
			        (IR (15 downto 12)="1110" and (equal= '1' or greater = '1')) then 
			           RESETSHIFT <= '1' ; 
			           readmem <= '0' ;
			           immediate <= '0'; 
			          	writemem <= '0' ; 
			           funcalu <= "1000" ; 
				         resetpc <= '0' ; 
				         loadpc <= '1' ; 
			           loadIR <= '0' ;
 				         writeReg <= '0' ; 
			           controlpcMux  <= "10" ;   
			           controlBusMux <= "00" ;
			           next_state <= S0;
			           admem <= '0' ;
			      elsif IR (15 downto 12)="0111" then 
			        --lhw
			        funcalu <= "1000" ; 
			        admem <= '1' ;
			        readmem <= '1' ; 
			        writemem <= '0' ; 
			        writeReg <= '1' ; 
			        controlBusMux <= "01" ;
			        controlpcMux  <= "00" ;
			        immediate <= '1'; 
			        next_state <= S0; 
			      elsif IR (15 downto 12)="1000" then 
			        --shw
			        immediate <= '1'; 
			        next_state <= S0;
			        controlBusMux <= "11" ;
			        funcalu <= "1000" ; 
			        admem <= '1' ;
			        writeReg <= '0' ; 
			        readmem <= '0' ; 
			       	writemem <= '1' ; 
			       	controlpcMux  <= "00" ; 
			      end if; 
			      
			when SIshift1 => 
			    
			    admem <= '0' ;
			    funcalu <= '1' & IR (14 downto 12)  ; 
			    controlpcMux  <= "00" ; 
			    readmem <= '0' ; 
			    writemem <= '0' ; 
			    if  READYANSWERSHIFT = '0' then 
			        RESETSHIFT <= '0' ;
			        writeReg <= '1' ;
			        controlBusMux <= "10" ;
			        next_state <= SIshift2;
			    else
			        next_state <= S0;
			        writeReg <= '0' ;
			        RESETSHIFT <= '1' ;
			        controlBusMux <= "00" ;
			    end if ;
			when SIshift2 => 
			   admem <= '0' ;
			    funcalu <= '1' & IR (14 downto 12)  ; 
			    controlpcMux  <= "00" ; 
			    readmem <= '0' ; 
			    writemem <= '0' ; 
			    if  READYANSWERSHIFT = '0' then 
			        RESETSHIFT <= '0' ;
			        writeReg <= '1' ;
			        controlBusMux <= "10" ;
			        next_state <= SIshift1 ;
			    else
			        next_state <= S0;
			        writeReg <= '0' ;
			        RESETSHIFT <= '1' ;
			        controlBusMux <= "00" ;
			    end if ;
			end case ;
			end process ;
end func ;
