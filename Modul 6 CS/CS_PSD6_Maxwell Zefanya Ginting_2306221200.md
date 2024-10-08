# Case Study Modul 6 
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## Tugas 1 (total 80 poin)

Dalam telekomunikasi dan jaringan, checksum merupakan salah satu teknik yang digunakan untuk memastikan integritas data yang dikirim. Umumnya checksum dilakukan dengan melakukan  suatu operasi aritmatika pada bit yang dikirimkan, sehingga dapat dibandingkan dengan flag checksum. Bila hasil pengolahan bit sesuai dengan flag checksum, dapat dipastikan bahwa data yang dikirim valid dan sesuai antara pengirim dan penerima sehingga dapat disimpulkan tidak terdapat gangguan pada data selama pengiriman.

Pada CS kali ini, anda diminta untuk membuat sistem checksum dengan metode parity.
Cara kerja dari checksum parity adalah, menghitung apakah jumlah bit 1 pada data berjumlah ganjil atau genap. Untuk CS ini, checksum bernilai 1 bila jumlah bit 1 pada std logic vector bernilai ganjil dan 0 jumlah bit 1 pada std logic vector bernilai genap.

Buatlah sistem checksum yang menerima input berupa array 3 buah std logic vector berukuran 8 bit, yang akan membandingkannya dengan checksum flag berukuran 3 bit, 1 bit untuk setiap std logic vector dari array. Output dari sistem berupa flag yang bernilai 1 bila terdapat ketidaksesuaian antar checksum flag dan hasil checksum dari ketiga std logic vector array, dan bernilai 0 bila checksum flag dan checksum ketiga std logic vector array sesuai.

Untuk membuat sistem ini, gunakan **while loop** **(WAJIB)** untuk melakukan iterasi setiap elemen dari array dan iterasi setiap elemen std logic vector. Anda dapat menggunakan nested loop atau metode lainnya, namun kode anda **wajib** mengandung minimal 1 buah loop dalam proses checksum.

Contoh 1
---
Input :
Array\[0] : 00000000
Array\[1] : 01010101
Array\[2] : 11100000
Input_Checksum: 101

Output:
Checksum Flag: 1 (Invalid)

Penjelasan: 
Array\[0] memiliki parity genap karena jumlah biner 1 nya adalah 0 (0)
Array\[1] memiliki parity genap karena jumlah biner 1 nya adalah 4 (0)
Array\[2] memiliki parity ganjil karena jumlah biner 1 nya adalah 3 (1)

Sehingga parity dari array adalah 001, sedangkan input checksum adalah 101, sehingga output checksum flag bernilai invalid.

Contoh 2
---
Input :
Array\[0] : 00000011
Array\[1] : 00000010
Array\[2] : 10010010
Input_Checksum: 011

Output:
Checksum Flag: 0 (Valid)

Penjelasan: 
Array\[0] memiliki parity genap karena jumlah biner 1 nya adalah 2 (0)
Array\[1] memiliki parity ganjil karena jumlah biner 1 nya adalah 1 (1)
Array\[2] memiliki parity ganjil karena jumlah biner 1 nya adalah 3 (1)

Sehingga parity dari array adalah 011 dan sesuai dengan input checksum yaitu 011, maka output dari checksum flag adalah 0 (Valid).

---
### Pertanyaan

1. Sertakan kode dan wave diagram dari sistem yang telah dibuat! (60 poin)
```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 

package inputs is
  type inputarray is array(0 to 2) of std_logic_vector(7 downto 0);
end package inputs;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 

use work.inputs.all;

entity checksum is
port (
  input : in inputarray;
  checksum : in std_logic_vector(0 to 2);
  flag : out std_logic
);
end entity;

architecture rtl of checksum is
begin
  process(input, checksum) is
    variable parity : std_logic;
    variable counter : integer;
    variable valid : integer;
    variable i, j : integer;
  begin
    valid := 0;
    i := 0;
    j := 0;
    parity := '1';
    counter := 0;
    while i < 3 loop
      j := 0;
      parity := '1';
      counter := 0;
      report "Counter: "&integer'image(counter);
      report "Valid: "&integer'image(valid);
      report "i: "&integer'image(i);
      while j < 8 loop
        if input(i)(j) = '1' then
          counter := counter + 1;
        end if;
        j := j+1;
      end loop;

      if (counter mod 2) = 0 then
        parity := '0';
      end if;

      if parity = checksum(i) then
        valid := valid + 1;
      end if;

      i := i+1;
      report "Counter: "&integer'image(counter);
      report "Valid: "&integer'image(valid);
    end loop;

    if valid = 3 then
      flag <= '0';
    elsif valid < 3 then
      flag <= '1';
    end if;
  end process;
end architecture;
```
Foto wave:  


