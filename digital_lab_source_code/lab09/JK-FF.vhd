library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity JK_FF is
    port (clk, J, K, reset : in std_logic;
    Q   : out std_logic);
    
end JK_FF;

architecture Behavioral of JK_FF is
    
    signal next_state : std_logic := '0';

    begin
        
        Q <= next_state;
        
        JKFF : process(clk, reset) is
        begin
        
            if (reset = '1') then
                next_state <= '0';
            elsif (rising_edge(clk)) then
                if (J = '1' and K = '1') then
                    next_state <= not next_state;
                elsif (J = '1' and K = '0') then
                    next_state <= '1';
                elsif (J = '1' and K = '1') then
                    next_state <= '0';
                end if;
            end if;                
        end process JKFF;
end Behavioral;
