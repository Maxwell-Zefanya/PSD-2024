# Tugas Pendahuluan Modul 8
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## A. Teori (50 Poin)
### 1. Jelaskan apa itu Finite State Machine beserta jenis - jenis dari Finite State Machine! Jelaskanlah juga kapan saat yang tepat untuk menggunakan masing - masing jenis FSM dan berikan contoh sederhana untuk masing - masing jenis <span style="color:red">(20 Poin)</span>

Finite state machine adalah sebuah model matematis yang berisi sebuah mesin abstrak dan sekumpulan state/kondisi yang jumlah state-nya terhingga. Pada model ini, mesin hanya bisa berada pada sebuah state saja, dan akan bisa pinda ke state lain saat suatu kondisi terpenuhi. Biasanya, terdapat 2 jenis state machine yang sering digunakan untuk mendesain suatu rangkaian, yaitu Mealy machine dan Moore machine.  

Sebuah Mealy machine adalah jesis dari FSM yang akan menghasilkan sebuah output berdasarkan state mesin pada saat itu dan juga inputnya. Jadi, bila suatu input pada mesin Mealy diubah, maka output yang dihasilkan juga bisa berubah. Oleh karena itu suatu mesin Mealy biasanya kurang stabil terhadap input yang berubah-ubah ketimbang mesin Moore. Tetapi, karena sifatnya yang bisa berubah berdasarkan input, maka mesin Mealy bisa digunakan untuk menghubungkan berbagai rangkaian yang memerlukan state satu dengan yang lainnya untuk berfungsi. Contohnya adalah sebuah sistem lampu merah pada suatu perempatan.  

Sebaliknya, pada Moore machine output dari mesin hanya dipengaruhi oleh state mesin pada saat itu saja. Biasanya ditemukan pada rangkaian yang menggunakan clock sebagai pengubah statenya. Oleh karena itu, output dari sebuah mesin Moore akan tetap stabil walaupun inputnya terus diubah. Contoh dari mesin Moore adalah sebuah counter sederhanya, dimana setiap perubahan clock akan menyebabkan counter untuk berubah ke angka berikutnya.  

**Referensi:**
- N. Samosir, "Finite State Machine," Digilab UI, https://learn.digilabdte.com/books/digital-system-design/page/finite-state-machine (accessed Nov. 3, 2024).
- “Finite-State Machine,” CS Community at MTSU, https://www.cs.mtsu.edu/~xyang/3080/fsm.html (accessed Nov. 3, 2024).
- “9.1.1: Finite-State Machine Overview,” Engineering LibreTexts, https://eng.libretexts.org/Under_Construction/Book%3A_Discrete_Structures/09%3A_Finite-State_Automata/9.01%3A_Introduction/9.1.01%3A_Finite-State_Machine_Overview (accessed Nov. 3, 2024).
- “Overview of Mealy and Moore Machines,” MathWorks, https://www.mathworks.com/help/stateflow/ug/overview-of-mealy-and-moore-machines.html (accessed Nov. 3, 2024).
- “CSE370, Lecture 18,” University of Washington, https://courses.cs.washington.edu/courses/cse370/08sp/Lecture%20Slides/Lec18.pdf (accessed Nov. 3, 2024).

### 2. Jelaskan apa itu State Diagram, apa saja komponen yang digunakan dalam state diagram dan berikanlah contoh penggunaan dari State Diagram <span style="color:red">(15 Poin)</span>

State diagram adalah adalah sebuah diagram yang digunakan untuk merancang spesifikasi sebuah state machine. Ada 2 aspek utama dalam pembuatan suatu state diagram, yaitu State yang digambarkan sebagai sebuah lingkaran, dan Transition yang digambarkan dengan sebuah panah yang menghubungkan antara dua state. Biasanya, pada Mealy machine, transition akan memiliki 2 bagian, yaitu satu yang menjelaskan input, dan satu yang menjelaskan output yang diperlukan oleh transition tersebut.  
Contoh state diagram:
- Sebuah tangan jam


**Referensi:**
- "What is State Machine Diagram?," Visual Paradigm, https://www.visual-paradigm.com/guide/uml-unified-modeling-language/what-is-state-machine-diagram/ (accessed Nov. 3, 2024).
- “CSE 370 Spring 2006
Introduction to Digital Design
Lecture 18: Moore and Mealy
Machines,” University of Washington, https://courses.cs.washington.edu/courses/cse370/06sp/pdfs/lecture18.pdf (accessed Nov. 3, 2024).

