library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex4 is
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex4;

architecture structural of lab4_ex4 is
	component mux21 
		port(i: in std_logic_vector(1 downto 0);
			 sel: in std_logic;
			 y: out std_logic);
	end component;

	begin
		LEDR <= SW;
		DUT: mux21 port map(SW(1 downto 0),SW(2),LEDG(7));
	end structural;

library ieee;
use ieee.std_logic_1164.all;
entity mux21 is
	port(i: in std_logic_vector(1 downto 0);
		 sel: in std_logic;
		 y: out std_logic
	);
end mux21;

architecture structural of mux21 is
signal x: std_logic_vector(3 downto 0);
component and_gate 
	port(a,b: in std_logic;
		 y:out std_logic );
end component;

component or_gate 
	port(a,b: in std_logic;
		 y:out std_logic );
end component;

component intervert
	port(a: in std_logic;
		 y: out std_logic);
end component;

begin
    -- Implement the 2-to-1 multiplexer logic
    g1: intervert port map(a => sel, y => x(0));
    g2: and_gate port map(a => i(0), b => x(0), y => x(1));
    g3: and_gate port map(a => i(1), b => sel, y => x(2));
    g4: or_gate port map(a => x(1), b => x(2), y => x(3));

    -- Connect z to output y
    y <= x(3);
end structural;

library ieee;
use ieee.std_logic_1164.all;
entity and_gate is
port(	a: in std_logic;
	    b: in std_logic;
	    y: out std_logic
);
end and_gate;
  
architecture dataflow of and_gate is
begin
    y <= a and b;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;
entity or_gate is
port(	a: in std_logic;
	   b: in std_logic;
	   y: out std_logic
);
end or_gate;  
architecture dataflow of or_gate is
begin
    y <= a or b;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;
entity intervert is
port(	a: in std_logic;
	    y: out std_logic
);
end intervert;  
architecture dataflow of intervert is
begin
    y <= not a;
end dataflow;


