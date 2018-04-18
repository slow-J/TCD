----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 04:23:21 PM
-- Design Name: 
-- Module Name: memoryM_tb - Behavioral
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

entity memoryM_tb is
--  Port ( );
end memoryM_tb;

architecture Behavioral of memoryM_tb is
   component memoryM
   port (
       address    : in std_logic_vector (15 downto 0);
       write_data : in std_logic_vector (15 downto 0);
       MW         : in std_logic;
       MR         : in std_logic;
       clk        : in std_logic;
       out_data   : out std_logic_vector (15 downto 0)
       );
   end component;

   signal address    : std_logic_vector (15 downto 0);
   signal write_data : std_logic_vector (15 downto 0);
   signal MW         : std_logic;
   signal MR         : std_logic;
   signal clk        : std_logic;
   signal out_data   : std_logic_vector (15 downto 0);
begin
    
    uut : memoryM
    port map (
        address    => address,
        write_data => write_data,
        MW         => MW,
        MR         => MR,
        clk        => clk,
        out_data   => out_data
        );

    stimuli : process
    begin
            -- EDIT Add stimuli here
        wait for 10ns;
        address <= x"0000";
                
        wait for 10ns;
        address <= x"0001";
                
        wait for 10ns;
        address <= x"0002";
                
        wait for 10ns;
        address <= x"0003";


        wait;
    end process;

end;
