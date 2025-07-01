library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex5 is
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex5;

architecture structural of lab4_ex5 is
	component mux41 
		port(i: in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector(1 downto 0);
			 y: out std_logic);
	end component;

	begin
		LEDR <= SW;
		DUT: mux41 port map(SW(3 downto 0),SW(5 downto 4),LEDG(7));
	end structural; 

library ieee;
use ieee.std_logic_1164.all;
entity mux41 is
	port(i: in std_logic_vector(3 downto 0);
			 sel: in std_logic_vector(1 downto 0);
			 y: out std_logic); 
end mux41;

architecture structural of mux41 is
	signal n_s: std_logic_vector(1 downto 0);
	signal x:  std_logic_vector(3 downto 0);
	component and_gate 
		port (a,b,c: in std_logic;
			  y:out std_logic);
	end component;
	
	component or_gate 
		port (a,b,c,d: in std_logic;
			  y:out std_logic);
	end component;
	
	component not_gate 
		port (a: in std_logic;
			  y:out std_logic);
	end component;
	begin
	g1: not_gate port map(a=>sel(0), y=>n_s(0)); 
	g2: not_gate port map(a=>sel(1), y=>n_s(1)); 
	
	g3: and_gate port map(a=>sel(1),b=>sel(0),c=>i(3),y=>x(3));
	g4: and_gate port map(a=>sel(1),b=>n_s(0),c=>i(2),y=>x(2));
	g5: and_gate port map(a=>n_s(1),b=>sel(0),c=>i(1),y=>x(1));
	g6: and_gate port map(a=>n_s(1),b=>n_s(0),c=>i(0),y=>x(0));
	
	g7: or_gate port map(a=>x(3),b=>x(2),c=>x(1),d=>x(0),y=>y);
	end structural;
	
library ieee;
use ieee.std_logic_1164.all;
entity and_gate is
	port (a,b,c: in std_logic;
			  y:out std_logic);
end and_gate;

architecture dataflow of and_gate is
	begin 
		y <= a and b and c;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;
entity or_gate is
	port (a,b,c,d: in std_logic;
			  y:out std_logic);
end or_gate;

architecture dataflow of or_gate is
	begin 
		y <= a or b or c or d;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;
entity not_gate is
	port (a: in std_logic;
			  y:out std_logic);
end not_gate;

architecture dataflow of not_gate is
	begin 
		y <= not a;
end dataflow;