2. Dapatkah exit statement digunakan untuk meningkatkan efisiensi sistem? Jika iya, jelaskan pada bagian mana exit statement dapat ditambahkan! (10 poin)
- Exit statement dapat digunakan untuk mengecek bila parity awal dengan checksum awal sudah tidak sesuai, maka bisa langsung keluar. Jadi, bisa ditaruh pada line 
```vhdl
      if parity = checksum(i) then
        valid := valid + 1;
      end if;
```
Menjadi  
```vhdl
      if parity /= checksum(i) then
        flag <= '1';
	  else
	    valid := valid + 1;
      end if;
```
3. Adakah metode lain untuk membuat sistem ini tanpa menggunakan loop? Jika iya, jelaskan secara singkat metode yang dapat digunakan (5 poin)
4. Menurut anda, apakah metode parity checksum merupakan metode yang ampuh untuk mengvalidasi data? adakah kekurangan atau kasus dimana metode ini tidak dapat diandalkan? (5 poin)
- Parity bisa digunakan bila packet yang dikirim ingin menjadi sekecil mungkin. Biasanya parity checksum tidak bisa digunakan saat reliability dari data harus tinggi.
---

## Tugas 2 (15 poin)

Setelah menyelesaikan sistem tersebut, Bos anda yang bernama Gioban meminta anda untuk menerapkan for generate loop dalam sistem. For generate loop dapat digunakan untuk membuat array components, anda dapat melihat penggunaannya pada referensi berikut: 
https://ics.uci.edu/~jmoorkan/vhdlref/generate.html

Dalam CS ini, gunakan for generate loop untuk membuat 3 buah component checksum didalam loop. Ikuti langkah-langkah berikut yang sudah diberikan oleh Gioban:

**NOTE: Untuk memudahkan anda, penilaian tugas 2 hanya mencakup penggunaan for generate loop untuk membuat 3 buah component checksum, anda tidak perlu membuat ulang sistem pada tugas 1. Selama steps dibawah diikuti, anda akan memperoleh nilai maksimal (10 poin)**

- Buatlah component parity checksum, yang berfungsi serupa dengan parity checksum pada tugas 1. Bedanya, component ini hanya digunakan untuk memeriksa 1 buah std logic vector 8 bit. Component akan mengoutput parity flag dengan aturan yang serupa pada tugas 1.
Gioban menyertakan blueprint berikut yang dapat membantu anda.

```vhd
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity parity_check is
    Port (
        data_in : in  std_logic_vector(7 downto 0); -- 8-bit input
        parity_flag : out std_logic                 -- Output parity flag 
    );
end parity_check;

architecture RTL of parity_check is
begin
    process(data_in)
    
    -- masukkan kode parity check anda disini
    
    end process;
end RTL;
```

- Buatlah file VHD baru untuk memuat component ini, anda akan menggunakan port mapping untuk menjalankan component anda.s
Gioban menyertakan blueprint berikut yang dapat membantu anda.

```vhd
	library IEEE;
	use IEEE.STD_LOGIC_1164.ALL;
	use work.checksum_package.all; 
	
	entity checksum_generator is
	    Port (
	        data_in : in  array_3x8; -- 3x8-bit input array
	        parity_flags : out std_logic_vector(2 downto 0) -- parity flag
	    );
	end checksum_system_with_generate;
	
	architecture RTL of checksum_generator is
	
	    --Deklarasi komponen
	    component parity_check is
	        Port (
	            data_in : in std_logic_vector(7 downto 0); 
	            parity_flag : out std_logic -- Parity output 
	        );
	    end component;
	
	begin
	    -- Gunakan for generate loop untuk membuat 3 component parity checker
	    -- Check referensi yang diberikan jika anda bingung -gioban
	end Behavioral;
```

### Pertanyaan
1. Sertakan kode dan hasil running model sim! (10 poin) 
2. Menurut anda, apakah keuntungan penggunaan for generate loop seperti diatas? (5 poin)

## Kesimpulan
###### Berikan kesimpulan praktikum kali ini dalam bentuk poin-poin! (5 poin)
