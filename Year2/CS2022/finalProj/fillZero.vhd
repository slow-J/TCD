----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 11:53:12 AM
-- Design Name: 
-- Module Name: fillZero - Behavioral
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

entity fillZero is
  Port (
        SB_in : in STD_LOGIC_VECTOR(2 downto 0);
		zero_fill : out STD_LOGIC_VECTOR(15 downto 0)
         );
end fillZero;

architecture Behavioral of fillZero is
	signal ZeroFill : STD_LOGIC_VECTOR(15 downto 0);
begin
    ZeroFill(2 downto 0) <= SB_in;
    ZeroFill(15 downto 3) <= "0000000000000";

end Behavioral;