### 3. Jelaskan hal - hal berikut dalam konteks VHDL <ul><li>Record</li><li>Alias</li><li>Aggregate</li><li>Allocator</li><li>Access</li></ul> <span style="color:red">(15 Poin)</span>

- Record
    - Record adalah fitur yang bisa mengelompokkan berbagai macam variabel kedalam satu container. Bila ditarik paralel ke C, maka Record adalah sebuah struct, dimana dalam struct kita bisa mengakses semua variable secara individu. Record dibentuk dalam sebuah package, dimana package akan dipanggil dalam kode yang ingin dipakai
    - Contoh syntax Record:
```
-- Pada package
library...
use...
package contohPackage is
    type contohRecord is record
        contoh  : std_logic
        contoh2 : std_logic_vector(7 downto 0)
    end record contohRecord;
end pacakage contohPackage;

-- Pada architecture
library...
use...
entity is
    port (
        inp : in contohRecord
        otp : out contohRecord
    )
end entity;

architecture is
begin
    otp.contoh  <= inp.contoh;
    otp.contoh2 <= inp.contoh2;
end architecture;
```

- Alias
    - Alias adalah fitur yang bisa memberikan nama lain terhadap suatu hal pada VHDL yang bisa kita definisikan sendiri. Misalnya keyword `alias Source : Bit_Vector(1 downto 0) is Instruction(11 downto 10);` pada VHDL akan mengaliaskan `Instruction(11 downto 10)` menjadi keyword `Source` yang memiliki lebar 2 bit, dimana bisa diakses per bit atau secara keseluruhan. Alias paling mirip dengan keyword #define pada C, dimana aproksimasi paling dekatnya adalah `#define Instruction(11 downto 10) Source(1 downto 0)`.

- Aggregate
    - Aggregate adalah penggabungan dari beberapa value dengan type yang sama untuk membentuk suatu value dengan type array dari type awal value tersebut. Misalnya kita ingin melakukan assignment value kedalam `signal F : std_logic_vector(3 downto 0)` oleh beberapa value std_logic yaitu `signal A, B, C, D : std_logic`. Dengan aggregate, maka kita bisa mengassign keempat value kedalam F secara bersamaan dengan menulis `F <= (0=>A, 1=>B, 2=>C, 3=>D)` atau `F <= (A,B,C,D)`

- Allocator
    - Allocator akan menginisialisasi sebuah objek dan mengembalikan pointer kepada objek tersebut
    - Contoh syntax:
```
type Table is array (1 to 8) of Natural;
type TableAccess is access Table;
variable y : TableAccess;
...
y := new Table; -- will be initialized with
-- (0, 0, 0, 0, 0, 0, 0, 0)
```

- Access
    - Fitur access digunakan untuk memberikan sebuah objek semacam suatu "pointer" terhadap objek tersebut, seperti misalnya untuk record.
    - Contoh syntax:
```
type Example is record
    a:std_logic;
    b:std_logic;
end record;

type Example_Access is access Example;
```

**Referensi:**
- J. M.  Nageswaran, “Alias Declaration,” VHDL reference guide , https://ics.uci.edu/~jmoorkan/vhdlref/aliasdec.html (accessed Nov. 4, 2024).
- P. Fabinski, “VHDL - Access Type,” Peterfab.com, https://peterfab.com/ref/vhdl/vhdl_renerta/mobile/source/vhd00001.htm (accessed Nov. 4, 2024).
- P. Fabinski, “VHDL - Aggregate,” Peterfab.com, https://peterfab.com/ref/vhdl/vhdl_renerta/mobile/source/vhd00002.htm (accessed Nov. 4, 2024).
- P. Fabinski, “VHDL - Alias,” Peterfab.com, https://peterfab.com/ref/vhdl/vhdl_renerta/mobile/source/vhd00003.htm (accessed Nov. 4, 2024).
- P. Fabinski, “VHDL - Allocator,” Peterfab.com, https://peterfab.com/ref/vhdl/vhdl_renerta/mobile/source/vhd00004.htm (accessed Nov. 4, 2024).
- R. Merrick, “VHDL example code of record type,” Nandland, https://nandland.com/record/ (accessed Nov. 4, 2024).






