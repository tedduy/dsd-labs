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

architecture structural of half_adder is
	component and_gate
		port(a,b: in std_logic; y: out std_logic);
	end component;
	
	component xor_gate 
		port(a,b: in std_logic; y: out std_logic);
	end component;

	begin
		u1: and_gate port map(a => a,b=>b,y=>c);
		u2: xor_gate port map(a =>a,b=>b,y=>s);
	end structural;
	
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_gate is
    port (a, b: in std_logic;
          y: out std_logic);
end and_gate;

architecture dataflow of and_gate is
begin
    y <= a and b;
end dataflow;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_gate is
    port (a, b: in std_logic;
          y: out std_logic);
end xor_gate;

architecture dataflow of xor_gate is
begin
    y <= a xor b;
end dataflow;
