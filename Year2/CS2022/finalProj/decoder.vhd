----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/13/2018 11:45:18 AM
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
  Port (
            a0, a1, a2, a3 : in STD_LOGIC;
			q0, q1, q2, q3, q4, q5, q6, q7, q8 : out STD_LOGIC
        );
end decoder;

architecture Behavioral of decoder is

begin
    q0 <= ((not a0) and (not a1) and (not a2) and (not a3)) after 5ns; 
	q1 <= ((not a0) and (not a1) and (a2) and (not a3)) after 5ns;		
	q2 <= ((not a0) and (a1) and (not a2) and (not a3)) after 5ns;		
	q3 <= ((not a0) and (a1) and (a2) and (not a3)) after 5ns;			
	q4 <= ((a0) and (not a1) and (not a2) and (not a3)) after 5ns;		
	q5 <= ((a0) and (not a1) and (a2) and (not a3)) after 5ns;			
	q6 <= ((a0) and (a1) and (not a2) and (not a3)) after 5ns;			
	q7 <= ((a0) and (a1) and (a2) and (not a3)) after 5ns;				
	q8 <= ((not a0) and (not a1) and (not a2) and (a3)) after 5ns;	
	
end Behavioral;
