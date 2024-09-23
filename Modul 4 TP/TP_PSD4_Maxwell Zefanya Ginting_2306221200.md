# Tugas Pendahuluan Modul 4
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

> Note: Saya tidak mewajibkan referensi untuk TP modul ini, kecuali nomor 1 jika disuruh. Namun, kalau tetap ingin melampirkan, ya silahkan.

# Pengenalan Test Bench **(40 poin)**

## 1. Bagaimana cara melakukan simulasi testbench pada ModelSim/Vivado (Pilih salah satu)? Apa saja langkah-langkah yang perlu dilakukan? Jelaskan analisa Anda mengenai hasil simulasi testbench. Silahkan lampirkan screenshot untuk lebih memperjelas jawaban Anda. Kalian juga boleh membuat program baru untuk simulasi testbench, atau menggunakan kode yang sudah ada. Jangan lupa untuk lampirkan referensi jika menggunakan kode yang sudah ada. **(15 poin)**

**Jawaban:**
Untuk melakukan testbench pada ModelSim pada suatu kode yang sudah bisa berjalan, bisa menggunakan kode itu dan mengupasnya menjadi bagian tulangnya saja. Maksudnya, pada bagian kode, hapus seHgala bagian logic yang ada pada kode dan sisakan saja entity-nya saja. Dengan begitu kita kemudian memindahkan entity kedalam architecture dan mengubah jenisnya dari entity menjadi component. Untuk entity sisakan saja deklarasinya dan tanpa isi entitynya. Setelah itu, kita bisa menggunakan port map kepada component yang baru saja dibuat. Terakhir, tuliskan input apa saja ingin di-test kedalam bagian architecture testbenchnya.  

Screenshot cara:
Screenshot contoh hasil testbench:

**REFERENSI:**
- Digital Laboratory FTUI, “Tutorial Praktikum PSD Modul 6: Testbench,” YouTube, https://www.youtube.com/watch?v=3Gld-kKh41o (accessed Sep. 23, 2024). 
- John, “How to write a basic testbench using VHDL,” FPGA Tutorial, https://fpgatutorial.com/how-to-write-a-basic-testbench-using-vhdl/ (accessed Sep. 23, 2024). 


## 2. Coba kunjungi website https://www.edaplayground.com/. Pelajari bagaimana melakukan testbench program VHDL menggunakan platform online tersebut. Lakukan juga simulasi testbench menggunakan platform tersebut, seperti yang kalian lakukan pada nomor 1. **(15 poin)**

**Jawaban:**
Screenshot workspace eda playground:  
Screenshot hasil simulasi:  


## 3. Bandingkan hasil simulasi nomor 1 dan nomor 2. Apa saja kelebihan dan kekurangan dari masing-masing platform yang Anda gunakan. **(10 poin)**

**Jawaban:**
Tidak ada perbedaan besar antara simulasi pada nomor 1 dan nomor 2.  

Kelebihan dari eda playground adalah kita bisa melakukan testbench dengan cepat dan tanpa harus memiliki software simulasi terlebih dahulu. Kekurangannya adalah eda playground berupa free website, sehingga untuk compilation file yang cukup besar akan lebih lama ketimbang memiliki software simulation sendiri.  

# Praktik Test Bench **(60 poin)**

## 4. Buka lagi soal Case Study modul 2 PSD. Buatlah testbench untuk program yang Anda buat dalam CS dan tambahkan juga report statement terkait input dan outputnya. Lampirkan kode Anda disini (kode CS dan kode testbench), dan screenshot hasil simulasi testbench tersebut (Wave Simulation, Report Statement). **(30 poin)**

| Input | Output | Flag |
|-------|--------|------|
| `0000` | `0111` | 1    |
| `0001` | `0110` | 1    |
| `0010` | `0101` | 1    |
| `0011` | `0100` | 1    |
| `0100` | `0011` | 1    |
| `0101` | `0010` | 1    |
| `0110` | `0001` | 1    |
| `0111` | `0000` | 0    |
| `1000` | `0001` | 0    |
| `1001` | `0010` | 0    |
| `1010` | `0011` | 0    |
| `1011` | `0100` | 0    |
| `1100` | `0101` | 0    |
| `1101` | `0110` | 0    |
| `1110` | `0111` | 0    |
| `1111` | `1000` | 0    |

