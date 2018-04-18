----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/26/2018 11:57:32 AM
-- Design Name: 
-- Module Name: 16b_IR - Behavioral
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

entity IR is
    Port ( 
           IR_in : in  STD_LOGIC_VECTOR (15 downto 0);
           IL : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           opcode : out  STD_LOGIC_VECTOR (6 downto 0);
           DR, SA, SB : out  STD_LOGIC_VECTOR (2 downto 0)
        );
end IR;

architecture Behavioral of IR is

    Component reg is
     Port ( 
	      D : in  STD_LOGIC_VECTOR (15 downto 0);
          load, clk : in  STD_LOGIC;
          Q : out  STD_LOGIC_VECTOR (15 downto 0)
          );
end Component;

signal IR_Q : STD_LOGIC_VECTOR (15 downto 0);

begin
regIR : reg Port MAP (
	D =>	IR_in,
	load => IL,
	clk => clk,
	Q => IR_Q
	);

opcode <= IR_Q(15 downto 9);
DR <= IR_Q(8 downto 6);
SA <= IR_Q(5 downto 3);
SB <= IR_Q(2 downto 0);


end Behavioral;
