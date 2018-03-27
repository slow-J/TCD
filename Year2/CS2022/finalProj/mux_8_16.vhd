----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2018 11:37:38 AM
-- Design Name: 
-- Module Name: mux_8_16 - Behavioral
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

entity mux_8_16 is
  Port ( 	
            s0, s1, s2, s3 : in STD_LOGIC;
            in0, in1, in2, in3, in4, in5, in6, in7, in8 : in STD_LOGIC_VECTOR(15 downto 0);
            z : out STD_LOGIC_VECTOR(15 downto 0)
        );
end mux_8_16;

architecture Behavioral of mux_8_16 is

begin
    z <=   in0 after 5ns when s0 = '0' and s1 = '0' and s2 = '0' and s3 = '0' else
	       in1 after 5ns when s0 = '0' and s1 = '0' and s2  = '0' and s3 = '1' else
	       in2 after 5ns when s0 = '0' and s1 = '0' and s2  = '1' and s3 = '0' else
	       in3 after 5ns when s0 = '0' and s1 = '0' and s2 = '1' and s3 = '1' else
	       in4 after 5ns when s0 = '0' and s1 = '1' and s2 = '0' and s3 = '0' else
	       in5 after 5ns when s0 = '0' and s1 = '1' and s2 = '0' and s3 = '1' else
	       in6 after 5ns when s0 = '0' and s1 = '1' and s2 = '1' and s3 = '0' else
	       in7 after 5ns when s0 = '0' and s1 = '1' and s2 = '1' and s3 = '1' else
	       in8 after 5ns when s0 = '1' and s1 = '0' and s2 = '0' and s3 = '0' else
	       "0000" after 5ns;

end Behavioral;
