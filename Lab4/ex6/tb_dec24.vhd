library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all; -- For converting std_logic and std_logic_vector to string

entity tb_dec24 is
-- No ports for a testbench
end tb_dec24;

architecture behavior of tb_dec24 is

    -- Component declaration for the Unit Under Test (UUT)
    component dec24
        port (
            en  : in  std_logic;
            sel : in  std_logic_vector(1 downto 0);
            d   : out std_logic_vector(3 downto 0)
        );
    end component;

    -- Signals to connect to UUT
    signal en  : std_logic := '0';
    signal sel : std_logic_vector(1 downto 0) := (others => '0');
    signal d   : std_logic_vector(3 downto 0);

    -- Function to convert std_logic_vector to string
    function to_string(slv : std_logic_vector) return string is
        variable result : string(1 to slv'length);
    begin
        for i in slv'range loop
            result(i - slv'low + 1) := character'VALUE(std_ulogic'image(slv(i)));
        end loop;
        return result;
    end function;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: dec24
        port map (
            en  => en,
            sel => sel,
            d   => d
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Test case 1: en = '0', sel = "00"
        en <= '0';
        sel <= "00";
        wait for 10 ns;
        report "Test case 1: en = " & std_ulogic'image(en) & ", sel = " & to_string(sel) & ", d = " & to_string(d);

        -- Test case 2: en = '1', sel = "00"
        en <= '1';
        sel <= "00";
        wait for 10 ns;
        report "Test case 2: en = " & std_ulogic'image(en) & ", sel = " & to_string(sel) & ", d = " & to_string(d);

        -- Test case 3: en = '1', sel = "01"
        sel <= "01";
        wait for 10 ns;
        report "Test case 3: en = " & std_ulogic'image(en) & ", sel = " & to_string(sel) & ", d = " & to_string(d);

        -- Test case 4: en = '1', sel = "10"
        sel <= "10";
        wait for 10 ns;
        report "Test case 4: en = " & std_ulogic'image(en) & ", sel = " & to_string(sel) & ", d = " & to_string(d);

        -- Test case 5: en = '1', sel = "11"
        sel <= "11";
        wait for 10 ns;
        report "Test case 5: en = " & std_ulogic'image(en) & ", sel = " & to_string(sel) & ", d = " & to_string(d);

        -- End simulation
        wait;
    end process;

end behavior;
