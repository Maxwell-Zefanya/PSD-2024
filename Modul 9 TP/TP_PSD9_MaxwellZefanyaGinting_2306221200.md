# Tugas Pendahuluan 9
```bash
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## 1. Berdasarkan apa yang telah kalian pelajari, jadi tolong ceritakan bagaimana sebuah instruksi dibuat!

Sebuah instruksi bisa dibuat pada hardware dengan pertama menspesifikasikan bagaimana sebuah instruksi tersebut akan diencrypt. Misalnya sebuah instruksi `1101-0001-1000-0011` didecode menjadi `R1 = R2 + 3`. Maka, kita akan mendecode instruksi tersebut, dimana misalnya untuk 6 bit pertama (`110100`) berarti Register = Register + immediate, 2 bit selanjutnya (`01`) berarti tujuan ke R1, 2 bit berikutnya (`10`) berarti nilai diambil dari R2, dan 6 bit terakhir adalah immediate (`000011`). Setelah instruksi dibuat spesifikasinya, maka kita bisa membuat sebuah pasangan datapath dan control unit yang sesuai. Misalnya pada control unit disimpan 4 register, yang akan dipilih menggunakan bit `01` dan `10`, seperti menggunakan mux. Lalu, 6 bit pertama (`000011`) juga bisa membuat state yang diperlukan agar perhitungan bisa dilakukan dengan benar pada datapath (misal menyetel suatu mux dengan bit select dari bit 6, dsb. Terakhir, barulah data bisa dikirim ke datapath bersamaan, yang nantinya akan kembali ke register (sesuai dengan instruksi yang ada).

**Referensi:**
- G. C. Sihombing, “Microprogramming in VHDL,” Digilab UI, https://learn.digilabdte.com/books/digital-system-design/page/microprogramming-in-vhdl (accessed Nov. 10, 2024).
- F. A. Ekadiyanto, "Microprogramming," Universitas Indonesia, https://emas2.ui.ac.id/pluginfile.php/4800344/mod_resource/content/1/Microprogramming1%2B2.pdf (accessed Nov. 10, 2024).

## 2. Berdasarkan [website ini](https://www.felixcloutier.com/x86/), pilihlan tiga instruksi dari [website tersebut](https://www.felixcloutier.com/x86/). Implementasikan instruksi intruksi tersebut dengan menggunakan VHDL sesuai dengan contoh di modul!. Instruksi yang dipilih oleh praktikan haruslah berbeda dengan praktikan lain, silakan mengisi [sheet ini](https://docs.google.com/spreadsheets/d/13Cd9bt_uetgVTfz2c4WV4vgpK4KSFlmXeInhBaHsJ9M/edit?usp=sharing)

### Instruksi 1
```vhdl
-- MOVBE
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MOVBE is
  generic (
    -- Valid sizes = {16, 32, 64} bit
    width : integer := 16
  );
  port (
    clk : in std_logic;
    res : in std_logic;
    en : in std_logic;
    input_register : in std_logic_vector(width-1 downto 0);
    output_register : out std_logic_vector(width-1 downto 0)
  );
end entity MOVBE;

architecture MOVBE_ARC of MOVBE is
	type State_Type is (FETCH, DECODE, EXECUTE, COMPLETE);
	signal state : State_Type := FETCH;
  signal prog_ctr : integer := 0;
  signal temp_register : std_logic_vector(63 downto 0) := (others => '0');
begin
  process(clk, res) is
  begin
    if res = '1' then
      temp_register <= (others => '0');
      state <= FETCH;
      prog_ctr <= 0;
    elsif rising_edge(clk) then
      case state is
        when FETCH =>
          if en = '1' then
            state <= DECODE;
          end if;
        when DECODE =>
          temp_register(width-1 downto 0) <= input_register;
          state <= EXECUTE;
        when EXECUTE =>
          case width is
            when 16 =>
              report "width 16 bits";
              for ctr in 0 to 1 loop
                for i in 0 to 7 loop
                  output_register(width-1-i-(8*ctr)) <= temp_register(i+(8*ctr));
                end loop;
              end loop;
            when 32 =>
              report "width 32 bits";
              for ctr in 0 to 3 loop
                for i in 0 to 7 loop
                  output_register(width-1-i-(8*ctr)) <= temp_register(i+(8*ctr));
                end loop;
              end loop;
            when 64 =>
              report "width 64 bits";
              for ctr in 0 to 7 loop
                for i in 0 to 7 loop
                  output_register(width-1-i-(8*ctr)) <= temp_register(i+(8*ctr));
                end loop;
              end loop;
            when others =>
              report "Invalid size!";
          end case;
          state <= COMPLETE;
        when COMPLETE =>
          temp_register <= (others => '0');
          state <= FETCH;
        when others =>
        end case;
    end if;
  end process;
end architecture MOVBE_ARC;
```

### Instruksi 2
```vhdl
-- PMINSW
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity PMINSW is
  port (
    clk : in std_logic;
    res : in std_logic;
    en : in std_logic;
    operandA : in std_logic_vector(63 downto 0);
    operandB : in std_logic_vector(63 downto 0);
    output : out std_logic_vector(63 downto 0)
  );
