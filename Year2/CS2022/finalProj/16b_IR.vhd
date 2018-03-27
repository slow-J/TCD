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

entity 16b_IR is
    Port ( 
           IR_input : in  STD_LOGIC_VECTOR (15 downto 0);
           IL : in  STD_LOGIC;
		   Clk : in STD_LOGIC;
           Opcode : out  STD_LOGIC_VECTOR (6 downto 0);
           DR : out  STD_LOGIC_VECTOR (2 downto 0);
           SA : out  STD_LOGIC_VECTOR (2 downto 0);
           SB : out  STD_LOGIC_VECTOR (2 downto 0)
        );
end 16b_IR;

architecture Behavioral of 16b_IR is
    COMPONENT reg is
    PORT ( 
	      D : in  STD_LOGIC_VECTOR (15 downto 0);
          load : in  STD_LOGIC;
          Clk : in  STD_LOGIC;
          Q : out  STD_LOGIC_VECTOR (15 downto 0)
          );
END COMPONENT reg16;

signal IR_Q : STD_LOGIC_VECTOR (15 downto 0);

begin
regIR : reg16 PORT MAP 
	(
	D =>	IR_input,
	load => IL,
	Clk => Clk,
	Q => IR_Q
	);

Opcode <= IR_Q(15 downto 9);
DR <= IR_Q(8 downto 6);
SA <= IR_Q(5 downto 3);
SB <= IR_Q(2 downto 0);


end Behavioral;
