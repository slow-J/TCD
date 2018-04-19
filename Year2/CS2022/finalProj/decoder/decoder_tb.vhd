----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 04:29:02 PM
-- Design Name: 
-- Module Name: decoder_tb - Behavioral
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


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY decoder_tb IS
END decoder_tb;
 
ARCHITECTURE behavior OF decoder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decoder
    PORT(
        a0, a1, a2, a3 : in STD_LOGIC;
        q0, q1, q2, q3, q4, q5, q6, q7, q8 : out STD_LOGIC
        );
    END COMPONENT;
    

   --Inputs
   signal a0 : std_logic := '0';
   signal a1 : std_logic := '0';
   signal a2 : std_logic := '0';
   signal a3 : std_logic := '0'; 
 	--Outputs
   signal q0 : std_logic;
   signal q1 : std_logic;
   signal q2 : std_logic;
   signal q3 : std_logic;
   signal q4 : std_logic;
   signal q5 : std_logic;
   signal q6 : std_logic;
   signal q7 : std_logic;
   signal q8 : std_logic;
 
BEGIN
 
   uut: decoder PORT MAP (
          a0 => a0,
          a1 => a1,
          a2 => a2,
          a3 => a3,
          q0 => q0,
          q1 => q1,
          q2 => q2,
          q3 => q3,
          q4 => q4,
          q5 => q5,
          q6 => q6,
          q7 => q7,
          q8 => q8
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
		
		wait for 10ns;
		a0 <= not a0;
		
		wait for 10ns;
		a1 <= not a1;
		
		wait for 10ns;
		a2 <= not a2;
		
		wait for 10ns;
		a3 <= not a3;
		
		wait for 10ns;
        a0 <= not a0;
                
        wait for 10ns;
        a1 <= not a1;
                
        wait for 10ns;
        a2 <= not a2;
                
        wait for 10ns;
        a3 <= not a3;
   end process;

END;