end entity PMINSW;

architecture PMINSW_ARC of PMINSW is
  type State_Type is (FETCH, DECODE, EXECUTE, COMPLETE);
  signal state : State_Type := FETCH;
  signal prog_ctr : integer := 0;
  signal word_registerA : std_logic_vector(15 downto 0);
  signal word_registerB : std_logic_vector(15 downto 0);
  signal word_registerC : std_logic_vector(15 downto 0);
  signal word_registerD : std_logic_vector(15 downto 0);
begin
  process (clk, res) is
  begin
    if res = '1' then
      state <= FETCH;
      prog_ctr <= 0;
      word_registerA <= (others => '0');
      word_registerB <= (others => '0');
      word_registerC <= (others => '0');
      word_registerD <= (others => '0');
    elsif rising_edge(clk) then
      case state is
        when FETCH =>
          if en = '1' then
            state <= DECODE;
            prog_ctr <= 1;
          end if;
        when DECODE =>
          state <= EXECUTE;
          word_registerA <= (others => '0');
          word_registerB <= (others => '0');
          word_registerC <= (others => '0');
          word_registerD <= (others => '0');
          prog_ctr <= 2;
        when EXECUTE =>
          if signed(operandA(15 downto 0)) < signed(operandB(15 downto 0)) then
            word_registerA <= operandA(15 downto 0);
          else
            word_registerA <= operandB(15 downto 0);
          end if;
          if signed(operandA(31 downto 16)) < signed(operandB(31 downto 16)) then
            word_registerB <= operandA(31 downto 16);
          else
            word_registerB <= operandB(31 downto 16);
          end if;
          if signed(operandA(47 downto 32)) < signed(operandB(47 downto 32)) then
            word_registerC <= operandA(47 downto 32);
          else
            word_registerC <= operandB(47 downto 32);
          end if;
          if signed(operandA(63 downto 48)) < signed(operandB(63 downto 48)) then
            word_registerD <= operandA(63 downto 48);
          else
            word_registerD <= operandB(63 downto 48);
          end if;
          state <= COMPLETE;
          prog_ctr <= 3;
        when COMPLETE =>
          output(63 downto 48) <= word_registerD;
          output(47 downto 32) <= word_registerC;
          output(31 downto 16) <= word_registerB;
          output(15 downto 0) <= word_registerA;
          state <= FETCH;
          prog_ctr <= 0;
        when others =>
      end case;
    end if;
  end process;
end architecture PMINSW_ARC;
```

### Instruksi 3
```vhdl
-- VPCMPUB
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity VPCMPUB is
  port (
    clk : in std_logic;
    res : in std_logic;
    en : in std_logic;
    comparison_predicate : in std_logic_vector(7 downto 0);

    -- Sebenarnya dilakukan untuk width 128/16, 256/32, 512/64 bit
    -- Tapi supaya muat di sim, dijadiin 64/8 bit (output 8 bit)
    operandA : in std_logic_vector(63 downto 0);
    operandB : in std_logic_vector(63 downto 0);
    output : out std_logic_vector(7 downto 0)
  );
end entity VPCMPUB;

architecture VPCMPUB_ARC of VPCMPUB is
  type State_Type is (FETCH, DECODE, EXECUTE, COMPLETE);
  signal state : State_Type := FETCH;
  signal prog_ctr : integer := 0;
  signal comp_mode : std_logic_vector(2 downto 0) := "000";
  signal output_register : std_logic_vector(7 downto 0);
