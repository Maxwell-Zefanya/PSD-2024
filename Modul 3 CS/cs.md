# Case Study Modul 3
```
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

*PENAMAAN PADA TIAP FILE KODE DIBEBASKAN ASALKAN REPRESENTATIF TERHADAP ISINYA*

*Misal : **Nomor1.vhd***

## Part 1 (Based on TP)
### 1. Berdasarkan fungsi aljabar dari rangkaian yang telah dibuat di Tugas Pendahuluan, deskripsikanlah fungsi tersebut ke dalam program VHDL.  
    Note : Gunakan tipe data std_logic_vector untuk input (3 bit) dan std_logic untuk output (7 port output yaitu s1, s2, s3, s4, s5, s6, s7).

Kode :
```vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity nomorsatu is
  port (
    A	: in std_logic_vector(2 downto 0);
    S1	: out std_logic;
    S2	: out std_logic;
    S3	: out std_logic;
    S4	: out std_logic;
    S5	: out std_logic;
    S6	: out std_logic;
    S7	: out std_logic
  );
end entity nomorsatu;

architecture display of nomorsatu is

begin

    S1 <= (A(1) and not A(2)) or (A(0) and A(1)) or (not A(0) and not A(2));
    S2 <= (A(0) and not A(1)) or (A(1) and not A(2));
    S3 <= A(0) or (A(1) and not A(2));
    S4 <= A(0) or A(2);
    S5 <= not A(0) or not A(1);
    S6 <= not A(0) or A(1) or A(2);
    S7 <= (A(0) XOR A(2)) or (A(0) and A(1));

end architecture display;
```


### 2. Tes rangkaian **Nomor 1** pada ModelSim untuk memastikan rangkaian kalian benar. Screenshot!
![image](https://github.com/user-attachments/assets/bfcbfe0e-ed0a-48eb-b84f-547fd4659a5a)


### 3. Buatlah rangkaian *Decoder 3 to 8* yang sama tetapi tidak menggunakan fungsi aljabar boolean. Melainkan, menggunakan behavior style untuk membuat rangkaian ini. Berikan juga report statement dengan severity **note** pada awal process menggunakan template **NamaLengkap_NPM**

    Hint : Gunakan process statement dengan conditional statement (switch case / if else)

Kode :
```vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity nomorsatu is
  port (
    A	: in std_logic_vector(2 downto 0);
    S	: out std_logic_vector(6 downto 0)
  );
end entity nomorsatu;

architecture display of nomorsatu is

begin

    process(A) is
    begin
	case A is
	    when "000" => S <= "1000110";
	    when "001" => S <= "1001111";
	    when "010" => S <= "1110110";
	    when "011" => S <= "0001111";
	    when "100" => S <= "0111101";
	    when "101" => S <= "1111110";
	    when "110" => S <= "1111011";
	    when "111" => S <= "1011011";
	    when others => S <= "0000000";
	end case;
    report "Maxwell Zefanya_2306221200" severity note;
    end process;

end architecture display;
```



### 4. Tes rangkaian **Nomor 3** pada ModelSim untuk memastikan rangkaian kalian benar. Screenshot!
![image](https://github.com/user-attachments/assets/b80c70b9-e37d-433d-9fa2-510204477564)

### 5. Lakukan Sintesis RTL pada Nomor 1 dan 3, kemudian bandingkanlah hasilnya!

| Screenshot Nomor 1 | Screenshot Nomor 3 |
|--------------------|---------------------|
|![image](https://github.com/user-attachments/assets/9d0dc16f-0b11-4358-aead-def882134d31)|![image](https://github.com/user-attachments/assets/5878dd85-75d4-4e6c-8da3-65183b58af27)|

Pada nomor 1, rangkaian menggunakan berbagai logic gate, sedangkan pada nomor 3, rangkaian menggunakan mux


## Part 2
### 6. Buatlah sebuah counter yang bekerja dengan sistem ```falling edge triggered```. Counter ini akan menghitung mundur (-1) bit pada bit yang diinput oleh user (```Tidak boleh sampai 0```) dan kemudian berulang kembali. Input berukuran 4 bit dan berbentuk positif. Output juga berukuran 4 bit. Berikan juga report statement dengan severity **note** pada saat looping menggunakan kata "LOOP"

**Contoh**

Input : 0101 (5)

0101 (5) -> 0100 (4) -> 0011 (3) -> 0010 (2) -> 0001 (1) -> (LOOP) 0101 (5) -> 0100 (4) 

    Note : Gunakan behavioral style dan conditional statement untuk membuat rangkaian ini. Tidak perlu membuat truth table, kmap, dsb.

Kode :
```vhdl
library IEEE;
use IEEE.std_logic_1164.all;

entity partdua is
  port (
    clk	: in std_logic;
    inp : in std_logic_vector(3 downto 0);
    ctr	: out std_logic_vector(3 downto 0)
  );
end entity partdua;

architecture counter of partdua is
    signal temp : std_logic_vector(3 downto 0) := inp;
begin
    process(clk) is
    begin
    ctr <= temp;
	if(falling_edge(clk)) then
	    case temp is
		when "1111" => temp <= "1110";
		when "1110" => temp <= "1101";
		when "1101" => temp <= "1100";
		when "1100" => temp <= "1011";
		when "1011" => temp <= "1010";
		when "1010" => temp <= "1001";
		when "1001" => temp <= "1000";
		when "1000" => temp <= "0111";
		when "0111" => temp <= "0110";
		when "0110" => temp <= "0101";
		when "0101" => temp <= "0100";
		when "0100" => temp <= "0011";
		when "0011" => temp <= "0010";
		when "0010" => temp <= "0001";
		when "0001" => temp <= inp;
		when others => temp <= "0000";
	    end case;
	end if;
    report "Maxwell Zefanya_2306221200" severity note;
    end process;

end architecture counter;
```


### 7. Tes rangkaian anda pada ModelSim untuk memastikan rangkaian kalian benar. Screenshot!
![depositphotos_227724992-stock-illustration-image-available-icon-flat-vector](https://github.com/user-attachments/assets/06aaaaf7-d6a7-4da8-a9db-ea421ae7f9a5)

Contoh hasil tes pada rangkaian yang benar:
![Screenshot 2024-09-12 211220](https://github.com/user-attachments/assets/2c9b172c-e52f-4e9e-8ed8-3d7ba1b63ad1)


### 8. Berikan kesimpulan dalam bentuk poin-poin
- Penggunaan proses dapat mensimulasikan for loop seperti C
- Penggunaan vector logic dapat mempercepat perangkaian bila bit banyak
