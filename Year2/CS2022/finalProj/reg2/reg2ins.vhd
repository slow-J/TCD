----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 01:33:04 PM
-- Design Name: 
-- Module Name: reg2ins - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg2ins is
    Port ( 
        D : in STD_LOGIC_VECTOR(15 downto 0);
        load0, load1, Clk : in STD_LOGIC;
        Q : out STD_LOGIC_VECTOR(15 downto 0)   
        );
end reg2ins;

architecture Behavioral of reg2ins is

begin
    process (Clk)
		begin
			if(rising_edge(Clk)) then
				if((load0 =  '1') and (load1 = '1')) then
					Q <= D after 5ns;
				end if;
			end if;
	end process;

end Behavioral;
