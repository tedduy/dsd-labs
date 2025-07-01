library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex10 is
generic(N: natural :=4);
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex10;

architecture structural of lab4_ex10 is
	component ALU 
		port(	A:	in std_logic_vector(N-1 downto 0);
		B:	in std_logic_vector(N-1 downto 0);
		Op:	in std_logic_vector(2 downto 0);
		Res:	out std_logic_vector(N-1 downto 0));
	end component;

	begin
		LEDR <= SW;
		DUT: ALU 
				port map(
					SW(2*N-1 downto N),
					SW(N-1 downto 0),
					SW(2*N+2 downto 2*N),
					LEDG(N-1 downto 0));
	end structural;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ALU is
generic(N: natural :=4);

port(	A:	in std_logic_vector(N-1 downto 0);
		B:	in std_logic_vector(N-1 downto 0);
		Op:	in std_logic_vector(2 downto 0);
		Res:	out std_logic_vector(N-1 downto 0));
end ALU;

architecture behv of ALU is
begin					   

    process(A,B,Op)
    begin

	case Op is
	    when "000" =>
		 Res <= A + B;
	    when "001" =>				
	        Res <= A - B;
            when "010" =>
		Res <= not A ;
	    when "011" =>	 
		Res <= not (A and B);
	    when "100" =>	 
		Res <= not (A or B);
	    when "101" =>	 
		Res <= A and B;
	    when "110" =>	 
		Res <= A or B;
	    when "111" =>	 
		Res <= A xnor B;
        end case;

    end process;

end behv;
