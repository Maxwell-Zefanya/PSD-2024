# Tugas Pendahuluan Modul 7

```txt
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## Video Penjelasan (50% nilai)

> Buatlah video penjelasan jawaban Tugas Pendahuluan. Masukkan link video pada file ini. Video berdurasi 5 menit dengan bagian teori selama 2 menit dan bagian latihan selama 3 menit.

**Link Video:** [TP_PSD7_Maxwell Zefanya Ginting_2306221200](https://youtu.be/ZJKbNeb_TQ4)

## Teori (55 poin)

### 1. Jelaskan Syntax dan kegunaan dari seluruh jenis programing modular (yang sudah dicakup materi modul sebelumnya dijelaskan secara singkat saja). (30 poin)

Dalam VHDL, terdapat berbagai fitur dalam bahasanya yang memungikinkan kode ditulis secara modular. Beberapa diantaranya adalah port map (& component), functions (pure & impure), dan procedures.
- Port map (& Component)  
    Adalah sebuah fitur pada VHDL yang memungkinkan suatu architecture untuk mengintegrasikan kode dari berbagai macam entity. Sedangkan component digunakan untuk mendifinisikan port pada entity yang ingin di-import. Keduanya biasanya digunakan dalam pembuatan testbench atau untuk memisahkan berbagai rangkaian berbeda ke file-file yang berbeda  
    
    Syntaxnya adalah:  
    - `<name> : <component> port map(...);`  
    - `compoent <name> port (...); end component <name>;'`
- Functions  
    Secara definisi adalah sesuatu yang mengambil suatu input dan mentransformasikannya menjadi suatu nilai lain yang dikeluarkan dari function tersebut. Pada VHDL, function bisa mengambil beberapa input dan harus mengembalikan satu buah value. Secara definisi, sebuah function juga tidak memiliki *side effects*, dimana function tsb mentransformasikan benda lain selain inputnya. Hal ini juga sama dengan VHDL. Artinya, scope function hanya terbatas pada pengubahan variabel inputnya saja, dan variabel lokal lain yang ada didalamnya, yang nantinya akan mengembalikan sebuah value.  
    
    Supaya kode bisa menerima/mengubah signal external, maka VHDL juga memiliki fitur yaitu keyword impure. Dengan menggunakan keyword impure, maka blok kode function tidak terbatas hanya menguah input value dan variabel lokalnya saja. Blok kode tersebut sekarang juga bisa mengubah dan membaca signal dari luar.  
    
    Functions pada VHDL memungkinkan agar suatu algoritma sekuensial yang sama yang dipakai pada banyak bagian kode dan membutuhkan tipe nilai yang sama untuk dibuat menjadi sebuah function saja, yang nantiya akan dipanggil secara berulang kali didalam kode. Functions memungkinkan agar kita tidak perlu menulis algoritma berulang kali pada suatu kode. Secara langsung, functions juga akan membuat kode lebih mudah untuk dimaintain, karena perubahan algoritma hanya perlu dilakukan kepada satu blok kode saja.  
    
    Syntax dari keduanya adalah:  
    
```
-- Deklarasi pure function
-- Secara default sebuah function dianggap pure
<pure (opsional)> function <name> (
        <param_name> : <type> := <default value (opsional)>;
        ...
        <param_name> : <type> := <default value (opsional)>
        ) return <type> is
    <local declaration>
    ...
begin
    <algorithm>
    ...
    return <value>
end function;

-- Pemanggilan pure function
<name>(<value/input_name>, ..., <value/input_name>);
<name>(
    <param_name> => <value/input_name>;
    ...
    <param_name> => <value/input_name>;
    )
<variable> := <name>(...);
if <name>(...) then
-- etc.
```

```
-- Deklarasi impure function

impure function <name> (
        <param_name> : <type> := <default value (opsional)>;
        ...
        <param_name> : <type> := <default value (opsional)>
        ) return <type> is
    <local declaration>
    ...
begin
    <algorithm>
    ...
    return <value>
end function;

-- Pemanggilan impure function
<name>(<value/input_name>, ..., <value/input_name>);
<name>(
    <param_name> => <value/input_name>;
    ...
    <param_name> => <value/input_name>;
    )
```

