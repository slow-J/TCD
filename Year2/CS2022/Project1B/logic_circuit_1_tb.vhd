----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 11:31:29 AM
-- Design Name: 
-- Module Name: logic_circuit_1_tb - Behavioral
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

entity logic_circuit_1_tb is
--  Port ( );
end logic_circuit_1_tb;

architecture Behavioral of logic_circuit_1_tb is

  component logic_circuit_1
        port (
              a_logic_in     : in std_logic_vector (15 downto 0);
              b_logic_in     : in std_logic_vector (15 downto 0);
              select_in      : in std_logic_vector (1 downto 0);
              logic_output_1 : out std_logic_vector (15 downto 0)
              );
    end component;

    signal a_logic_in     : std_logic_vector (15 downto 0);
    signal b_logic_in     : std_logic_vector (15 downto 0);
    signal select_in      : std_logic_vector (1 downto 0);
    signal logic_output_1 : std_logic_vector (15 downto 0);
begin
   uut : logic_circuit_1
   port map (a_logic_in     => a_logic_in,
             b_logic_in     => b_logic_in,
             select_in      => select_in,
             logic_output_1 => logic_output_1
             );

   stimuli : process
   begin
       -- EDIT Adapt initialization as needed
       wait for 10ns;
       a_logic_in <= x"AAAA";
       b_logic_in <= x"BBBB";
       select_in <= "00";
               
       wait for 10ns;
       select_in <= "01";
               
       wait for 10ns;
       select_in <= "10";
               
       wait for 10ns;
       select_in <= "11";
       wait;
   end process;


end ;
