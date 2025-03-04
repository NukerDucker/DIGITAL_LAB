library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity threebit_sync is
    port (
        clk : in std_logic;  -- W5 as 100 MHz clock
        reset : in std_logic; -- T17 as reset button
        Q : out std_logic_vector(2 downto 0); -- 3-bit counter output
        sseg : out std_logic_vector(6 downto 0);
        sseg_en : out std_logic_vector(3 downto 0)
    );
end threebit_sync;

architecture structural of threebit_sync is
    
    component clk_divider is
        port (
            clk, reset : in std_logic;
            clk_out    : out std_logic
        );
    end component;
    
    component JK_FF is
        port (
            clk, J, K, reset : in std_logic;
            Q                : out std_logic
        );
    end component;
    
    component encoder_sseg is
        port (
            D : in std_logic_vector(3 downto 0); -- 4-bit input for 7-segment
            sseg_sel : in std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0);
            sseg_en : out std_logic_vector(3 downto 0)
        );
    end component;
    
    signal clk_1Hz : std_logic;
    signal Q_int   : std_logic_vector(2 downto 0);
    signal D       : std_logic_vector(3 downto 0); -- 4-bit for 7-segment input
    signal sseg_sel : std_logic_vector(3 downto 0) := "1110";
    signal combined : std_logic;  -- Combined signal for J and K inputs of FF2
    
begin
    
    -- Clock Divider: Generate 1Hz clock signal
    clk_div: clk_divider port map (clk => clk, reset => reset, clk_out => clk_1Hz);
    
    -- Flip-Flop Chain for 3-bit Counter
    FF0: JK_FF port map (clk => clk_1Hz, J => '1', K => '1', reset => reset, Q => Q_int(0));  
    FF1: JK_FF port map (clk => clk_1Hz, J => Q_int(0), K => Q_int(0), reset => reset, Q => Q_int(1));  
    
    -- Combine Q_int(0) and Q_int(1) for FF2 toggling
    combined <= Q_int(0) and Q_int(1);
    
    -- FF2 toggles based on the combined signal
    FF2: JK_FF port map (clk => clk_1Hz, J => combined, K => combined, reset => reset, Q => Q_int(2));  
    
    -- Assign Counter Output
    Q <= Q_int; -- Connect Q to LEDs (LD12, LD11, LD10)
    
    -- Assign Q_int to D for Seven-Segment Display (MSB set to 0)
    D(3) <= '0';  -- Highest bit set to 0 to avoid displaying values beyond 7
    D(2) <= Q_int(2);
    D(1) <= Q_int(1);
    D(0) <= Q_int(0);
    
    -- Send Binary Value to Seven-Segment Encoder
    sseg_dec: encoder_sseg port map (D => D, sseg_sel => sseg_sel, sseg => sseg, sseg_en => sseg_en);
    
end structural;
