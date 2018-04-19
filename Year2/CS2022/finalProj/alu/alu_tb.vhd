----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 05:33:22 PM
-- Design Name: 
-- Module Name: alu_tb - Behavioral
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

entity alu_tb is
--  Port ( );
end alu_tb;

architecture Behavioral of alu_tb is
    
    component alu_unit
        port (
              a_in, b_in      : in std_logic_vector (15 downto 0);
              G_select : in std_logic_vector (3 downto 0);
              V        : out std_logic;
              C        : out std_logic;
              G        : out std_logic_vector (15 downto 0)
              );
    end component;

    signal a_in     : std_logic_vector (15 downto 0);
    signal b_in     : std_logic_vector (15 downto 0);
    signal G_select : std_logic_vector (3 downto 0);
    signal V        : std_logic;
    signal C        : std_logic;
    signal G        : std_logic_vector (15 downto 0);

begin
    uut : alu_unit
    port map (
              a_in     => a_in,
              b_in     => b_in,
              G_select => G_select,
              V        => V,
              C        => C,
              G        => G
              );

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
         a_in <= x"FFAA";
               b_in <= x"000F";
               G_select <= "0000";
               
               wait for 10ns;
               G_select <= "0001";
               
               wait for 10ns;
               G_select <= "0010";
               
               wait for 10ns;
               G_select <= "0011";
               
               wait for 10ns;
               G_select <= "0100";
               
               wait for 10ns;
               G_select <= "0101";
               
               wait for 10ns;
               G_select <= "0110";
               
               wait for 10ns;
               G_select <= "0111";
               
               wait for 10ns;
               G_select <= "1000";
    end process;

end;
