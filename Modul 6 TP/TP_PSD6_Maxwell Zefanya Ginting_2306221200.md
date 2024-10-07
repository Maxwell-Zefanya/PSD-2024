# Tugas Pendahuluan Modul 6
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## Teori (50 points)
### 1. Jelaskan jenis-jenis looping construct yang ada di VHDL, sertakan perbedaan dari masing-masing jenis looping construct tersebut! (10 poin)
Pada VHDL, terdapat 2 construct yang sering digunakan untuk looping, yaitu for-loop dan while-loop. For-loop pada VHDL mirip dengan looping pada Python, dimana for-loop mengambil variabel integer dan melakukan looping pada range yang ditentukan. While-loop pada VHDL juga mirip dengan while-loop pada bahasa programming seperti biasanya, dimana while-loop akan keluar loop saat conditional statementnya dievaluasi sebagai false.  

Secara lebih spesifik, pada VHDL for-loop dilakukan dengan syntax `for i in a to/downto b loop`, dimana "i" adalah variabel integer yang diambil dan bisa digunakan dalam loop, sedangkan a dan b adalah range dari loop. Pada VHDL, perbedaan antara increment dan decrement dari conditional for loop diatur dengan keywrod to/downto, dimana to berarti variabel akan increment tiap loop, dan downto adalah kebalikannya. Sebuah VHDL for-loop juga harus diakhiri dengan statement `end loop;`  

Berbeda dengan for-loop, while-loop dilakukan dengan syntax `while conditional loop`, dimana conditional adalah statement yang dievaluasi tiap awal loop. Pada while-loop, statement tidak diubah/increment/decrement secara automatis, sehingga harus mengubah value conditionalnya secara manual.  

**Referensi:**
- J. J. Jensen, “How to use a for loop in VHDL,” VHDLwhiz, https://vhdlwhiz.com/for-loop/ (accessed Oct. 6, 2024).
- J. J. Jensen, “How to use a while loop in VHDL,” VHDLwhiz, https://vhdlwhiz.com/while-loop/ (accessed Oct. 6, 2024).


### 2. Apakah perbedaan dari penggunaan looping construct dan wait statement dalam VHDL? Adakah kasus dimana keduanya dapat memecahkan masalah yang sama? (10)
Perbedaan terbesar antara keduanya adalah wait statement bisa menggunakan waktu sebagai salah satu statementnya. Untuk wait statement yang menggunakan conditional mirip dengan looping construct, maka block kode pada wait statement tidak akan berjalan sampai kondisi tersebut dievaluasi true. Hal ini berbeda dengan sebuah looping construct dimana bila statement dievaluasi false pada awalnya maka block kode akan di-skip seluruhnya.  

Sebenarnya wait until bisa diganti dengan statement for yang ekuivalen seperti berikut
```vhdl
wait until clk = '1';
-- Ekuivalen dengan
loop
  wait on clk;
  exit when clk = '1';
end loop;
```
Tetapi secara praktis, lebih baik menggunakan statement wait untuk menunggu terjadinya kondisi spesifik dan loop constructs untuk looping sebuah kode sampai tercapainya kondisi spesifik.

**Referensi:**
- J. J. Jensen, “How to use a for loop in VHDL,” VHDLwhiz, https://vhdlwhiz.com/for-loop/ (accessed Oct. 6, 2024).
- J. J. Jensen, “How to use a while loop in VHDL,” VHDLwhiz, https://vhdlwhiz.com/while-loop/ (accessed Oct. 6, 2024). 
- R. Merrick, “VHDL Example – Wait Statement,” NAND Land, https://nandland.com/wait-statement-wait-until-wait-on-wait-for/ (accessed Oct. 6, 2024). 
- Russel et al., “Wait until `<signal>=1` never true in VHDL simulation,” StackOverflow, https://stackoverflow.com/questions/20481778/wait-until-signal-1-never-true-in-vhdl-simulation (accessed Oct. 6, 2024). 

### 3. Sebutkan dan jelaskan relational dan logical Operators yang dapat digunakan sebagai conditional dalam while loop! (10 poin)
Relational dan logical operator pada VHDL digunakan masing-masing untuk mengecek relasi kedua value dan melakukan operasi boolean pada suatu value. Logical operator terdiri atas berbagai keyword yang ada pada boolean arithmetic, yaitu `and`, `or`, `nand`, `nor`, `xor`, dan `xnor`. Relational operator terdiri dari berbagai keyword yang biasanya ada sebagai simbol relasi matematis, seperti:  

