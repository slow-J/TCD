----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/06/2018 02:05:00 PM
-- Design Name: 
-- Module Name: IR_tb - Behavioral
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

entity IR_tb is
--  Port ( );
end IR_tb;

architecture Behavioral of IR_tb is

    Component IR
    Port(
        IR_in : in  STD_LOGIC_VECTOR (15 downto 0);
        IL : in  STD_LOGIC;
        clk : in  STD_LOGIC;
        opcode : out  STD_LOGIC_VECTOR (6 downto 0);
        DR, SA, SB : out  STD_LOGIC_VECTOR (2 downto 0)
        );
    end Component;    
    
    --Inputs
    signal IR_in : std_logic_vector(15 downto 0) := (others => '0');
    signal IL : std_logic := '0';
    signal clk : std_logic := '0';
   
      
    signal Opcode : std_logic_vector(6 downto 0);
    signal DR, SA, SB : std_logic_vector(2 downto 0);        
     
begin
     uut: IR PORT MAP (
        IR_in => IR_in,
        IL => IL,
        Clk => Clk,
        Opcode => Opcode,
        DR => DR,
        SA => SA,
        SB => SB
       );
       
    stimuli: process
    begin        
        wait for 10ns;
        IR_in <= "1000001000001010";
              
        wait for 5ns;
        IL <= '1';
              
        wait for 10ns;
        IR_in <= "0000110110110000";
        IL <= '0';
              
        wait for 5ns;
        IL <= '1';
      
         wait;
     end process;
      
      END;