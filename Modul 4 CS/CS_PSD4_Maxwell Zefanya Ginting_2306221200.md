# Case Study Modul 4 Pagi
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

# Part 1 - Using Testbench to Debug <span style="color:red">(30 Poin)</span>

## Program VHDL di bawah ini masih susah ditebak kegunaannya. Coba lakukan testbench untuk input ABCD dari "0000" sampai "1111" dan identifikasi apa yang sebenarnya dilakukan oleh program ini? Lampirkan screenshot hasil testbench dan kode testbench kalian! Berikan hasil analisis kalian juga!

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Unknown is
    port (
        A, B, C, D: IN STD_LOGIC;
        CARRY, W, X, Y, Z: OUT STD_LOGIC
    );
end entity Unknown;


architecture rtl of Unknown is
begin
    W <= ((NOT A) AND B AND C) OR ((NOT A) AND B AND D) OR (A AND (NOT C) AND (NOT D)) OR (A AND (NOT B));
    X <= ((NOT B) AND C) OR ((NOT B) AND D) OR (B AND (NOT C) AND (NOT D));
    Y <= NOT (C XOR D);
    Z <= NOT D;
    CARRY <= (A AND B AND C) OR (A AND B AND D);    
    
end architecture rtl;
```


## Jawaban:

### Hasil Simulasi Testbench <span style="color:red">(10 Poin)</span>

![Simulasi Testbench]()

### Kode Testbench <span style="color:red">(10 Poin)</span>
```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Unknowntb is
end entity Unknowntb;


architecture rtl_tb of Unknowntb is

component Unknown is
    port (
        A, B, C, D: IN STD_LOGIC;
        CARRY, W, X, Y, Z: OUT STD_LOGIC
    );
end component Unknown;

signal A, B, C, D: STD_LOGIC;
signal CARRY, W, X, Y, Z: STD_LOGIC;

begin
    UUT: Unknown port map(A=>A, B=>B, C=>C, D=>D, CARRY=>CARRY, W=>W, X=>X, Y=>Y, Z=>Z);
    tb: process
	constant period : time := 10 ps;
	constant a_stream : std_logic_vector(15 downto 0) := "0000000011111111";
	constant b_stream : std_logic_vector(15 downto 0) := "0000111100001111";
	constant c_stream : std_logic_vector(15 downto 0) := "0011001100110011";
	constant d_stream : std_logic_vector(15 downto 0) := "0101010101010101";
    begin
	for i in 0 to 15 loop
	  A <= a_stream(i);
	  B <= b_stream(i);
	  C <= c_stream(i);
	  D <= d_stream(i);
	wait for period;
	end loop;
	wait; 
    end process;
end architecture rtl_tb;
```



### Analisis Kode Awal VHDL <span style="color:red">(10 Poin)</span>

Kode awal VHDL terlihat seperti semacam sebuah adder, karena ada bagian carry. Selain itu, pada carry juga bisa dilihat bahwa carry akan aktif pada saat input berupa "111x" atau "11x1", atau aktif pada saat input berupa "1101", "1110", atau "1111".

# Part 2 - Using Testbench to Encode <span style="color:red">(70 Poin)</span>

## Program di bawah ini dapat digunakan untuk meng-encode sebuah karakter ASCII dengan menggunakan tabel pemetakan. **Misalkan** terdapat tabel pemetakan ASCII sebagai berikut:

Original ASCII   (Example)| Encoded ASCII (Example)
---------------|----------------
A              | Z
B              | Y
C              | X

## maka, string `ABACA` dapat di-encode menjadi string `ZYZXZ`. Namun, perlu tabel pemetakan ASCII untuk program di bawah ini **belum diketahui**. Bisakah kamu menemukan tabel pemetakan ASCII, dan men-**encode** beberapa String dengan memanfaatkan testbench?

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Unknown is
    port (
        INPUT: IN STD_LOGIC_VECTOR(7 downto 0);
        OUTPUT: OUT STD_LOGIC_VECTOR(7 downto 0)
    );
end entity Unknown;

architecture rtl of Unknown is
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
```
## Jawaban:

### Hasil Simulasi Testbench Input `a -> z` <span style="color:red">(10 Poin)</span>

![Simulasi Testbench]()

### Kode Testbench VHDL <span style="color:red">(30 Poin)</span>

```vhdl

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
    UUT: Unknown2 port map(INPUT=>INPUT, OUTPUT=>OUTPUT);
    tb2 : process
        constant period : time := 10 ps;
    begin
	for i in 97 to 122 loop
	    INPUT <= STD_LOGIC_VECTOR(TO_UNSIGNED(i, 8));
	    wait for period;
	end loop;
	wait;
    end process;
end architecture rtl2_tb;
```

### Tabel Pemetakan Ascii <span style="color:red">(10 Poin)</span>

Original ASCII | Encoded ASCII
---------------|----------------
a              | l
b              | f
c              | r
d              | w
e              | t
f              | e
g              | a
h              | x
i              | q
j              | s
k              | i
l              | h
m              | n
n              | q
o              | m
p              | v
q              | u
r              | z
s              | c
t              | o
u              | j
v              | y
w              | p
x              | k
y              | b
z              | d

### Simulasikan program awal untuk men-encode String berikut! (Boleh dengan testbench atau simulasi manual) <span style="color:red">(20 Poin)</span>

PlainText    | Encoded Text | Simulasi Encoding
-------------|--------------|-------------------
sigma        | cqanl        | ![Simulasi Encoding]()
skibidi      | ciqfqwq      | ![Simulasi Encoding]()
mewing       |              | ![Simulasi Encoding]()
rizzler      |              | ![Simulasi Encoding]()
mogged       |              | ![Simulasi Encoding]()   
