----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2018 02:05:12 PM
-- Design Name: 
-- Module Name: CAR_tb - Behavioral
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

entity CAR_tb is
--  Port ( );
end CAR_tb;

architecture Behavioral of CAR_tb is
    component CAR
    Port ( 
        CAR_input : in  STD_LOGIC_VECTOR (7 downto 0);
        CAR_reset : in STD_LOGIC;
        CAR_select : in  STD_LOGIC;
        clk : in STD_LOGIC;
        CAR_output : out  STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;
    
    signal CAR_input : std_logic_vector(7 downto 0) := (others => '0');
    signal CAR_reset : std_logic := '0';
    signal CAR_select : std_logic := '0';
    signal clk : std_logic := '0';
    signal CAR_output : std_logic_vector(7 downto 0);
    
begin

    uut: CAR Port map( 
        CAR_input => CAR_input,
        CAR_reset => CAR_reset,
        CAR_select => CAR_select,
        clk => clk,
        CAR_output => CAR_output
        );
stimuli : process        
begin        
        wait for 10ns;
		CAR_input <= "11111111";
		CAR_select <= '1';
		CAR_reset <='0';
		
		wait for 10ns;
		
		CAR_input <= "00000000";
		CAR_select <= '0';
		wait;
		
		wait for 10ns;
                
        CAR_input <= "11111111";
        CAR_select <= '0';
        wait;
   end process;
end;