- `=` membandingkan apakah kedua value sama
- `/=` membandingkan apakah kedua value berbeda
- `<` membandingkan apakah value kiri lebih kecil dari value kanan
- `<=` membandingkan apakah value kiri lebih kecil sama dengan dari value kanan
- `>` membandingkan apakah value kiri lebih besar dari value kanan
- `>=` membandingkan apakah value kiri lebih besar sama dengan dari value kanan

Terlebih dari itu, relational <= berbeda dengan assignment <=, dimana relational <= dipakai pada statement yang menerima conditional statement.  

Pada while loop, relational dan logical operator bisa dipakai dan digabung untuk mengecek suatu conditional. Contohnya `while A = (B xor C) loop` dimana loop akan terus berjalan selama A sama dengan B xor C.  

**Referensi:**
- R. Merrick, “Assignment Symbol in VHDL,” NAND Land, https://nandland.com/assignment-symbol/ (accessed Oct. 6, 2024). 
- R. Merrick, “Relational Operators – VHDL Example,” NAND Land, https://nandland.com/relational-operators/ (accessed Oct. 6, 2024). 
- R. Merrick, “Logical Operators – VHDL Example,” NAND Land, https://nandland.com/logical-operators/ (accessed Oct. 6, 2024). 
- Chemnitz University of Technology, “Operators,” VHDL-Online, https://www.vhdl-online.de/courses/system_design/vhdl_language_and_syntax/operators (accessed Oct. 6, 2024). 

### 4. Apakah kegunaan dari next dan exit statement dalam suatu loop? (10 poin)
Next statement mirip dengan keyword `continue;` pada C, dimana block kode dibawah loop tidak akan dijalankan, melainkan loop akan kembali ke awal (setelah dievaluasi lagi pada awal loop). Exit statement pada vhdl mirip dengan keyword `exit;` pada C, dimana proses akan keluar dari loop seluruhnya, tanpa mengecek apakah conditional loop terpenuhi.  

Perbedaan dari next dan exit pada VHDL dengan contoh di C adalah kedua statement ini juga bisa menerima conditional secara langsung. Misalkan `next when conditional;` atau `exit when conditional;`

**Referensi:**
- HDL Works, “Next,” HDL Works, https://www.hdlworks.com/hdl_corner/vhdl_ref/VHDLContents/NextStatement.htm (accessed Oct. 6, 2024). 
- HDL Works, “Exit,” HDL Works, https://www.hdlworks.com/hdl_corner/vhdl_ref/VHDLContents/ExitStatement.htm (accessed Oct. 6, 2024). 
- J. J. Jensen, “How to use a for loop and exit in VHDL,” VHDLwhiz, https://vhdlwhiz.com/loop-and-exit/ (accessed Oct. 6, 2024).
- P. Fab, “Next Statement,” peterfab.com, https://peterfab.com/ref/vhdl/vhdl_renerta/mobile/source/vhd00044.htm (accessed Oct. 6, 2024). 

### 5. Jelaskan use case dari for loop dan while loop dalam VHDL. Apakah keduanya synthesizable? Jika tidak, untuk apa loop tersebut digunakan? (10 poin)
For-loop dan while-loop bisa digunakan untuk beriterasi dari satu index array ke index lain ataupun untuk melakukan suatu block kode sampai suatu conditional terpenuhi. Perbedaannya adalah untuk for-loop, range harus ditentukan sebelum compile, sedangkan conditional statement pada while-loop tidak harus diketahui rangenya sebelum compile. Perbedaan inilah yang menyebabkan while-loop tidak bisa disynthesize sedangkan for-loop bisa.

**Referensi:**
- J. J. Jensen, “How to use a for loop in VHDL,” VHDLwhiz, https://vhdlwhiz.com/for-loop/ (accessed Oct. 6, 2024).
- J. J. Jensen, “How to use a while loop in VHDL,” VHDLwhiz, https://vhdlwhiz.com/while-loop/ (accessed Oct. 6, 2024).
- S. Shahabuddin, “Hour 16: Loop and generate,” Learn VHDL, https://sites.google.com/site/learnvhdl/home/hour-16-loop-and-generate (accessed Oct. 6, 2024). 

## Pengujian (50 points)
### 1. Perhatikanlah Kode VHD Berikut
Loop with Signal
```

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;  

entity my_loop_signal is
port (
    input_n : in std_logic_vector(2 downto 0);
    input_l : in std_logic_vector(2 downto 0);
	
    output_h : out std_logic_vector(2 downto 0)
);
end entity;

architecture rtl of my_loop_signal is
    signal mult: signed(2 downto 0) := "000";
    signal n_int: integer := 0;
begin
process (input_n, input_l,clock)

begin
    n_int <= conv_integer(signed(input_n));  

    for k in 0 to n_int-1 loop
        mult <= mult + signed(input_l);
    end loop;

    output_h <= std_logic_vector(mult);
end process;
end architecture;
```

