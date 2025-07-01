library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex9 is
generic(n: natural :=4);
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex9;

architecture structural of lab4_ex9 is
	component comparator 
		port(	A:	in std_logic_vector(n-1 downto 0);
				B:	in std_logic_vector(n-1 downto 0);
				less:		out std_logic;
				equal:		out std_logic;
				greater:	out std_logic);
	end component;

	begin
		LEDR <= SW;
		DUT: comparator port map(SW(2*n-1 downto n),SW(n-1 downto 0),LEDG(7),LEDG(6),LEDG(5));
	end structural;

library ieee;
use ieee.std_logic_1164.all;

entity comparator is
generic(n: natural :=4);
port(	A:	in std_logic_vector(n-1 downto 0);
	B:	in std_logic_vector(n-1 downto 0);
	less:		out std_logic;
	equal:		out std_logic;
	greater:	out std_logic
);
end comparator;
architecture behv of comparator is
begin 
    process(A,B)
    begin
        if (A>B) then 
	    less <= '0';
	    equal <= '0';
	    greater <= '1';
	elsif (A=B) then   
	    less <= '0';
	    equal <= '1';
	    greater <= '0';
	else 
	    less <= '1';
	    equal <= '0';
	    greater <= '0';
	end if;
    end process;

end behv;
