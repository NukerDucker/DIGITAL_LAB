library IEEE;
use IEEE.std_logic_1164.all;

entity two_bit_adder_tb is
end entity;

architecture tb of two_bit_adder_tb is
  component two_bit_adder
    port (
      A, B: in std_logic_vector(1 downto 0);
      Cin: in std_logic;
      Sum: out std_logic_vector(1 downto 0);
      Cout: out std_logic
    );
  end component;

  signal A, B: std_logic_vector(1 downto 0);
  signal Cin, Cout: std_logic;
  signal Sum: std_logic_vector(1 downto 0);

begin
  uut: two_bit_adder port map(
    A => A,
    B => B,
    Cin => Cin,
    Sum => Sum,
    Cout => Cout
  );

  stim: process
  begin
    A <= "00"; B <= "00"; Cin <= '0'; wait for 20 ns;
    A <= "00"; B <= "01"; Cin <= '0'; wait for 20 ns;
    A <= "01"; B <= "01"; Cin <= '0'; wait for 20 ns;
    A <= "10"; B <= "01"; Cin <= '0'; wait for 20 ns;
    A <= "11"; B <= "01"; Cin <= '0'; wait for 20 ns;
    A <= "11"; B <= "11"; Cin <= '0'; wait for 20 ns;
    A <= "10"; B <= "10"; Cin <= '1'; wait for 20 ns;
    A <= "11"; B <= "11"; Cin <= '1'; wait for 20 ns;
    wait;
  end process;

end tb;
