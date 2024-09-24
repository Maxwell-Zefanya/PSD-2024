library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Unknown2 is
    port (
        INPUT: IN STD_LOGIC_VECTOR(7 downto 0);
        OUTPUT: OUT STD_LOGIC_VECTOR(7 downto 0)
    );
end entity Unknown2;

architecture rtl of Unknown2 is
    signal a, b, c, d, e, f, g, h : std_logic;
begin
    a <= INPUT(7);
    b <= INPUT(6);
    c <= INPUT(5);
    d <= INPUT(4);
    e <= INPUT(3);
    f <= INPUT(2);
    g <= INPUT(1);
    h <= INPUT(0);

    OUTPUT(7) <= '0';
    OUTPUT(6) <= '1';
    OUTPUT(5) <= '1';
    OUTPUT(4) <= (not a and b and c and not d and not e and not f and g and h) or (not a and b and c and not d and not e and f and not g) or (not a and b and c and not d and e and not f and not g) or (not a and b and c and not d and e and not f and not h) or (not a and b and c and d and not e and not f and not g) or (not a and b and c and d and not e and f and g) or (not a and b and c and d and not e and not f and not h);
    OUTPUT(3) <= (not a and b and c and not d and not e and not f and not g and h) or (not a and b and c and not d and e and g and h) or (not a and b and c and d and not e and g and not h) or (not a and b and c and d and not e and f and not g) or (not a and b and c and e and not f and not g and not h) or (not a and b and c and not d and e and f and not g);
    OUTPUT(2) <= (not a and b and c and not d and not e and g and not h) or (not a and b and c and d and e and not f and g and not h) or (not a and b and c and not d and not e and not g and h) or (not a and b and c and not e and f and not g and not h) or (not a and b and c and not d and f and not g and h) or (not a and b and c and not d and e and f and g) or (not a and b and c and d and not e and not f and not g);
    OUTPUT(1) <= (not a and b and c and not e and not f and g) or (not a and b and c and not e and f and not g and not h) or (not a and b and c and not d and e and f and not g and h) or (not a and b and c and not d and e and g and not h) or (not a and b and c and d and not e and f and not g) or (not a and b and c and d and e and not f and not g) or (not a and b and c and d and not e and not f and not h);
    OUTPUT(0) <= (not a and b and c and not e and f and not h) or (not a and b and c and not d and f and g) or (not a and b and c and not d and e and not f and h) or (not a and b and c and not d and e and g) or (not a and b and c and d and not e and not f and h) or (not a and b and c and d and e and not f and not g and not h);

end architecture rtl;