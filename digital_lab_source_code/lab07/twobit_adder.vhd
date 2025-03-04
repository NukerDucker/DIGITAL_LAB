library IEEE;
use IEEE.std_logic_1164.all;

-- Two-bit Adder using Structural approach with Full Adders
entity two_bit_adder is
  port (
    A, B: in std_logic_vector(1 downto 0);
    Cin: in std_logic;
    Sum: out std_logic_vector(1 downto 0);
    Cout: out std_logic
  );
end two_bit_adder;

architecture structural of two_bit_adder is
  component full_adder
    port (
      a, b, cin: in std_logic;
      sum, cout: out std_logic
    );
  end component;

  signal c_internal: std_logic;

begin
  fa1: full_adder port map(
    a => A(0),
    b => B(0),
    cin => Cin,
    sum => Sum(0),
    cout => c_internal
  );
  
  fa2: full_adder port map(
    a => A(1),
    b => B(1),
    cin => c_internal,
    sum => Sum(1),
    cout => Cout
  );

end structural;