Loop with Variable
```
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 

entity my_loop is
port (
    input_n : in std_logic_vector(2 downto 0);
    input_l : in std_logic_vector(2 downto 0);
    output_h : out std_logic_vector(2 downto 0)
);
end entity;

architecture rtl of my_loop is
	
begin
process (input_n, input_l)
    variable mult: signed(2 downto 0) := "000";
    variable n_int: integer := 0;
begin
    n_int := conv_integer(signed(input_n));  

    for k in 0 to n_int-1 loop
        mult := mult + signed(input_l);
    end loop;

    output_h <= std_logic_vector(mult);
end process;
end architecture;
```
- Apa yang ingin di kerjakan oleh kode? Bagaimana kode mengerjakan operasi tersebut?  Apa yang membedakan kedua cuplikan kode tersebut? (5 poin)
    - Perbedaan kode hanyalah penggunaan signal dan variable sebagai value temporary
    - Kode mengerjakan perkalian antara input_n dengan input_l. Cara kerjanya adalah input_l akan ditambah dengan dirinya sebanyak n kali. Misalkan input_n adalah 4 dan input_l adalah 5, maka kode akan menjalankan (5+5+5+5) = 20. Perbedaannya dengan contoh adalah rangkaian hanya menerima 3 bit, sehingga output hanya bisa dari 0-7



- Jalankan kedua kode dengan input n = "010" dan input l = "011" ataupun kombinasi lainnya, apakah kedua kode memiliki output yang sesuai? 
    - Output untuk kedua rangkaian (bisa) sesuai, tetapi rangkaian yang berisi logic perlu beberapa cycle untuk bisa mencapai hasil yang sesuai. Selain itu, rangkaian yang berisi logic juga terus looping dengan menambahkan 3 kedalam signal d_out, sehingga output terus berjalan dari 3, 6, 1(mod 3), 4(mode 3), dst. untuk setiap clock cycle. Output ini berbeda dengan output dengan menggunakan variable, dimana output tetap sama, yaitu 6, 6, 6, 6, dst.
    - Foto simulasi dengan logic:
    - Foto simulasi dengan variable:

- Jelaskan mengapa hal tersebut dapat terjadi! Apa yang membedakan variable dan signal, dan bagaimana penggunaannya dalam loop! (20 poin)
    - Perbedaannya adalah variabel mengambil nilai saat assignment, sedangkan signal bergantung pada apakah signal tersebut digunakan dalam kode combinational atau sequential. Dalam kode combinational, signal langsung mengambil nilai assignmentnya.

**Referensi:**
- R. Merrick, “Variables vs. Signals in VHDL,” NAND Land, https://nandland.com/variables-vs-signals/ (accessed Oct. 6, 2024). 

### 2. Ubahlah kode tersebut sehingga looping menggunakan while Loop. Berikan analisa perubahan yang dilakukan antara for loop dan while loop (20 poin).
```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all; 

entity my_loop_while is
port (
    input_n : in std_logic_vector(2 downto 0);
    input_l : in std_logic_vector(2 downto 0);
    output_h : out std_logic_vector(2 downto 0)
);
end entity;

architecture rtl of my_loop_while is
	
begin
process (input_n, input_l)
    variable mult: signed(2 downto 0) := "000";
    variable n_int: integer := 0;
    variable ctr: integer := 0;
begin
    n_int := conv_integer(signed(input_n));
    ctr := 0;

    while ctr < n_int loop
        mult := mult + signed(input_l);
        ctr := ctr + 1;
    end loop;

    output_h <= std_logic_vector(mult);
end process;
end architecture;
```

Perbedaan antara while dengan for adalah for-loop dapat langsung instansiasi sebuah variabel integer temporary yang bisa digunakan dalam loop itu sendiri, sedangkan untuk while-loop kita perlu mendeklarasikan variabel counter kita sendiri.

### 3. Untuk persiapan CS, silahkan mempelajari for generate loop. Berikan penjelasan dan penggunaan sekilas mengenai for generate loop pada TP ini (5 poin).
Generate statement bersifat concurrent, sedangkan for-loop bersifat sekuensial. Dengan menggunakan for-loop dan generate, maka kita bisa mereplikasi statement yang berada di dalam for-loop sebanyak range yang ditentukan untuk dijalankan secara concurrent.  

**Referensi:**
- S. Shahabuddin, “Hour 16: Loop and generate,” Learn VHDL, https://sites.google.com/site/learnvhdl/home/hour-16-loop-and-generate (accessed Oct. 6, 2024). 
- R. Merrick, “Generate Statement – VHDL Example,” NAND Land, https://nandland.com/generate/ (accessed Oct. 6, 2024). 
