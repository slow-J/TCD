----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 11:23:20 AM
-- Design Name: 
-- Module Name: mux_2_1 - Behavioral
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

entity mux_2_1 is
    Port ( 
            I0, S0, S1 : in STD_LOGIC;
			Z : out STD_LOGIC
          );
end mux_2_1;

architecture Behavioral of mux_2_1 is

begin
    Z <= 	S0 after 1ns when I0= '1' else
				S1 after 1ns when I0 = '0' else
				'0' after 1ns;

end Behavioral;
