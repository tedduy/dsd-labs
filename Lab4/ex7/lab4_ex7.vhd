library ieee;
use ieee.std_logic_1164.all;
entity lab4_ex7 is
	port (SW 	: in std_logic_vector(17 downto 0);
		LEDR	: out std_logic_vector(17 downto 0);
		LEDG  : out std_logic_vector(7 downto 0));  
end lab4_ex7;

architecture structural of lab4_ex7 is
	component enc83 
		port(en: in std_logic;
			 d: in std_logic_vector(7 downto 0);
			 y: out std_logic_vector(2 downto 0));
	end component;

	begin
		LEDR <= SW;
		DUT: enc83 port map(SW(8),SW(7 downto 0),LEDG(7 downto 5));
	end structural;

library ieee;
use ieee.std_logic_1164.all;
entity enc83 is
	port(en: in std_logic;
		 d: in std_logic_vector(7 downto 0);
		 y: out std_logic_vector(2 downto 0));
end enc83;


architecture behavioral of enc83 is
begin
   process(en, d)
   begin
       if (en = '0') then
           y <= "000";
       else
           case d is
				when "00000001" => y <= "000";
				when "00000011" => y <= "001";
				when "00000111" => y <= "010";
				when "00001111" => y <= "011";
				when "00011111" => y <= "100";
				when "00111111" => y <= "101";
				when "01111111" => y <= "110";
				when "11111111" => y <= "111";
				when others => y <= "000";
			end case;
       end if;
   end process;
end behavioral;

