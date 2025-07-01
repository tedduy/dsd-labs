library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex6 is
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex6;

architecture structural of lab4_ex6 is
	component dec24 
		port(en: in std_logic;
			 sel: in std_logic_vector(1 downto 0);
			 d: out std_logic_vector(3 downto 0));
	end component;

	begin
		LEDR <= SW;
		DUT: dec24 port map(SW(2),SW(1 downto 0),LEDG(7 downto 4));
	end structural;

library ieee;
use ieee.std_logic_1164.all;
entity dec24 is
   port(en: in std_logic;
        sel: in std_logic_vector(1 downto 0);
        d: out std_logic_vector(3 downto 0)); 
end dec24;

architecture behavioral of dec24 is
begin
   process(en, sel)
   begin
       if (en = '0') then
           d <= "0000";
       else
           case sel is
               when "00" => d <= "0001";
               when "01" => d <= "0010"; 
               when "10" => d <= "0100";
               when "11" => d <= "1000";
               when others => d <= "0000";
           end case;
       end if;
   end process;
end behavioral;