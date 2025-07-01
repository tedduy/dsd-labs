library ieee;
use ieee.std_logic_1164.all;

entity lab4_ex3 is
    port (
        SW   : in  std_logic_vector(15 downto 0);
        LEDR : out std_logic_vector(15 downto 0);
        LEDG : out std_logic_vector(7 downto 0)
    );
end lab4_ex3;

architecture structural of lab4_ex3 is
    component full_adder is
        port (
            a, b, cin : in  std_logic; 
            sum, carry : out std_logic
        );
    end component;

begin
    LEDR <= SW;
    DUT: full_adder port map (SW(2), SW(1), SW(0), LEDG(1), LEDG(0));
end structural;

library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port (
        a, b, cin : in  std_logic;
        sum, carry : out std_logic
    );
end full_adder;

architecture dataflow of full_adder is
begin
     sum <= (a xor b) xor cin;
     carry <= (a and b) or ((a xor b) and cin);
end dataflow;
