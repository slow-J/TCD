----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 12:50:02 PM
-- Design Name: 
-- Module Name: extend_tb - Behavioral
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

entity extend_tb is
--  Port ( );
end extend_tb;

architecture Behavioral of extend_tb is
    component Extend
    port (
        SR_SB      : in std_logic_vector (5 downto 0);
        extend_out : out std_logic_vector (15 downto 0)
        );
    end component;

    signal SR_SB      : std_logic_vector (5 downto 0) := (others => '0');
    signal extend_out : std_logic_vector (15 downto 0);
begin
    uut : Extend
    port map (
        SR_SB      => SR_SB,
        extend_out => extend_out
        );

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        wait for 5 ns;
        SR_SB <= "000000";
        
        -- EDIT Add stimuli here
        wait for 5ns;
        SR_SB <= "111111";
        
        wait for 5ns;
        SR_SB <= "101010";
        
        wait;
    end process;

end;