- Procedure  
    Berbeda dengan functions, sebuah procedure digunakan untuk mendeskripsikan sebuah bagian kecil dari rangkaian secara keseluruhan. Oleh karena itu, input dari sebuah procedure harus berupa signal, dan procedure sendiri tidak bisa memiliki sebuah return *value*, tetapi keyword return bisa digunakan untuk keluar dari procedure. Pada procedure, "input" dan "output" ditentukan dari jenis signal yang ada, seperti `in`, `out`, dan `inout`. Procedure bisa digunakan dalam sebuah process atau digunakan secara concurrent. Karena procedure kurang lebih merupakan pengganti sebuah blok kode rangkaian, maka aturan yang diikuti akan sama juga. Sebuah procedure bisa digunakan baik secara concurrent, ataupun dalam process. Selain itu, procedure juga akan memengaruhi apakah sebuah process boleh memiliki sensitivity list atau tidak, dsb.  
    
    Syntax untuk procedure adalah:
    
```
-- Deklarasi procedure
procedure <name> (
        <signal/variable/constant> <name> : <in/out/inout> <type>;
        ...
        <signal/variable/constant> <name> : <in/out/inout> <type>
        ) is
        
    <local declaration>
    ...
begin
    <block of code>
    ...
end procedure;

-- Pemanggilan procedure
<name>(<value/input_name>, ..., <value/input_name>);
<name>(
    <param_name> => <value/input_name>;
    ...
    <param_name> => <value/input_name>;
    )
```
    
    
**Referensi:**

- R. Merrick, “Function - VDHL Example,” Nandland, https://nandland.com/function-3/ (accessed Oct. 26, 2024).
- J. J. Jensen, “How to use a function in VHDL,” VHDLwhiz, https://vhdlwhiz.com/function/ (accessed Oct. 26, 2024).
- J. J. Jensen, “How to use an impure function in VHDL,” VHDLwhiz, https://vhdlwhiz.com/impure-function/ (accessed Oct. 26, 2024).
- J. J. Jensen, “How to use a procedure in VHDL,” VHDLwhiz, https://vhdlwhiz.com/using-procedure/ (accessed Oct. 26, 2024).
- N. K, “VHDL functions and procedures,” VLSI Design, https://vlsi-design-engineers.blogspot.com/2015/07/vhdl-functions-and-procedures.html (accessed Oct. 26, 2024).
- “Port Map,” HDLWorks, https://www.hdlworks.com/hdl_corner/vhdl_ref/VHDLContents/PortMap.htm (accessed Oct. 26, 2024).
- S. Shahabuddin, “Hour 08: Components,” Learn VHDL, https://sites.google.com/site/learnvhdl/home/hour-09-components (accessed Oct. 26, 2024).

### 2. Jelaskan lokasi penulisan procedure, function, dan inpure function. Jelaskan juga apa yang terjadi jika tidak pada lokasi tersebut.  (10 poin)

Dalam VHDL, pure function, procedure dan impure function bisa ditulis pada bagian declarative baik pada architecture maupun sebuah process. Meskipun begitu, biasanya impure function lebih sering dipakai didalam sebuah process. Ketiga-tiganya perlu ditulis pada bagian declarative karena mereka akan dipakai dalam sebuah process, atau concurrent statement (untuk pure function dan procedures). Oleh karena itu mereka harus dideklarasikan sebelum bisa dipakai. Bila tidak (procedure etc. ditulis setelah keyword begin), maka akan terjadi compile error.

**Referensi:**

- J. J. Jensen, “How to use a function in VHDL,” VHDLwhiz, https://vhdlwhiz.com/function/ (accessed Oct. 26, 2024).
- J. J. Jensen, “How to use an impure function in VHDL,” VHDLwhiz, https://vhdlwhiz.com/impure-function/ (accessed Oct. 26, 2024).
- J. J. Jensen, “How to use a procedure in VHDL,” VHDLwhiz, https://vhdlwhiz.com/using-procedure/ (accessed Oct. 26, 2024).
- J. J. Jensen, “How to use a procedure in a process in VHDL,” VHDLwhiz, https://vhdlwhiz.com/using-procedure/ (accessed Oct. 26, 2024).


### 3. Bandingkan jawaban nomor 1 dan 2 anda dengan yang ada di Dasar Teori Digilab. (5 poin)

Perbedaan antara jawaban nomor 1 dan 2 tidak jauh besar, tetapi penjelasan di daste mengenai procedure salah dimana procedure sebenarnya tidak ada mengembalikan type apapun

**Referensi:**