## B. Praktik (50 Poin)
### 1. Dari state diagram yang disediakan, ubahlah state diagram tersebut menjadi kode VHDL! Jelaskanlah juga bagaimana sistem tersebut bekerja dan tipe FSM manakah sistem tersebut <span style="color:red">(25 Poin)</span>

![image](https://cdn.digilabdte.com/u/IwGAlM.png)
```
Note : '00' merupakan state awal dari sistem.
Hint :
Ketika sistem sedang berada pada state '01', terdapat 2 kemungkinan state yang dapat dialami oleh sistem pada iterasi berikutnya.
Apabila sistem diberikan input '1', maka sistem akan mengeluarkan output '0' dan berubah menjadi state '10'.
Apabila sistem diberikan input '0', maka sistem akan mengeluarkan output '1' dan berubah menjadi state '00'
```

Diagram ini menjelaskan sebuah state diagram Mealy, dimana ada 4 state dimana mesin tersebut bisa bekerja.

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;   

entity test is
    port (
        enable : in std_logic;
        output : out std_logic
        
    );
end entity test;

architecture rtl of test is
    signal state : std_logic_vector(1 downto 0) := "00";
begin
    process(enable)
        variable c : std_logic;
    begin
        c := enable;
        case state is
            when "00" =>
                if c = '1' then
                    state <= "10";
                    output <= '0';
                else
                    state <= "11";
                    output <= '0';
                end if;
            when "01" => 
                if c = '1' then
                    state <= "10";
                    output <= '0';
                else
                    state <= "00";
                    output <= '1';
                end if;
            when "10" => 
                if c = '1' then
                    state <= "11";
                    output <= '0';
                else
                    state <= "00";
                    output <= '1';
                end if;
            when "11" => 
                if c = '1' then
                    state <= "01";
                    output <= '1';
                else
                    state <= "00";
                    output <= '1';
                end if;
            when others =>
        end case;
    end process;
end architecture test;
```

### 2. Dari Kode VHDL berikut, buatkanlah State Diagram dari Sistem tersebut! Jelaskanlah juga bagaimana sistem tersebut bekerja dan tipe FSM manakah sistem tersebut <span style="color:red">(25 Poin)</span>

```vhdl
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;   

entity vandal is
    port (
        bullet: in std_logic := '1';
        trigger: in std_logic := '0';
        clk: in std_logic := '0';
        pew: out std_logic := '0'
    );
end entity vandal;

architecture rtl of vandal is
    type vandalState is (Idle, Shooting, Reload);
    signal weapon_state : vandalState;
begin
    process(clk)
    begin
        if rising_edge(clk) then
            case weapon_state is
                when Idle =>
                    pew <= '0';

                    if(trigger = '1' and bullet = '1') then
                        weapon_state <= Shooting;
                    elsif(bullet = '0') then
                        weapon_state <= Reload;
                    end if;

                when Shooting =>
                    pew <= '1';

                    if(trigger = '0' and bullet ='1') then
                        weapon_state <= Idle;
                    elsif(trigger ='1' and bullet ='1') then
                        weapon_state <= Shooting;
                    else 
                        weapon_state <= Reload;
                    end if;

                when Reload =>
                    pew <= '0';

                    if(bullet = '1') then
                        weapon_state <= Idle;
                    end if;
            end case;
        end if;
    end process;
end architecture rtl;
```

Kode ini mencoba untuk mensimulasikan berbagai state dari senjata Vandal dari hit game tahun 2020 yang bernama Valorant. Setiap rising edge pada clock, maka akan dicek status dari Vandal tersebut. Bila senjatanya masih idle, maka pew akan dijadikan 0. Bila pada saat idle senjatanya ingin ditembak, maka kode akan berubah ke state shooting, yang akan menyetel variabel pew dan mengecek status bullet dari senjata. Bila pelurunya habis (baik dalam Idle atau Firing), maka senjata akan masuk kedalam state reloading. Terakhir, bila pada saat shooting triggernya dilepas, maka kondisi akan kembali kedalam Idle.  

Gambar State diagram:  

