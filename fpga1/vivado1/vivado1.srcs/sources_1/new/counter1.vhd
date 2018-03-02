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

entity counter1 is
--  Port ( );
end counter1;

entity up_down_counter is
    generic {
        NUMBER_OF_BITS : integer
     };
    port {
         CLK : in std_logic;
         RESET : in std_logic;
         COUNT_OUT : out std_logic_vector(NUMBER_OF_BITS-1 downto 0);
         UP_IN : in std_logic;
         DOWN_IN : in std_logic
         };
end up_down_counter;

architecture up_down_counter of counter 1 is
begin
    if rising_edge(CLR) then
        if RESET = '1' then
            counter <= (others ->'0');
        elsif UP_IN = '1' and DOWN_IN = '0' then
            counter <= counter +1;
        elsif UP_IN = '1' and DOWN_IN = '1' then
            counter <= counter -1;
        else
            counter <= counter;
        end
    end

end up_down_counter;

architecture Behavioral of counter1 is

begin


end Behavioral;
