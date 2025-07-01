library ieee;
use ieee.std_logic_1164.all;

entity lab4_ex2 is
	port (SW: in std_logic_vector(17 downto 0);
		  LEDR: out std_logic_vector(17 downto 0);
		  LEDG: out std_logic_vector(7 downto 0));
end lab4_ex2;

architecture structure of lab4_ex2 is
	component half_adder
		port(a,b: in std_logic;
			 s,c: out std_logic);
	end component;
	begin 
		LEDR <= SW;
		DUT: half_adder port map(SW(1),SW(0),LEDG(1),LEDG(0));
	end structure;

library ieee;
use ieee.std_logic_1164.all;	
entity half_adder is
	port(a,b: in std_logic;
		 s,c: out std_logic);
end half_adder;

architecture dataflow of half_adder is
	begin
		s <= a xor b;
		c <= a and b;
	end dataflow;
