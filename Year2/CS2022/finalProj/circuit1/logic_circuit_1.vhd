----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2018 03:44:22 PM
-- Design Name: 
-- Module Name: logic_circuit_1 - Behavioral
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

entity logic_circuit_1 is
Port(
		a_logic_in, b_logic_in : in STD_LOGIC_VECTOR(15 downto 0);
		select_in : in STD_LOGIC_VECTOR(1 downto 0);
		logic_output_1 : out STD_LOGIC_VECTOR(15 downto 0)
	 );
end logic_circuit_1;

architecture Behavioral of logic_circuit_1 is

begin
    logic_output_1 <= 	(a_logic_in and b_logic_in) after 1ns when select_in = "00" else
								(a_logic_in or b_logic_in) after 1ns when select_in = "01" else
								(a_logic_in xor b_logic_in) after 1ns when select_in = "10" else
								(not (a_logic_in)) after 1ns;

end Behavioral;
