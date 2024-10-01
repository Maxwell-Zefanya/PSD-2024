# Case Study Modul 5 
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## Deskripsi Tugas
Dalam tugas ini, kalian diminta untuk merancang sebuah **4-bit Arithmetic Logic Unit (ALU)**. ALU ini akan harus bisa melakukan operasi aritmetika dan logika dasar seperti penjumlahan, pengurangan, AND, OR, XOR, dan NOT. Desain ini akan terdiri dari beberapa komponen dasar, dan membutuhkan implementasi **generic mapping** untuk mengatur lebar datanya secara fleksibel.


---
### 1. Entitas Full Adder
Full Adder adalah blok dasar yang digunakan untuk melakukan operasi penjumlahan biner dengan mempertimbangkan carry-in dari penjumlahan sebelumnya.

### Spesifikasi:
- **Port Input:**
  - `A`: bit pertama (1-bit)
  - `B`: bit kedua (1-bit)
  - `Cin`: carry-in (1-bit)
- **Port Output:**
  - `Sum`: hasil penjumlahan (1-bit)
  - `Cout`: carry-out (1-bit)

Tulis entitas dan arsitektur full adder sesuai spesifikasi di atas.

---
```vhdl
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    A, B, Cin : in std_logic := '0';
    S, Cout : out std_logic
  );
end full_adder;

architecture adder of full_adder is
begin
  S <= (A XOR B) XOR Cin;
  Cout <= ((A XOR B) XOR Cin) OR (A AND B);
end adder;
```

### 2. Entitas Multiplexer (MUX) 2-to-1
Multiplexer digunakan untuk memilih salah satu dari dua input berdasarkan select.

### Spesifikasi:
- **Port Input:**
  - `D0`: Data input 0 (1-bit)
  - `D1`: Data input 1 (1-bit)
  - `Sel`: Select (1-bit)
- **Port Output:**
  - `Y`: Output (1-bit)

Tulis entitas dan arsitektur multiplexer 2-to-1 sesuai spesifikasi di atas.

---

## 3. Desain ALU 4-bit
Kalian diminta untuk mendesain ALU 4-bit yang dapat melakukan operasi logika (AND, OR, XOR, NOT) dan operasi aritmetika (ADD, SUB) berdasarkan sinyal kontrol yang diberikan.

### Spesifikasi:
- **Port Input:**
  - `A`: Operand pertama (4-bit)
  - `B`: Operand kedua (4-bit)
  - `Op`: Sinyal operasi (3-bit)
- **Port Output:**
  - `Result`: Hasil operasi (4-bit)
  - `Carry_Out`: Carry-out dari operasi penjumlahan/pengurangan (1-bit)
  - `Zero`: Indikator hasil nol (1-bit)

---
| Op (3-bit) | Operasi  |
|------------|-----------|
| 000        | AND       |
| 001        | OR        |
| 010        | XOR       |
| 011        | NOT A     |
| 100        | ADD       |
| 101        | SUB       |
| 110        | Reserved  |
| 111        | Reserved  |

*Reserved: Tidak dibutuhkan untuk sementara waktu.*

Tulis entitas dan arsitektur ALU 4-bit yang sesuai. Sertakan port mapping untuk menghubungkan full adder, multiplexer, dan gerbang logika lainnya.


