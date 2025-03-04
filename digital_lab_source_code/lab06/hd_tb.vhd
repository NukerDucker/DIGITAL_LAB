library IEEE;
use IEEE.std_logic_1164.all;

entity half_adder_tb is
end entity;

architecture tb of half_adder_tb is
  component half_adder is
    port(
      a, b: in std_logic;
      sum, carry_out: out std_logic
    );
  end component;

  signal a, b, sum, carry: std_logic;

begin

  uut: half_adder port map(
    a => a, 
    b => b,
    sum => sum,
    carry_out => carry
  );

  stim: process
  begin
    a <= '0'; b <= '0';
    wait for 20 ns;

    a <= '0'; b <= '1';
    wait for 20 ns;

    a <= '1'; b <= '0';
    wait for 20 ns;

    a <= '1'; b <= '1';
    wait for 20 ns;

    wait;
  end process;

end tb;
