----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2018 03:41:14 PM
-- Design Name: 
-- Module Name: mux_3_1 - Behavioral
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

entity mux_3_1 is
 Port (
        In0, In1, In2 : in STD_LOGIC;
		S0, S1 : in STD_LOGIC;
		Z : out STD_LOGIC
		 );
end mux_3_1;

architecture Behavioral of mux_3_1 is

begin
    Z <= 	In0 after 1ns when S0 = '0' and S1 = '0' else
			In1 after 1ns when S0 = '0' and S1 = '1' else
			In2 after 1ns when S0 = '1' and S1 = '0' else
			'0' after 1ns;

end Behavioral;
