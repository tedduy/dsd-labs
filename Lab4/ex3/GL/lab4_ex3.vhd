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

architecture structural of full_adder is
    signal x, y, z : std_logic;

    component and_gate
        port (a, b : in  std_logic; y : out std_logic);
    end component;

    component or_gate
        port (a, b : in  std_logic; y : out std_logic);
    end component;

    component xor_gate
        port (a, b : in  std_logic; y : out std_logic);
    end component;

begin
    x1: xor_gate port map (a => a, b => b, y => x);
    x2: xor_gate port map (a => x, b => cin, y => sum);
    a1: and_gate port map (a => x, b => cin, y => y);
    a2: and_gate port map (a => a, b => b, y => z);
    a3: or_gate port map (a => y, b => z, y => carry);
end structural;

library ieee;
use ieee.std_logic_1164.all;

entity and_gate is
    port (a, b : in  std_logic; y : out std_logic);
end and_gate;

architecture dataflow of and_gate is
begin
    y <= a and b;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;

entity or_gate is
    port (a, b : in  std_logic; y : out std_logic);
end or_gate;

architecture dataflow of or_gate is
begin
    y <= a or b;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;

entity xor_gate is
    port (a, b : in  std_logic; y : out std_logic);
end xor_gate;

architecture dataflow of xor_gate is
begin
    y <= a xor b;
end dataflow;
