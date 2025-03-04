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
            D : in std_logic_vector(3 downto 0);
            sseg_sel : in std_logic_vector(3 downto 0);
            sseg : out std_logic_vector(6 downto 0);
            sseg_en : out std_logic_vector(3 downto 0)
        );
    end component;

    signal clk_1Hz : std_logic;
    signal Q_int   : std_logic_vector(2 downto 0);
    signal D       : std_logic_vector(3 downto 0);
    signal sseg_sel : std_logic_vector(3 downto 0) := "1110";
    signal reset_counter : std_logic;

begin

    -- Clock Divider
    clk_div: clk_divider port map (clk => clk, reset => reset, clk_out => clk_1Hz);

    -- Detect when count reaches 6 (110)
    reset_counter <= '1' when Q_int = "110" else '0';

    -- JK Flip-Flop Counter
    FF0: JK_FF port map (clk => clk_1Hz, J => '1', K => '1', reset => reset or reset_counter, Q => Q_int(0));
    FF1: JK_FF port map (clk => clk_1Hz, J => Q_int(0), K => Q_int(0), reset => reset or reset_counter, Q => Q_int(1));
    FF2: JK_FF port map (clk => clk_1Hz, J => Q_int(1), K => Q_int(1), reset => reset or reset_counter, Q => Q_int(2));

    -- Assign Counter Output
    Q <= Q_int; 

    -- Assign Q_int to D for Seven-Segment Display
    D(3) <= '0';  
    D(2) <= Q_int(2);
    D(1) <= Q_int(1);
    D(0) <= Q_int(0);

    -- 7-Segment Display Encoder
    sseg_dec: encoder_sseg port map (D => D, sseg_sel => sseg_sel, sseg => sseg, sseg_en => sseg_en);

end structural;