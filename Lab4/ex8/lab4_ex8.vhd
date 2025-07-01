library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex8 is
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex8;

architecture structural of lab4_ex8 is
	component demux18 
		port(i: in std_logic;
			 en: in std_logic;
			 sel: in std_logic_vector(2 downto 0);
			 d: out std_logic_vector(7 downto 0));
	end component;

	begin
		LEDR <= SW;
		DUT: demux18 port map(SW(4),SW(3),SW(2 downto 0),LEDG(7 downto 0));
	end structural;

library ieee;
use ieee.std_logic_1164.all;
entity demux18 is
	port(i: in std_logic;
		 en: in std_logic;
		 sel: in std_logic_vector(2 downto 0);
		 d: out std_logic_vector(7 downto 0));
end demux18;


architecture structural of demux18 is
	signal n_s: std_logic_vector(2 downto 0);
	component not_gate
		port(a: in std_logic;
			 y: out std_logic);
	end component;

	component and_gate 
		port(a,b,c,d,e: in std_logic;
			 y:out std_logic );
	end component;
	
	begin
	g1: not_gate port map(a=>sel(0), y=>n_s(0));
	g2: not_gate port map(a=>sel(1), y=>n_s(1));
	g3: not_gate port map(a=>sel(2), y=>n_s(2));
	
	g4: and_gate port map(a=>n_s(0), b=>n_s(1), c=>n_s(2),d=>en,e=>i, y=>d(0));
	g5: and_gate port map(a=>sel(0), b=>n_s(1), c=>n_s(2),d=>en,e=>i, y=>d(1));
	g6: and_gate port map(a=>n_s(0), b=>sel(1), c=>n_s(2),d=>en,e=>i, y=>d(2));
	g7: and_gate port map(a=>sel(0), b=>sel(1), c=>n_s(2),d=>en,e=>i, y=>d(3));
	g8: and_gate port map(a=>n_s(0), b=>n_s(1), c=>sel(2),d=>en,e=>i, y=>d(4));
	g9: and_gate port map(a=>sel(0), b=>n_s(1), c=>sel(2),d=>en,e=>i, y=>d(5));
	g10: and_gate port map(a=>n_s(0), b=>sel(1), c=>sel(2),d=>en,e=>i, y=>d(6));
	g11: and_gate port map(a=>sel(0), b=>sel(1), c=>sel(2),d=>en,e=>i, y=>d(7));
	end structural;
	
library ieee;
use ieee.std_logic_1164.all;
entity and_gate is
port(	a: in std_logic;
	    b: in std_logic;
	    c: in std_logic;
	    d: in std_logic;
	    e: in std_logic;
	    y: out std_logic
);
end and_gate;
  
architecture dataflow of and_gate is
begin
    y <= a and b and c and d and e;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;
entity not_gate is
port(	a: in std_logic;
	   y: out std_logic
);
end not_gate;  

architecture dataflow of not_gate is
begin
    y <= not a;
end dataflow;

