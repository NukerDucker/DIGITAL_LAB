library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    a, b, cin: in std_logic;
    sum, cout: out std_logic
  );
end full_adder;

architecture structural of full_adder is
  component half_adder
    port (
      a, b: in std_logic;
      sum, carry_out: out std_logic
    );
  end component;

  signal s1, c1, c2: std_logic;

begin
  ha1: half_adder port map(a => a, b => b, sum => s1, carry_out => c1);
  ha2: half_adder port map(a => s1, b => cin, sum => sum, carry_out => c2);
  cout <= c1 or c2;
end structural;