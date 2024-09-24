library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Unknown2tb is
end entity Unknown2tb;

architecture rtl2_tb of Unknown2tb is

component Unknown2 is
    port (
        INPUT: IN STD_LOGIC_VECTOR(7 downto 0);
        OUTPUT: OUT STD_LOGIC_VECTOR(7 downto 0)
    );
end component Unknown2;

signal INPUT: STD_LOGIC_VECTOR(7 downto 0);
signal OUTPUT: STD_LOGIC_VECTOR(7 downto 0);

begin
    UUT: Unknown2 port map(INPUT, OUTPUT);
    tb2 : process
        constant period : time := 100 ps;
    begin
	    INPUT <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8));
	wait;
    end process;
end architecture rtl2_tb;