library IEEE;
use IEEE.std_logic_1164.all;

entity mux16 is
  port (  I0000, I0001, I0010, I0011, I0100, I0101,
                I0110, I0111 , I1000, I1001, I1010, I1011, I1100, I1101,
                I1110, I1111: in std_logic_vector (15 downto 0);
    O : out std_logic_vector (15 downto 0);
    S : in  std_logic_vector (0 to 3));

end entity;

architecture rtl of mux16 is
signal S0 , S1 ,S2 , S3 : std_logic_vector(15 downto 0) ; 
begin
  S0 <= s(0)& s(0) &s(0)& s(0) &s(0)& s(0) &s(0)& s(0) &s(0)& s(0) &s(0)& s(0) &s(0)& s(0) &s(0)& s(0) ;
  S1 <= s(1)& S(1)&s(1)& S(1)& s(1)& S(1)&s(1)& S(1)&s(1)& S(1)&s(1)& S(1)&s(1)& S(1)&s(1)& S(1);
  S2 <= S(2) & S(2) &S(2) & S(2) &S(2) & S(2) &S(2) & S(2) &S(2) & S(2) &S(2) & S(2) &S(2) & S(2) &S(2) & S(2) ;
  S3 <= S(3) & s(3) &S(3) & s(3) &S(3) & s(3) &S(3) & s(3) &S(3) & s(3) &S(3) & s(3) &S(3) & s(3) &S(3) & s(3) ; 
  O <= (I0000 and  (not S0 ) and (not S1) and (not S2 ) and (not S3 ))or 
       (I0001 and  (not S0 ) and (not S1) and (not S2 ) and      S3 )  or 
       (I0010 and  (not S0 ) and (not S1) and      S2   and (not S3 )) or
       (I0011 and  (not S0 ) and (not S1) and      S2   and      S3 )  or
       (I0100 and  (not S0 ) and      S1  and (not S2 ) and (not S3 )) or
       (I0101 and  (not S0 ) and      S1  and (not S2 ) and      S3 )  or
       (I0110 and  (not S0 ) and      S1  and      S2   and (not S3 )) or
       (I0111 and  (not S0 ) and      S1  and      S2   and      S3 )  or
       (I1000 and       S0   and (not S1) and (not S2 ) and (not S3 )) or
       (I1001 and       S0   and (not S1) and (not S2 ) and      S3 )  or 
       (I1010 and       S0   and (not S1) and      S2   and (not S3 )) or
       (I1011 and       S0   and (not S1) and      S2   and      S3 )  or
       (I1100 and       S0   and      S1  and (not S2 ) and (not S3 )) or
       (I1101 and       S0   and      S1  and (not S2 ) and      S3 )  or
       (I1110 and       S0   and      S1  and      S2   and (not S3 )) or
       (I1111 and       S0   and      S1  and      S2   and      S3 )  ;
    
end rtl;
