LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Simple module that connects the SW switches to the LEDR lights
ENTITY lab4_ex1 IS
PORT (SW 	: IN  STD_LOGIC_VECTOR(17 DOWNTO 0);
 	LEDR	: OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
 	LEDG  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));  
		  
END lab4_ex1;

ARCHITECTURE Structure OF lab4_ex1 IS
	COMPONENT all_gates
			PORT (A: in std_logic;
					  B: in std_logic;
					  Y_AND: out std_logic;
					  Y_OR: out std_logic;
					  Y_NOT_A: out std_logic;
					  Y_NAND: out std_logic;
					  Y_NOR: out std_logic;
					  Y_XOR: out std_logic;
					  Y_XNOR: out std_logic
				  );
					  
	END COMPONENT;
	
	BEGIN
		LEDR <= SW;
		DUT: all_gates PORT MAP(SW(1),SW(0),LEDG(6),LEDG(5),LEDG(4),LEDG(3),LEDG(2),LEDG(1),LEDG(0));
	END Structure;
	

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity all_gates is
port(	A: in std_logic;
	    B: in std_logic;
	    Y_AND: out std_logic;
		Y_OR: out std_logic;
		Y_NOT_A: out std_logic;
		Y_NAND: out std_logic;
		Y_NOR: out std_logic;
		Y_XOR: out std_logic;
		Y_XNOR: out std_logic
);
end all_gates;

architecture structural of all_gates is
    -- Declare components for each gate
    component AND_GATE
        port (A, B: in std_logic; Y: out std_logic);
    end component;

    component OR_GATE
        port (A, B: in std_logic; Y: out std_logic);
    end component;

    component NOT_GATE
        port (A: in std_logic; Y: out std_logic);
    end component;

    component NAND_GATE
        port (A, B: in std_logic; Y: out std_logic);
    end component;

    component NOR_GATE
        port (A, B: in std_logic; Y: out std_logic);
    end component;

    component XOR_GATE
        port (A, B: in std_logic; Y: out std_logic);
    end component;

    component XNOR_GATE
        port (A, B: in std_logic; Y: out std_logic);
    end component;

begin
    -- Instantiate the components
    u1: AND_GATE port map(A => A, B => B, Y => Y_AND);
    u2: OR_GATE port map(A => A, B => B, Y => Y_OR);
    u3: NOT_GATE port map(A => A, Y => Y_NOT_A);
    u4: NAND_GATE port map(A => A, B => B, Y => Y_NAND);
    u5: NOR_GATE port map(A => A, B => B, Y => Y_NOR);
    u6: XOR_GATE port map(A => A, B => B, Y => Y_XOR);
    u7: XNOR_GATE port map(A => A, B => B, Y => Y_XNOR);

end structural;

-- AND Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity AND_GATE is
    port (A, B: in std_logic;
          Y: out std_logic);
end AND_GATE;

architecture dataflow of AND_GATE is
begin
    Y <= A and B;
end dataflow;

-- OR Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity OR_GATE is
    port (A, B: in std_logic;
          Y: out std_logic);
end OR_GATE;

architecture dataflow of OR_GATE is
begin
    Y <= A or B;
end dataflow;

-- NOT Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOT_GATE is
    port (A: in std_logic;
          Y: out std_logic);
end NOT_GATE;

architecture dataflow of NOT_GATE is
begin
    Y <= not A;
end dataflow;

-- NAND Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NAND_GATE is
    port (A, B: in std_logic;
          Y: out std_logic);
end NAND_GATE;

architecture dataflow of NAND_GATE is
begin
    Y <= A nand B;
end dataflow;

-- NOR Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity NOR_GATE is
    port (A, B: in std_logic;
          Y: out std_logic);
end NOR_GATE;

architecture dataflow of NOR_GATE is
begin
    Y <= A nor B;
end dataflow;

-- XOR Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XOR_GATE is
    port (A, B: in std_logic;
          Y: out std_logic);
end XOR_GATE;

architecture dataflow of XOR_GATE is
begin
    Y <= A xor B;
end dataflow;

-- XNOR Gate Component
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity XNOR_GATE is
    port (A, B: in std_logic;
          Y: out std_logic);
end XNOR_GATE;

architecture dataflow of XNOR_GATE is
begin
    Y <= A xnor B;
end dataflow;