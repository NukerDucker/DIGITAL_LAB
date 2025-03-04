LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY encoder_sseg_tb IS
END encoder_sseg_tb;

ARCHITECTURE behavior OF encoder_sseg_tb IS

    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT encoder_sseg
    PORT(
        D : IN  std_logic_vector(7 downto 0);
        sseg_sel : IN  std_logic_vector(3 downto 0);
        sseg : OUT  std_logic_vector(6 downto 0);
        sseg_en : OUT  std_logic_vector(3 downto 0)
    );
    END COMPONENT;
    
    -- Signals
    SIGNAL D : std_logic_vector(7 downto 0) := (others => '0');
    SIGNAL sseg_sel : std_logic_vector(3 downto 0) := "0000";
    SIGNAL sseg : std_logic_vector(6 downto 0);
    SIGNAL sseg_en : std_logic_vector(3 downto 0);
    
BEGIN
    -- Instantiate the Unit Under Test (UUT)
    uut: encoder_sseg PORT MAP (
        D => D,
        sseg_sel => sseg_sel,
        sseg => sseg,
        sseg_en => sseg_en
    );
    
    -- Stimulus process
    stim_proc: PROCESS
    BEGIN    
        -- Apply test vectors
        D <= "00000001";  -- Expect segment output for 1
        sseg_sel <= "0001";
        WAIT FOR 10 ns;
        
        D <= "00000010";  -- Expect segment output for 2
        sseg_sel <= "0010";
        WAIT FOR 10 ns;
        
        D <= "00000100";  -- Expect segment output for 4
        sseg_sel <= "0011";
        WAIT FOR 10 ns;
        
        D <= "00001000";  -- Expect segment output for 8
        sseg_sel <= "0100";
        WAIT FOR 10 ns;
        
        D <= "00010000";  -- Expect segment output for 10 (A)
        sseg_sel <= "0101";
        WAIT FOR 10 ns;
        
        D <= "00100000";  -- Expect segment output for 20 (not valid, should decode to closest possible)
        sseg_sel <= "0110";
        WAIT FOR 10 ns;
        
        D <= "01000000";  -- Expect segment output for 40 (not valid, similar case)
        sseg_sel <= "0111";
        WAIT FOR 10 ns;
        
        D <= "10000000";  -- Expect segment output for 80
        sseg_sel <= "1000";
        WAIT FOR 10 ns;
        
        -- Intentional error injection
        ASSERT false REPORT "Intentional error for test validation" SEVERITY ERROR;
        
        -- Finish test
        WAIT;
    END PROCESS;

END behavior;