- A. Raffi, "Procedure, Function and Impure Function," Netlab DTE, https://emas2.ui.ac.id/pluginfile.php/4785044/mod_resource/content/2/Modul7_PSD23.pdf (accessed Oct. 26, 2024).

### 4. **Menurut anda**, jenis programing modular apa yang paling baik, berikan justifikasi. (5 poin)

> Note: Pendapat pribadi and, jika terlalu banyak yang mirip akan dikenakan plagiarisme

Menurut pribadi, pada saat pembuatan kode VHDL maka fitur dari programming modular yang paling baik adalah sebuah pure function. Diantara semuanya, pure function paling baik karena rangkaian pada suatu saat pasti akan menggunakan sebuah algoritma generik yang dipakai berkali-kali. Karena sifatnya yang deterministik, dengan menggunakan pure function, maka algoritma tersebut bisa dijadikan menjadi sebuah function call saja tanpa ada kerugian apapun (seperti kode tidak bisa disintesis).

> Note2: Tetap ada referensi

**Referensi:**

- A. Raffi, "Procedure, Function and Impure Function," Netlab DTE, https://emas2.ui.ac.id/pluginfile.php/4785044/mod_resource/content/2/Modul7_PSD23.pdf (accessed Oct. 26, 2024).

### 5. Apa saja jenis programing modular yang anda jawab pada nomor 1 yang dapat disintesis, Mengapa jika tidak bisa. (5 poin)

Sebuah pure function dapat disintesis karena sifatnya yang sepenuhnya deterministik (input yang sama akan mengeluarkan hasil yang sama). Selain itu, karena sebuah procedure kurang lebih adalah sebuah blok kode rangkaian, maka kemampuan sebuah procedure untuk disintesis tergantung pada aturan-aturan sintesis yang biasanya ada dalam sebuah architecture. Contohnya sebuah procedure yang menggunakan keyword `wait;` tidak akan bisa disintesis. Berbeda dengan keduanya, sebuah impure function biasanya tidak bisa disintesis karena sifatnya yang bergantung dengan sinyal external yang bukan merupakan bagian dari input (non-deterministik).

**Referensi:**

- G. C. Sihombing, "Procedure, Function, and Impure Function Synthesis," Netlab DTE, https://learn.digilabdte.com/books/digital-system-design/page/procedure-function-and-impure-function-synthesis (accessed Oct. 26, 2024).
- quantum231 and user16145658, “How to create a VHDL function/procedure that can return true or false based on value of signals outside it?,” Electrical Engineering Stack Exchange, https://electronics.stackexchange.com/questions/580682/how-to-create-a-vhdl-function-procedure-that-can-return-true-or-false-based-on-v (accessed Oct. 27, 2024). 

## Latihan (45 points)

### 6. Buatlah rangkaian dengan kriteria berikut. Lampirkan kode dan gambar simulasi wave. (45 poin)

#### Kriteria

- Entity memiliki 1 input logic vector dan 1 output logic vector
- Terdapat sebuah procedure yang menerima 1 dan 1 output
  - Input berupa angka bulat positif
  - Output berupa angka bulat positif
- Procedure tersebut akan mengembalikan output bernilai 2 * fungsi
- Fungsi tersebut akan menerima 1 input yang berasal dari input procedure
- Fungsi tersebut akan mengembalikan input * impure
- Impure merupakan impure function yang bersifat random dan bernilai 1 dengan kemungkinan 60% dan 2 dengan kemungkinan 60%.

#### Rekap

- **Procedure:** Menerima 1 input dan 1 output
  - `output` = `function(input)`
- **Function:** Menerima 1 input
  - return `input` * `impure function`
- **Impure Function:** Tidak ada input
  - return 1 (60% of the time)
  - return 2 (40% of the time)

#### Kode



