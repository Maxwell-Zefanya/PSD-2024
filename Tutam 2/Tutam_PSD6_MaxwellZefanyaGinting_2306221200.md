Tugas Tambahan 6
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

References:
- https://surf-vhdl.com/read-from-file-in-vhdl-using-textio-library/
- https://surf-vhdl.com/write-to-file-in-vhdl-using-textio-library/
- https://community.element14.com/members-area/personalblogs/b/blog/posts/vhdl-text-io-essentials
- https://vhdlwhiz.com/stimulus-file/

## Teori (Total Poin: 40)

Operasi file I/O akan dilakukan menggunakan library TextIO.
### 1. Jelaskan bagaimana cara kerja objek **file** dalam VHDL! Sertakan dan jelaskan syntax dari deklarasi objek tersebut (10 poin)

Objek file adalah sebuah tipe data yang menyimpan pointer ke sebuah file, mirip seperti pada C. Mirip seperti pada C juga, objek file digunakan untuk melakukan aksi I/O kepada sebuah file. Mirip juga seperti pada C, kita perlu menspesifikasikan nama file (sekalian extensionnya) yang ingin dibaca. File sendiri dapat dideklarasikan pada VHDL dengan menggunakan syntax:  
```
-- Deklarasi objek file
file <file_name>    : text open <write/read>_mode is "<filename>";
file fileName : text open write_mode is "fileName.txt";

-- Pemanggilan file
readline(fileName, <line variable>);
writeline(fileName, <line variable>);
```

### 2. Read data dari text file dilakukan dengan row dan column, jelaskan command yang digunakan untuk melakukan line read dan character read (10 poin)

Setelah sebuah file dideklarasikan, maka objek file tersebut bisa digunakan untuk membaca konten yang ada pada sebuah file. File yang dibaca akan disimpan kedalam sebuah variabel yang bertipe `line`. Setelah file dibaca dan dimasukkan kedalam `line`, maka selanjutnya isi dari `line` tersebut bisa dimasukkan kedalam variabel yang diinginkan, seperti integer, bit, character, dsb. (semua jenis std_logic tidak bisa digunakan).  
Contoh:  
```
-- Deklarasi
file fileName : text open read_mode is "fileName.txt";
variable inputs : line;
variable counter : integer;

-- Read dari file kedalam line
readline(fileName, inputs);
read(inputs, counter);
```

Pada VHDL juga diperkenankan bagi sebuah line untuk menyimpan beberapa jenis data type yang sama. Supaya bisa membaca kolom yang berbeda, maka perlu dilakukan read sebanyak jumlah kolom yang ingin dicapai  

Contoh:  
```
-- Deklarasi
file fileName : text open read_mode is "fileName.txt";
variable inputs : line; -- inputs memiliki 2 integer per line
variable inA : integer;
variable inB : integer;

-- Read dari file kedalam line
readline(fileName, inputs);
read(inputs, inA); -- Read integer pertama (kolom pertama)
read(inputs, inB); -- Read integer kedua (kolom kedua)
```

### 3. Jelaskan command yang digunakan untuk melakukan write line dan write, apa perbedaan antara kedua command tersebut? (10 poin)

Sama seperti pada kasus read, untuk write kedalam file, maka dilakukan hal yang mirip. Perbedaannya adalah untuk write digunakan keyword `write` dan `writeline`  
Contohnya:  
```
-- Deklarasi
file fileName : text open write_mode is "fileName.txt";
variable outputs : line; -- outputs memiliki 2 integer per line
variable outA : integer;
variable outB : integer;

-- Write dulu dari line baru kedalam file
write(outputs, outA); -- Write integer pertama kedalam kolom pertama line
write(outputs, outB); -- Write integer kedua (kolom kedua)
writeline(fileName, outputs);
```

### 4. Jelaskan cara menentukan akhir file berdasarkan library TextIO (5 poin)

Pada VHDL, end dari sebuah file yang ingin dibaca bisa dilakukan dengan menggunakan function `endfile(<file>)` untuk menentukan apakah pointer sudah berada pada akhir file. Secara lebih spesifik, bila kita ingin proses keluar saat sudah berada diakhir file, maka bisa dilakukan dengan menggunakan keyword seperti `    ...`  