**Jawaban:**
```vhdl!
-- Kode CS (Diperbaiki)
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity SUBTR is
  port (
    -- Input
    inp   : in std_logic_vector(3 downto 0);
    -- Output
    otp   : out std_logic_vector(3 downto 0);
    -- Flag
    flag  : out std_logic
  );
end entity SUBTR;

architecture SUBTR_FOUR of SUBTR is
begin
  process(inp) is
    begin
        case inp is
	    when "0000" =>
		otp <= "0111";
		flag <= '1';
	    when "0001" =>
		otp <= "0110";
		flag <= '1';
	    when "0010" =>
		otp <= "0101";
		flag <= '1';
	    when "0011" =>
		otp <= "0100";
		flag <= '1';
	    when "0100" =>
		otp <= "0011";
		flag <= '1';
	    when "0101" =>
		otp <= "0010";
		flag <= '1';
	    when "0110" =>
		otp <= "0001";
		flag <= '1';
	    when "0111" =>
		otp <= "0000";
		flag <= '0';
	    when "1000" =>
		otp <= "0001";
		flag <= '0';
	    when "1001" =>
		otp <= "0010";
		flag <= '0';
	    when "1010" =>
		otp <= "0011";
		flag <= '0';
	    when "1011" =>
		otp <= "0100";
		flag <= '0';
	    when "1100" =>
		otp <= "0101";
		flag <= '0';
	    when "1101" =>
		otp <= "0110";
		flag <= '0';
	    when "1110" =>
		otp <= "0111";
		flag <= '0';
	    when "1111" =>
		otp <= "1000";
		flag <= '0';
	    when others =>
		otp <= "0000";
		flag <= '0';
	end case;
  end process;
end architecture SUBTR_FOUR;
```

```vhdl!
-- Kode testbench
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity SUBTR_BENCH_ENT IS
end SUBTR_BENCH_ENT;

architecture SUBTR_BENCH_ARC of SUBTR_BENCH_ENT is


component SUBTR is
  port (
    -- Input
    inp   : in std_logic_vector(3 downto 0);
    -- Output
    otp   : out std_logic_vector(3 downto 0);
    -- Flag
    flag  : out std_logic
  );
end component SUBTR;

signal inp   : std_logic_vector(3 downto 0);
signal otp   : std_logic_vector(3 downto 0);
signal flag  : std_logic;

begin
  UUT: SUBTR port map(inp=>inp, otp=>otp, flag=>flag);
  process is
  begin
    
    report "input 0000 output 0111/1" severity note;
    inp <= "0000";
    wait for 10 ps;
    
    report "input 0001 output 0110/1" severity note;
    inp <= "0001";
    wait for 10 ps;
    
    report "input 0010 output 0101/1" severity note;
    inp <= "0010";
    wait for 10 ps;
    
    report "input 0011 output 0100/1" severity note;
    inp <= "0011";
    wait for 10 ps;
    
    report "input 0100 output 0011/1" severity note;
    inp <= "0100";
    wait for 10 ps;
    
    report "input 0101 output 0010/1" severity note;
    inp <= "0101";
    wait for 10 ps;
    
    report "input 0110 output 0001/1" severity note;
    inp <= "0110";
    wait for 10 ps;
    
    report "input 0111 output 0000/0" severity note;
    inp <= "0111";
    wait for 10 ps;
    
    report "input 1000 output 0001/0" severity note;
    inp <= "1000";
    wait for 10 ps;
    
    report "input 1001 output 0010/0" severity note;
    inp <= "1001";
    wait for 10 ps;
    
    report "input 1010 output 0011/0" severity note;
    inp <= "1010";
    wait for 10 ps;
    
    report "input 1011 output 0100/0" severity note;
    inp <= "1011";
    wait for 10 ps;
    
    report "input 1100 output 0101/0" severity note;
    inp <= "1100";
    wait for 10 ps;
    
    report "input 1101 output 0110/0" severity note;
    inp <= "1101";
    wait for 10 ps;
    
    report "input 1110 output 0111/0" severity note;
    inp <= "1110";
    wait for 10 ps;
    
    report "input 1111 output 1000/0" severity note;
    inp <= "1111";
    wait for 10 ps;
    
    report "input 0000 output 0111/1" severity note;
    inp <= "0000";
    wait for 10 ps;

    wait;
  end process;
end architecture SUBTR_BENCH_ARC;
```

## 5. Lanjutan dari nomor 4, pelajari bagaimana melakukan testbench dimana program VHDL dapat menerima input dari file .txt dan menulis output ke file .txt. Kembangkan program Anda dari nomor 4 agar dapat melakukan hal tersebut. Tidak ada format khusus untuk bagaimana read file dan write file. Pastikan Anda lampirkan kode yang sudah dimodifikasi, dan screenshot hasil simulasi testbench (wave, input process, output process). **(30 poin)**

**Jawaban:**

