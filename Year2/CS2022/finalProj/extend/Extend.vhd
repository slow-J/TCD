----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 12:12:41 PM
-- Design Name: 
-- Module Name: Extend - Behavioral
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

-- extend pc
entity Extend is
    Port( 
        SR_SB : in  STD_LOGIC_VECTOR (5 downto 0);
        extend_out : out  STD_LOGIC_VECTOR (15 downto 0)
        );
end Extend;

architecture Behavioral of Extend is
    signal sig_output : STD_LOGIC_VECTOR (15 downto 0);
begin
	sig_output(15 downto 6) <=  "0000000000" when SR_SB(5) = '0' else "1111111111";
	sig_output(5 downto 0)  <= SR_SB;
	extend_out <= sig_output;

end Behavioral;
