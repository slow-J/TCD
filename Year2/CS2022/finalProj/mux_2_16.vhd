----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2018 11:31:26 AM
-- Design Name: 
-- Module Name: mux_2_16 - Behavioral
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


entity mux_2_16 is
  port ( 
            in0, in1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			z : out STD_LOGIC_VECTOR(15 downto 0)
		);
end mux_2_16;

architecture Behavioral of mux_2_16 is

begin
    z <= 	in0 after 5ns when s = '0' else
			in1 after 5ns when s = '1' else
			x"0000" after 5ns;

end Behavioral;