```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.math_real.all;

entity test_rand is
  port (
    input : in std_logic_vector(7 downto 0);
    clk : in std_logic;
    output : out std_logic_vector(7 downto 0)
  );
end entity test_rand;

architecture arch_test_rand of test_rand is

  function func (
    in_param : positive := 1;
    in_mult : positive := 1
    ) return positive is
  begin
    return in_param * in_mult;
  end function;

begin

  process(clk) is

    variable in_pos : positive;
    variable out_pos : positive;
    
    variable in_tmp : unsigned(7 downto 0);
    variable out_tmp : unsigned(7 downto 0);
    variable rand_mult : positive;

    variable seed1_reg : positive := 1;
    variable seed2_reg : positive := 2;

    impure function imfunc return positive is
      variable r : real;
      variable s1 : positive;
      variable s2 : positive;
    begin
      s1 := seed1_reg;
      s2 := seed2_reg;
      uniform (s1, s2, r);
      report "R: "&real'image(r);
      
      -- Masukkan kembali hasil random kedalam variabel seed supaya seed
      --   yang masuk tidak terus sama.
      seed1_reg := positive(round(r+real(1)));
      seed2_reg := positive(round((r+real(1))*real(65535)));

      -- Karena range uniform adalah dari 0.0 - 1.0, maka midpointnya di 0.5
      -- Dengan fungsi round, maka akan ada 50% kesempatan angka berada dib-
      --   awah 0.5 (round to 0) dan 50% di atas 0.5 (round to 1)
      -- Bila kita pindah midpoint ke 1.4 (dengan range yang sama). Maka ra-
      --   nge value adalah dari 0.9-1.9, dimana akan ada 40% kemungkinan
      --   angka jatuh diatas 1.5 dan sisanya akan di round ke angka 1
      r := r + real(0.9);
      return positive(round(r));
    end function;

    procedure proc (
      variable in_proc : in positive;
      variable out_proc : out positive
    ) is 
    begin
      out_proc := 2*func(in_proc, rand_mult);
    end procedure;

  begin
    rand_mult := imfunc;
    in_tmp := unsigned(input);
    in_pos := conv_integer(in_tmp);
    proc(in_pos, out_pos);
    output <= conv_std_logic_vector(positive(out_pos), 8);
  end process;
end architecture arch_test_rand;
```

#### Simulasi

![Gambar Simulasi](https://github.com/user-attachments/assets/b5c9f47d-ef68-4703-8041-4bc4da1812cf)

#### Analysis
Pada awalnya, bila kode mengikuti kriteria secara keseluruhan, maka akan mendapatkan warning pada saat compile-time karena impure function tidak bisa dipanggil dalam pure function (tanpa menghilangkan deterministik pure functionnya). Oleh karena itu, maka function harus menerima 2 input, yaitu input angka serta input multiplier yang telah terlebih dahulu didapatkan dari impure function.  

Kode dijalankan dengan pertama mendapatkan angka random (sebut int_rand) dari impure function. Lalu, dari input yang berupa std_logic_vector dikonversi menjadi angka positive (sebut Pin). Kemudian, angka akan dimasukkan kedalam procedure yang menerima Pin sebagai input variable dan Pout (positive out) sebagai output variable. Didalam procedure, Nilai Pout yang diassign adalah nilai dari 2\*function, dimana function menerima input yaitu Pin dan int_rand, yang akan mereturn Pin dikali int_rand. Setelah Pout diassign, maka Pout (yang bertipe positif) akan diassign ke output dengan terlebih dahulu mengkonversinya menjadi std_logic_vector. Dalam kode ini, clock hanya sekedar memampukan input yang sama bisa dimasukkan berulang kali.  

Setelah kode dijalankan, maka didapatkan hasil simulasi sebanyak 20 kali input (seperti pada gambar), terdapat 45% angka dari impure function adalah 1 dan 55% impure function mereturn 2. Karena jumlah percobaan masih kecil, jadi belum terlalu bisa dibilang apakah sudah sesuai atau belum.  

Rangkaian ini berfungsi sekedar mengalikan angka saja dengan acak. Oleh karena itu, rangkaian ini bisa digunakan sebagai semacam dadu, yang bisa memiliki jumlah muka berapapun yang diinginkan, dimana input adalah hasil yang ingin dikalikan dengan muka dadu tersebut (misalnya untuk D&D bila butuh 1d6 bisa saja input dijadikan 1 dan kode diubah untuk menerima range output dari 1-6).  

> Note: Saat analysis anda, jelaskan menurut anda apa aplikasi dari rangkaian tersebut, atau dalam kata lain apa yang rangkaian tersebut mungkin berupa (jawaban individu, jika terlalu banyak yang sama akan dianggap plagiarisme). Saat rangkaian dijelaskan dan dianalisis, nama fungsi, signal, dan variable sesuai dengan aplikasi yang kalian tentukan.

> Note2: Jika menurut anda terdapat kesalahan pada kriteria, analysis mengapa kesalahan tersebut terjadi.
