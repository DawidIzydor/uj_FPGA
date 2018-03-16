-- Zestaw bibliotek na wszystkie zajecia
-- "Nie bedziemy ich specjalnie zmieniac"
-- Prowadz?cy, 2-03-2018

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
    DISP : out std_logic_vector (7 downto 0);
    RESET: in std_logic; -- nie ma jeszcze w XDC
    KEY_COL: inout std_logic_vector(3 downto 0);
    KEY_ROW: inout std_logic_vector(3 downto 0);
    SW : in std_logic_vector (3 downto 0)
    );
end cw2;

architecture fsm_lab of cw2 is

type FSM_KEY_LCD is (A, B, C, D, E, F, G, H, I);
signal FSM_KEY_LCD_CURRENT, FSM_KEY_LCD_NEXT : FSM_KEY_LCD;
--signal reset : std_logic;

type KEY_DECODE_FSM is (IDLE, READ_ROW, SET_ROW, READ_COL);
signal key_decode_fsm_sig : KEY_DECODE_FSM;
signal saved_row, saved_col : std_logic_vector (3 downto 0);
signal saved_row_col: std_logic_vector( 7 downto 0);
signal key_hex : std_logic_vector (3 downto 0);
begin

-- maszyna stanu ktora odczytuje wartosci
KEY_DECODE: process(CLK)
begin
    if rising_edge(CLK) then
        if RESET = '1' then
               key_decode_fsm_sig <= IDLE;
               KEY_ROW <= (others => 'Z');
               KEY_COL <= (others => '0');
               saved_col <= (others => '0');
               saved_row <= (others => '0');
        else
                case key_decode_fsm_sig is
                when IDLE =>
                    KEY_ROW <= (others => 'Z');
                    KEY_COL <= (others => '0');
                    saved_row <= saved_row;
                    saved_col <= saved_col;
                    if KEY_ROW /= x"f" then
                        key_decode_fsm_sig <= READ_ROW;
                    else
                        key_decode_fsm_sig <= IDLE;
                    end if;
                when READ_ROW =>
                    KEY_ROW <= (others => 'Z');
                    KEY_COL <= (others => '0');
                    saved_row <= KEY_ROW;
                    saved_col <= saved_col;
                    key_decode_fsm_sig <= SET_ROW;
                when SET_ROW =>
                    KEY_ROW <= x"0";
                    KEY_COL <= (others => 'Z');
                    saved_row <= saved_row;
                    saved_col <= saved_col;
                    key_decode_fsm_sig <= READ_COL;
                when READ_COL => 
                    KEY_ROW <= x"0";
                    KEY_COL <= (others => 'Z');
                    saved_row <= saved_row;
                    saved_col <= KEY_COL;
                    key_decode_fsm_sig <= IDLE;
                end case;
       end if;
   end if;
end process;

saved_row_col(7 downto 4) <= saved_row;
saved_row_col(3 downto 0) <= saved_col;

KEY_TO_HEX: process(CLK)
begin 
    if rising_edge(CLK) then
    key_hex <= saved_row;
        case saved_row_col is
            when x"ee" =>
                key_hex <= x"1";
            when x"ed" =>
                key_hex <= x"4";
            when x"eb" =>
                key_hex <= x"7";
            when x"e7" =>
                key_hex <= x"A";
            when x"de" =>
                key_hex <= x"4";
            when x"dd" =>
                key_hex <= x"5";
            when x"db" =>
                key_hex <= x"6";
            when x"d7" =>
                key_hex <= x"B";
            when x"be" =>
                key_hex <= x"7";
            when x"bd" =>
                key_hex <= x"8";
            when x"bb" =>
                key_hex <= x"9";
            when x"b7" =>
                key_hex <= x"C";
            when x"7e" =>
                key_hex <= x"0";
            when x"7d" =>
                key_hex <= x"F";
            when x"7b" =>
                key_hex <= x"E";
            when x"77" =>
                key_hex <= x"D";
            when others =>
                key_hex <= x"F";
        end case;  
    end if;
end process KEY_TO_HEX;

--reset <= KEY_COL(3) and KEY_ROW(3);

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
--DISP <=x"77";
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
