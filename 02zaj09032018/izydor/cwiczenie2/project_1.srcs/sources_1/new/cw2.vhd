-- Zestaw bibliotek na wszystkie zajecia
-- "Nie bedziemy ich specjalnie zmieniac"
-- Prowadz¹cy, 2-03-2018

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity cw2 is
    Port (
    CLK : in std_logic;
  --  RESET: in std_logic;
    DISP: out std_logic_vector(7 downto 0);
    KEY_COL: in std_logic_vector(3 downto 0);
    KEY_ROW: in std_logic_vector(3 downto 0)
    );
end cw2;

architecture fsm_lab of cw2 is

type FSM_KEY_LCD is (A, B, C, D, E, F, G, H, I);
signal FSM_KEY_LCD_CURRENT, FSM_KEY_LCD_NEXT : FSM_KEY_LCD;
signal reset : std_logic;
begin

reset <= KEY_COL(3) and KEY_ROW(3);
FSM_KEY_LCD_PROC: process(CLK)
begin
    if rising_edge(CLK) then
        if RESET = '1' then
            FSM_KEY_LCD_CURRENT <= A;
        else
            FSM_KEY_LCD_CURRENT <= FSM_KEY_LCD_NEXT;
        end if;
    end if;

END process FSM_KEY_LCD_PROC;

FSM_KEY_LCD_COMB: process(CLK)
begin
DISP <=x"77";
case FSM_KEY_LCD_CURRENT is
    when A =>
        DISP <= x"11";
        if KEY_ROW = x"1" and KEY_COL = x"4" then
           FSM_KEY_LCD_NEXT <= B;
        elsif KEY_ROW = x"2" and KEY_COL = x"2" then
           FSM_KEY_LCD_NEXT <= G;
        else
           FSM_KEY_LCD_NEXT <= A;
        end if;

   when B =>
        DISP <= x"22";
        if KEY_ROW = x"4" and KEY_COL = x"1" then 
          FSM_KEY_LCD_NEXT <= C;
        else
          FSM_KEY_LCD_NEXT <= B;
        end if;
        
    when C =>
        DISP <= x"33";
        if KEY_ROW = x"4" and KEY_COL = x"2" then 
             FSM_KEY_LCD_NEXT <= F;
         else
             FSM_KEY_LCD_NEXT <= C;
         end if;
         
    when D =>
        DISP <= x"44";
        if KEY_ROW = x"1" and KEY_COL = x"1" then 
            FSM_KEY_LCD_NEXT <= G;
        else
            FSM_KEY_LCD_NEXT <= D;
        end if;
        
    when E =>
        DISP <= x"55";
        if KEY_ROW = x"0" and KEY_COL = x"0" then 
            FSM_KEY_LCD_NEXT <= D;
        else
            FSM_KEY_LCD_NEXT <= E;
        end if;
        
   when F =>
        DISP <= x"66";
        if KEY_ROW = x"4" and KEY_COL = x"4" then 
          FSM_KEY_LCD_NEXT <= G;
        else
          FSM_KEY_LCD_NEXT <= F;
        end if;
        
    when G =>
        DISP <= x"77";
        if KEY_ROW = x"1" and KEY_COL = x"2" then 
          FSM_KEY_LCD_NEXT <= H;
        else
          FSM_KEY_LCD_NEXT <= G;
        end if;
        
     when H =>
        DISP <= x"88";
        if KEY_ROW = x"1" and KEY_COL = x"4" then 
          FSM_KEY_LCD_NEXT <= I;
        else
          FSM_KEY_LCD_NEXT <= H;
        end if;
        
    when I =>
        DISP <= x"99";
        if KEY_ROW = x"1" and KEY_COL = x"8" then 
          FSM_KEY_LCD_NEXT <= A;
        else
          FSM_KEY_LCD_NEXT <= I;
        end if;
        
end case;

END process FSM_KEY_LCD_COMB;


end fsm_lab;
