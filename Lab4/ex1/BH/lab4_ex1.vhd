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
port(   A: in std_logic;
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

architecture behavioral of all_gates is
begin
    process(A, B) 
    begin
            Y_AND <= A and B;
            Y_OR <= A or B;
            Y_NOT_A <= not A;
            Y_NAND <= A nand B;
            Y_NOR <= A nor B;
            Y_XOR <= A xor B;
            Y_XNOR <= A xnor B;
    end process;
end behavioral;
