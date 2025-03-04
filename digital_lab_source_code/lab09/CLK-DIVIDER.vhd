library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity clk_divider is 
    port ( clk, reset : in std_logic;
           clk_out  : out std_logic);

end clk_divider;

architecture behavioral of clk_divider is
    
    signal count : integer := 0;
    signal tmp   : std_logic := '0';
    
    begin
        clk_out <= tmp;
        
        process(clk,reset)
            begin
                if (reset = '1') then
                    count <= 0;
                    tmp <= '0';
                elsif (rising_edge(clk)) then
                    count <= count + 1;
                    if (count > (50000000 - 1)) then
                        count <= 0;
                        tmp <= not tmp;
                    end if;
                end if;
       end process;
       
   
end behavioral;