begin
  process (clk, res) is
    variable j : integer := 0;
    begin
      if res = '1' then
        state <= FETCH;
        prog_ctr <= 0;
        comp_mode <= "000";
      elsif rising_edge(clk) then
        case state is
          when FETCH =>
            if en = '1' then
              state <= DECODE;
              prog_ctr <= 1;
            end if;
          when DECODE =>
            state <= EXECUTE;
            comp_mode <= comparison_predicate(2 downto 0);
            prog_ctr <= 2;
          when EXECUTE =>
            state <= COMPLETE;
            case comp_mode is
              -- Mode comparator EQUALS
              when "000" =>
                for i in 0 to 7 loop
                  j := i*8;
                  if operandA(j+7 downto j) = operandB(j+7 downto j) then
                    output_register(i) <= '1';
                  else
                    output_register(i) <= '0';
                  end if;
                end loop;

              -- Mode comparator LESS THAN
              when "001" =>
                for i in 0 to 7 loop
                  j := i*8;
                  if unsigned(operandA(j+7 downto j)) < unsigned(operandB(j+7 downto j)) then
                    output_register(i) <= '1';
                  else
                    output_register(i) <= '0';
                  end if;
                end loop;

              -- Mode comparator LESS THAN/EQUALS
              when "010" =>
                for i in 0 to 7 loop
                  j := i*8;
                  if unsigned(operandA(j+7 downto j)) > unsigned(operandB(j+7 downto j)) then
                    output_register(i) <= '0';
                  else
                    output_register(i) <= '1';
                  end if;
                end loop;
              
              -- Mode comparator ALWAYS FALSE
              when "011" =>
                output_register <= (others => '0');

              -- Mode comparator NOT EQUALS
              when "100" =>
                for i in 0 to 7 loop
                  j := i*8;
                  if operandA(j+7 downto j) = operandB(j+7 downto j) then
                    output_register(i) <= '0';
                  else
                    output_register(i) <= '1';
                  end if;
                end loop;

              -- Mode comparator GREATER THAN
              when "101" =>
                for i in 0 to 7 loop
                  j := i*8;
                  if unsigned(operandA(j+7 downto j)) > unsigned(operandB(j+7 downto j)) then
                    output_register(i) <= '1';
                  else
                    output_register(i) <= '0';
                  end if;
                end loop;

              -- Mode comparator GREATER THAN/EQUALS
              when "110" =>
                for i in 0 to 7 loop
                  j := i*8;
                  if unsigned(operandA(j+7 downto j)) < unsigned(operandB(j+7 downto j)) then
                    output_register(i) <= '0';
                  else
                    output_register(i) <= '1';
                  end if;
                end loop;

              -- Mode comparator ALWAYS TRUE
              when "111" =>
                output_register <= (others => '1');

              when others =>
            end case;
            prog_ctr <= 3;
          when COMPLETE =>
            output <= output_register;
            state <= FETCH;
            prog_ctr <= 0;
          when others =>
        end case;
      end if;
    end process;
end architecture VPCMPUB_ARC;

-- EQUALS
-- 00000000
-- OP 1
-- 0001100001010000010000011000001011010010110101010010000000010001
-- OP 2
-- 0001100001010000011100011000001011010010110101010010000010010001
```

**Referensi:**
- F. Cloutier, "MOVBE — Move Data After Swapping Bytes," x86 and amd64 instruction reference, Available: https://www.felixcloutier.com/x86/movbe [Accessed 11 Nov. 2024].
- F. Cloutier, "PMINSB/PMINSW — Minimum of Packed Signed Integers," x86 and amd64 instruction reference, Available: https://www.felixcloutier.com/x86/pminsb:pminsw [Accessed 11 Nov. 2024].
- F. Cloutier, "VPCMPB/VPCMPUB — Compare Packed Byte Values Into Mask," x86 and amd64 instruction reference, Available: https://www.felixcloutier.com/x86/vpcmpb:vpcmpub#tbl-5-21 [Accessed 11 Nov. 2024].

## 3. Screenshot hasil simulasi waveform pada modelsim atau Vivado dan paste ke sini
| MOVBE | PMINSW | VPCMPUB |
| --- | --- | --- |
| ![Screenshot 2024-11-11 203253](https://github.com/user-attachments/assets/973ec2a9-08b8-4e4f-ae60-acd2116cb98f) | ![Screenshot 2024-11-11 211313](https://github.com/user-attachments/assets/cd9d7046-e44b-475d-a859-4ffe295a85ca) | ![Screenshot 2024-11-11 214826](https://github.com/user-attachments/assets/8ae8eb45-d203-466f-b87f-bc3b7b0e6162) |

    Jika ada screenshot lebih, silakan tambahkan sendiri

## 4. Jelaskan cara kerja mengenai instruksi instruksi yang kalian pilih!

### Instruksi 1

MOVBE adalah instruksi sederhana yang akan pertama-tama menukar urutan bit input dan barulah dikeluarkan ke output. Contohnya bila input adalah `0010`, maka di output akan menghasilkan `0100`.

### Instruksi 2

PMINSW adalah instruksi yang melihat angka yang lebih rendah pada berbagai kumpulan data berukuran word (16 bit). Misalkan terdapat 2 pasangan word-sized data, yaitu (FA3B, A22B) dan (223F, FF46). Maka, output akan mengembalikan nilai A22B223F.

### Instruksi 3

VPCMPUB adalah instruksi comparator multifungsi. Terdapat 6 jenis comparator yang bisa dipakai (secara teknis 8), yaitu untuk jenis =, !=, <, <=, >, >=. Sama seperti PMINSW, VPCMPUB berbentuk SIMD, yang akan mengambil berbagai data unsigned byte dan mengembalikan hasil comparisonnya.


**Referensi:**
- F. Cloutier, "MOVBE — Move Data After Swapping Bytes," x86 and amd64 instruction reference, Available: https://www.felixcloutier.com/x86/movbe [Accessed 11 Nov. 2024].
- F. Cloutier, "PMINSB/PMINSW — Minimum of Packed Signed Integers," x86 and amd64 instruction reference, Available: https://www.felixcloutier.com/x86/pminsb:pminsw [Accessed 11 Nov. 2024].
- F. Cloutier, "VPCMPB/VPCMPUB — Compare Packed Byte Values Into Mask," x86 and amd64 instruction reference, Available: https://www.felixcloutier.com/x86/vpcmpb:vpcmpub#tbl-5-21 [Accessed 11 Nov. 2024].