---
```vhdl
-- ALU
library ieee;
use ieee.std_logic_1164.all;

entity arith_logic_unit is
  port (
    A, B : in std_logic_vector(3 downto 0);
    op : in std_logic_vector(2 downto 0);
    result : out std_logic_vector(3 downto 0);
    cout, zero : out std_logic
  );
end arith_logic_unit;

architecture arch of arith_logic_unit is

component full_adder is
  port (
    A, B, Cin : in std_logic;
    S, Cout : out std_logic
  );
end component;

component full_subtr is
  port(
    A, B, Bin : in std_logic;
    D, Bout : out std_logic
  );
end component;

signal A_tmp : std_logic_vector(3 downto 0);
signal B_tmp : std_logic_vector(3 downto 0);
signal D_tmp : std_logic_vector(3 downto 0); -- Diff
signal S_tmp : std_logic_vector(3 downto 0); -- Sum
signal cry_tmp : std_logic_vector(2 downto 0); -- Carry internal
signal brw_tmp : std_logic_vector(2 downto 0); -- Borrow internal
signal cin_tmp : std_logic; signal din_tmp : std_logic;
signal cout_tmp : std_logic; signal dout_tmp : std_logic;

begin
  
  -- Full adder
  fa1 : full_adder port map(A_tmp(0), B_tmp(0), cin_tmp, S_tmp(0), cry_tmp(0));
  fa2 : full_adder port map(A_tmp(1), B_tmp(1), cry_tmp(0), S_tmp(1), cry_tmp(1));
  fa3 : full_adder port map(A_tmp(2), B_tmp(2), cry_tmp(1), S_tmp(2), cry_tmp(2));
  fa4 : full_adder port map(A_tmp(3), B_tmp(3), cry_tmp(2), S_tmp(3), cout_tmp);
  
  -- Full subtractor
  fs1 : full_subtr port map(A_tmp(0), B_tmp(0), din_tmp, D_tmp(0), brw_tmp(0));
  fs2 : full_subtr port map(A_tmp(1), B_tmp(1), brw_tmp(0), D_tmp(1), brw_tmp(1));
  fs3 : full_subtr port map(A_tmp(2), B_tmp(2), brw_tmp(1), D_tmp(2), brw_tmp(2));
  fs4 : full_subtr port map(A_tmp(3), B_tmp(3), brw_tmp(2), D_tmp(3), dout_tmp);

  process(op, A, B) is
  begin
    -- Inisialisasi input
    A_tmp <= A;
    B_tmp <= B;
    cin_tmp <= '0';
    din_tmp <= '0';
    case op is
      -- AND
      when "000" =>
        for i in 3 downto 0 loop
          result(i) <= A(i) and B(i);
        end loop;
        cout <= '0';
        zero <= '0';
      -- OR
      when "001" =>
        for i in 3 downto 0 loop
          result(i) <= A(i) or B(i);
        end loop;
        cout <= '0';
        zero <= '0';
      -- XOR
      when "010" =>
        for i in 3 downto 0 loop
          result(i) <= A(i) xor B(i);
        end loop;
        cout <= '0';
        zero <= '0';
      -- NOT A
      when "011" =>
        for i in 3 downto 0 loop
          result(i) <= not A(i);
        end loop;
        cout <= '0';
        zero <= '0';
      -- ADD
      when "100" =>
        result <= S_tmp;
        cout <= cout_tmp;
        zero <= '0';
      -- SUB
      when "101" =>
        if A = B then
          zero <= '1';
          cout <= '0';
          result <= "0000";
        else
          result <= D_tmp;
          cout <= dout_tmp; 
          zero <= '0';
        end if;
      -- Reserved
      when "110" => result <= "0000";
      when "111" => result <= "0000";
      when others =>
    end case;
  end process;
end arch;
```

```vhdl
-- Subtractor
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_subtr is
  port(
    A, B, Bin : in std_logic;
    D, Bout : out std_logic
  );
end entity;

architecture subtr of full_subtr is
begin
  D <= (A xor B) xor Bin;
  Bout <= ((not A) and B) or ((not(A xor B)) and Bin);
end subtr;
```

```vhdl
-- Full adder
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    A, B, Cin : in std_logic;
    S, Cout : out std_logic
  );
end full_adder;

architecture adder of full_adder is
begin
  S <= (A XOR B) XOR Cin;
  Cout <= ((A XOR B) XOR Cin) OR (A AND B);
end adder;
```

### 4. Testbench untuk ALU 4-bit

Tulis testbench untuk menguji fungsionalitas ALU 4-bit. Pastikan untuk menguji semua operasi logika dan aritmetika yang didukung oleh ALU.

---
```vhdl
-- Testbench
library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture arch of testbench is

component arith_logic_unit is
  port (
    A, B : in std_logic_vector(3 downto 0);
    op : in std_logic_vector(2 downto 0);
    result : out std_logic_vector(3 downto 0);
    cout, zero : out std_logic
  );
end component;

signal op_map : std_logic_vector(2 downto 0);
signal A_map : std_logic_vector(3 downto 0);
signal B_map : std_logic_vector(3 downto 0);
signal res_map : std_logic_vector(3 downto 0);
signal cout_map : std_logic;
signal zero_map : std_logic;

begin
  UUT : arith_logic_unit port map(A_map, B_map, op_map, res_map, cout_map, zero_map);
  process is
  begin
    -- AND
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "000";
    wait for 100 ps;
    
    -- OR
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "001";
    wait for 100 ps;
    
    -- XOR
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "010";
    wait for 100 ps;
    
    -- NOT A
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "011";
    wait for 100 ps;
    
    -- ADD
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "100";
    wait for 100 ps;
    
    -- SUB
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "101";
    wait for 100 ps;
    
    -- UNDEFINED
    A_map <= "0110"; -- 7
    B_map <= "0101"; -- 5
    op_map <= "111";
    wait for 100 ps;
    wait;
  end process;
end arch;
```

### 5. Berikan Hasil Simulasi, dan jelaskan dengan terperinci mengenai alur kerja keseluruhan program.

### 6. Tuliskan kesimpulan yang dipelajari dari implementasi ALU ini.
- Penggunaan testbench sangat membantu dalam analisa kesalahan rangkaian
- Penggunaan structural style bisa membantu dalam readibility suatu kode