### 5. Apakah program yang dibuat menggunakan TextIO bersifat synthesizable? Jika tidak, dalam kasus apa TextIO memiliki kegunaan secara praktikal? (5 poin)

Tidak, namun I/O file tetap digunakan pada saat kasus testbenchnya kompleks dan akan membutuhkan input banyak, dan/atau akan mengeluarkan banyak output.

## Practice (Total Poin: 15)

### Buatlah sebuah program dalam VHDL yang menghitung jumlah line dari suatu text file, lalu menuliskan outputnya dalam file text berbeda.

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use STD.textio.all;

entity toplevel is
  port (
    otp : out std_logic_vector(15 downto 0)
  );
end entity toplevel;

architecture rtl of toplevel is
begin
  process is
    variable ctr : integer := 0;
    file fp : text open read_mode is "toplevel.txt";
    file fp2 : text open write_mode is "tloutput.txt";
    variable inp : line;
    variable wot : line;
  begin
    while not endfile(fp) loop
      -- Selama tidak EOF, tambah terus counternya dan pindah pointer ke nextline
      readline(fp, inp);
      ctr := ctr + 1;
    end loop;
    -- Masukkan hasil counter kedalam line dan tulis line ke file output
    write(wot, ctr);
    writeline(fp2, wot);
    otp <= std_logic_vector(to_unsigned(ctr, 16));
    wait;
  end process;
end architecture rtl;
```

## Application (Total Poin: 45)
### Pilihlah salah satu Case study dengan testbench yang pernah anda buat, lalu automasikan proses testbench menggunakan textIO sehingga testbench menggunakan input yang berasal dari textfile.

#### 1. Sertakan kode CS dan testbench yang anda gunakan, berikan screenshot output waveform dari testbench! (30 poin)

```vhdl
-- Kode CS
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

architecture SUBTR_SEVEN of SUBTR is
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
end architecture;
```

```vhdl
-- Kode TB
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use STD.textio.all;


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
    variable var1 : integer := 0;
    file fp : text open read_mode is "input.txt";
    file fp2 : text open write_mode is "output.txt";
    variable inpl : line;
    variable wotl : line;
    function to_integer( s : std_logic ) return natural is
      begin
          if s = '1' then
          return 1;
        else
          return 0;
        end if;
      end function;
  begin
    while not endfile(fp) loop
      -- Input pada file berupa integer
      readline(fp, inpl);
      read(inpl, var1);
      inp <= std_logic_vector(to_signed(var1, 4));
      -- Output pada file berupa integer
      write(wotl, to_integer(signed(otp)));
      write(wotl, to_integer(flag), right, 7);
      report "input "&integer'image(to_integer(signed(inp)))&" output "&integer'image(to_integer(signed(otp)))&"/"&std_logic'image(flag);
      writeline(fp2, wotl);
      wait for 10 ps;
    end loop;
    wait;
  end process;
end architecture;

```  

Foto waveform:  
![Waveform](https://github.com/user-attachments/assets/cc13fead-6fd3-40bc-a38f-59ff0d141ec6)  

Foto file input:  
![Input File](https://github.com/user-attachments/assets/08d7a075-33e6-4c71-9208-9483d240d0df)  

Foto file output:  
![image](https://github.com/user-attachments/assets/b17c75b3-60ff-4ca3-8d5d-835e5e454e1b)  


#### 2. Jelaskan dan analisa cara kerja dari testbench yang telah anda buat (10 poin)
Testbench dibangun seperti testbench biasa, dengan port-map dan component-component. Namun, perbedaannya adalah input diambil dari sebuah file (yang berupa integer). Kemudian, output akan diteruskan kedalam sebuah file juga (dalam bentuk integer). 

#### 3. Menurut anda, apakah manfaat penggunaan text file dalam kasus ini? (5 poin)
Pada VHDL, I/O bisa digunakan pada testbench saat file yang dicari sangat banyak. Oleh karena itu, daripada menuliskan kondisi satu-per satu secara hardcode, kita dapat menuliskan inputnya kedalam sebuah file dan membaca inputnya dengan mudah pada file yang lain.
