library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity encoder_sseg is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);  -- Fixed input size
           sseg_sel : in STD_LOGIC_VECTOR (3 downto 0);
           sseg : out STD_LOGIC_VECTOR (6 downto 0);
           sseg_en : out STD_LOGIC_VECTOR (3 downto 0));
end encoder_sseg;

architecture Behavioral of encoder_sseg is

signal bin : STD_LOGIC_VECTOR (3 downto 0);

begin
    bin <= D;
    sseg_en <= sseg_sel;
    
    sseg_display : process (bin)
    begin
        case bin is
            when "0000" => sseg <= "0000001"; -- "0"
            when "0001" => sseg <= "1001111"; -- "1"
            when "0010" => sseg <= "0010010"; -- "2"
            when "0011" => sseg <= "0000110"; -- "3"
            when "0100" => sseg <= "1001100"; -- "4"
            when "0101" => sseg <= "0100100"; -- "5"
            when "0110" => sseg <= "0100000"; -- "6"
            when "0111" => sseg <= "0001111"; -- "7"
            when "1000" => sseg <= "0000000"; -- "8"
            when "1001" => sseg <= "0000100"; -- "9"
            when "1010" => sseg <= "0000010"; -- "A"
            when "1011" => sseg <= "1100000"; -- "b"
            when "1100" => sseg <= "0110001"; -- "C"
            when "1101" => sseg <= "1000010"; -- "d"
            when "1110" => sseg <= "0110000"; -- "E"
            when "1111" => sseg <= "0111000"; -- "F"
            when others => sseg <= "1111111"; -- Default case (all segments off)
        end case;
    end process sseg_display;
    
end Behavioral;
