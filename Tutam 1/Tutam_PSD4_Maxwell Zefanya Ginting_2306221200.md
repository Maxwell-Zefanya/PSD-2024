# Tugas Tambahan Modul 1-4
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

# Kode
Kode main:
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity elevator is
  Port (
    -- Floor pertama ada pada MSB dan floor ke-10 ada pada LSB
    choice : in std_logic_vector (9 downto 0);
    location : inout std_logic_vector (9 downto 0) := "1000000000";
    clk : in std_logic
  );
end elevator;

architecture elevator_arch of elevator is
begin
  process(clk) is
    -- Variabel untuk algoritma pengecekan floor dan choice
    variable is_below : std_logic;
    -- Variabel holding untuk choice dan mode
    variable hold : std_logic_vector(9 downto 0);
    variable mode : std_logic_vector(1 downto 0);
  begin
    -- Inisialisasi value awal
    is_below := '1';
    mode := "00";
    -- Kode akan dijalankan berdasarkan clock untuk simulasi kondisi tidak berganti secara instan
    if rising_edge(clk) then
      
      -- Checking apakah ada floor yang dipilih
      for i in 9 downto 0 loop
        -- Kode mengecek apakah iterasi ada dibawah atau diatas dari floor sekarang
        if location(i) = '1' then
          is_below := '0';
          next;
        end if;
        -- Kode mengecek floor ingin keatas atau kebawah
        if choice(i) = '1' then
          if is_below = '1' then
            mode := "10";
          else
            mode := "11";
          end if;
        end if;
      end loop;

      -- Lift akan shift_left atau shift_right berdasarkan lantai naik atau turun
      case mode is
        when "10" =>
          location <= std_logic_vector(shift_left(unsigned(location), 1)); -- Turun kebawah
        when "11" =>
          location <= std_logic_vector(shift_right(unsigned(location), 1)); -- Naik keatas
        when others =>
      end case;    
    end if;
  end process;
end elevator_arch;
```
Kode testbench:
```vhdl
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity testbench is
end testbench;

architecture elevator_test of testbench is

component elevator is
  Port (
    -- Floor pertama ada pada MSB dan floor ke-10 ada pada LSB
    choice : inout std_logic_vector (9 downto 0);
    location : inout std_logic_vector (9 downto 0);
    clk : in std_logic
  );
end component elevator;


signal choicetb : std_logic_vector (9 downto 0);
signal locationtb : std_logic_vector (9 downto 0);
signal clktb : std_logic;

begin
  UUT : elevator port map (choicetb, locationtb, clktb);
  tb : process
  begin
    choicetb <= "0000000000";
    clktb <= '0';
    wait for 50 ps;
    clktb <= '1';
    wait for 50 ps;

    -- Setel choice ke lantai 5
    choicetb <= "0000100000";
    -- Tunggu sampai lift sampai tujuan
    for i in 0 to 4 loop
      clktb <= '0';
      wait for 50 ps;
      clktb <= '1';
      wait for 50 ps;
    end loop;
    -- Reset choice ke 0
    choicetb <= "0000000000";
    clktb <= '0';
    wait for 50 ps;
    clktb <= '1';
    wait for 50 ps;

    -- Setel choice ke lantai 3
    choicetb <= "0010000000";
    -- Tunggu sampai lift sampai tujuan
    for i in 0 to 2 loop
      clktb <= '0';
      wait for 50 ps;
      clktb <= '1';
      wait for 50 ps;
    end loop;
    -- Reset choice ke 0
    choicetb <= "0000000000";
    clktb <= '0';
    wait for 50 ps;
    clktb <= '1';
    wait for 50 ps;

    -- Setel choice ke lantai 6
    choicetb <= "0000010000";
    -- Tunggu sampai lift sampai tujuan
    for i in 0 to 3 loop
      clktb <= '0';
      wait for 50 ps;
      clktb <= '1';
      wait for 50 ps;
    end loop;
    -- Reset choice ke 0
    choicetb <= "0000000000";
    clktb <= '0';
    wait for 50 ps;
    clktb <= '1';
    wait for 50 ps;

    -- Setel choice ke lantai 1
    choicetb <= "1000000000";
    -- Tunggu sampai lift sampai tujuan
    for i in 0 to 5 loop
      clktb <= '0';
      wait for 50 ps;
      clktb <= '1';
      wait for 50 ps;
    end loop;
    -- Reset choice ke 0
    choicetb <= "0000000000";
    clktb <= '0';
    wait for 50 ps;
    clktb <= '1';
    wait for 50 ps;

    wait;
  end process;
end elevator_test;
```

# Hasil Running
Hasil running ada pada testbench dari lantai 1 ke 5:  
![image](https://github.com/user-attachments/assets/49c5f492-45dd-4b82-899b-dc2cf295005b)  


# Laporan
Pada tutam akan dibentuk sebuah lift system. Lift akan membawa penumpang dari lantai ia berada ke lantai pada lantai yang dipilih (Misal dari 5 ke 9). Gedung memiliki 10 lantai. Lantai dan pilihannya sendiri dianggap sebagai sebuah logic vector yang berukuran 10 bit, dimana tiap bit merepresentasikan sebuah lantai. Pada kode, lantai pertama ada pada MSB dan lantai kesepuluh ada pada LSB. Dengan begitu, maka perpindahan lantai bisa dilakukan dengan menggunakan shift bit sederhana. Shift bit akan terus dilakukan sampai signal lantai sama dengan signal pilihan. Pada rangkaian clock menjadi pengganti waktu lift untuk berjalan (supaya tidak langsung sampai pada lantai pilihan). Lift sendiri memiliki 3 mode. Jika lift berada pada mode "00" maka lift tidak berjalan, jika "10", maka lift akan kebawah, dan jika "11", maka lift akan naik keatas

Contoh kasus:  
- Initial:
  - Pilihan = "000001" (Lantai 6), lift = "001000" (Lantai 3)
1. lift = "001000", lalu clock
2. lift = "000100", lalu clock
3. lift = "000010", lalu clock
4. lift = "000001", finish. Lift sampai lantai 6. Clock berikutnya tidak akan membuat lift berpindah tempat

# Link Video  
https://www.youtube.com/watch?v=7okg4m5qUck
