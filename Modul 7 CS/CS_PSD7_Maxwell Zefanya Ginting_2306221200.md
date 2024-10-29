# Case Study Modul 7

```plaintext
Nama    : Maxwell Zefanya Ginting
NPM     : 2306221200
```

## 1. Lampirkan Kode dan Hasil Running 

```vhd
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

entity CS is
  port (
    AtackerBaseDamage : in std_logic_vector(7 downto 0);
    AtackerCritChance : in std_logic_vector(7 downto 0);
    AtackerCritDamage : in std_logic_vector(7 downto 0);
    DefenderHealth : in std_logic_vector(7 downto 0);

    -- 3 type (00 => Fire, 01 => Water, 10 => Grass)
    AtackerDamageType : in std_logic_vector(1 downto 0);
    DefenderType : in std_logic_vector(1 downto 0);

    DamageDealt : out std_logic_vector(7 downto 0);
    NewHealth : out std_logic_vector(7 downto 0)
  );
end entity CS;

architecture rtl of CS is
  
begin
  process (AtackerBaseDamage, AtackerCritChance, AtackerCritDamage, AtackerDamageType, DefenderHealth, DefenderType) is

    function TypeCalc (
        DefenderType : integer := 1;
        DamageType : integer := 1;
        Damage : positive := 1
      ) return positive is
    begin
      if DefenderType = DamageType then
        return Damage;
      end if;

      case DamageType is
      when 0 =>
        case DefenderType is
        -- Fire - Water 0.5x
        when 1 =>
          return positive(round(real(Damage)*real(0.5)));
        -- Fire - Grass 2x
        when 2 =>
          return positive(Damage*2);
        when others =>
        end case;

      when 1 =>
        case DefenderType is
        -- Water - Fire 2x
        when 0 =>
          return positive(Damage*2);
        -- Water - Grass 0.5x
        when 2 =>
          return positive(round(real(Damage)*real(0.5)));
        when others =>
        end case;

      when 2 =>
        case DefenderType is
        -- Grass - Fire 0.5x
        when 0 =>
          return positive(round(real(Damage)*real(0.5)));
        -- Grass - Water 2x
        when 1 =>
          return positive(Damage*2);
        when others =>
        end case;
      when others =>
      end case;
    end function;
    
    variable seed1_reg : positive := 1;
    variable seed2_reg : positive := 2;

    impure function CritCalc(
        BaseDamage : positive := 1;
        CritChance : positive := 1;
        CritDamage : positive := 1
      ) return positive is
      variable r : real;
      variable prob : real;
      variable DamageAfterCrit : positive;
    begin
      uniform (seed1_reg, seed2_reg, r);
      report "R: "&real'image(r);
      
      seed1_reg := positive(round(r+real(1)));
      seed2_reg := positive(round((r+real(1))*real(65535)));

      if positive(round(real(r)*real(100))) < CritChance then
        return positive(
          round(
            real(BaseDamage) * real(1) + real(integer(CritDamage/100))
          )
        );
      else
        return BaseDamage;
      end if;
      prob := real(1+(CritDamage)/100);
      DamageAfterCrit := positive(real(BaseDamage));
      r := r + real(0.9);
      return positive(round(r));
    end function;
    
    procedure HealthCalc (
      variable Health : in integer;
      variable Damage : in integer;
      variable NewHealth : out integer
    ) is 
    begin
      NewHealth := Health - Damage;
    end procedure;

    variable CC : positive; -- Crit chance
    variable DAT : positive; -- After type
    variable DAC : positive; -- After crit
    variable DD : positive;

    variable HBD : integer; -- Health before dmg
    variable HAD : integer; -- Health after dmg
  begin
    CC := positive(to_integer(unsigned(AtackerCritChance)) * 100 / 255  );
    DAT := TypeCalc(positive(to_integer(unsigned(DefenderType))), positive(to_integer(unsigned(AtackerDamageType))), positive(to_integer(unsigned((AtackerBaseDamage)))));
    DAC := CritCalc(positive(to_integer(unsigned((AtackerBaseDamage)))), CC, positive(to_integer(unsigned(AtackerCritDamage))));

    DD := DAT + DAC;
    HBD := positive(to_integer(unsigned(DefenderHealth)));

    HealthCalc(HAD, DD, HAD);

    DamageDealt <= std_logic_vector(to_unsigned(DD, 8));
    NewHealth <= std_logic_vector(to_unsigned(HAD, 8));
  end process;
end architecture rtl;
```

![gambar]()

## 2. Jelaskan mengapa kode anda sesuai kriteria

Kode sudah berjalan dengan kriteria, dimana terdapat function untuk menghitung damage setelah type, impure function untuk menghitung damage setelah crit, dan procedure untuk menghitung health setelah terkena damage crit + damage. Selain itu, perhitungan untuk crit damage juga memasukkan crit chance sebagai faktornya. Terakhir, output dari rangkaiannya sudah sesuai, yaitu damage yang dihasilkan dan health dari defender setelah terkena damage.
