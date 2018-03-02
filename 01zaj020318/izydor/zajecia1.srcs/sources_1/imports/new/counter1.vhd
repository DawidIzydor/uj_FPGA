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

entity up_down_counter is
    generic (
        NUMBER_OF_BITS : integer := 28
     );
    port (
         CLK : in std_logic;
         RESET : in std_logic;
         LED : out std_logic_vector(3 downto 0);
         UP_IN : in std_logic;
         DOWN_IN : in std_logic
         );
end up_down_counter;

architecture up_down_counter of up_down_counter is
signal counter: unsigned(NUMBER_OF_BITS-1 downto 0);
begin

COUNTER_PROC: process(CLK)
begin
    if rising_edge(CLK) then
        if RESET = '1' then
            counter <= (others =>'0');
        elsif UP_IN = '1' and DOWN_IN = '0' then
            counter <= counter +1;
        elsif UP_IN = '0' and DOWN_IN = '1' then
            counter <= counter -1;
        else
            counter <= counter;
        end if;
    end if;
END process COUNTER_PROC;

LED <= std_logic_vector(counter(27 downto 24));

end up_down_counter;
