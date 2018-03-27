----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 07:22:07 PM
-- Design Name: 
-- Module Name: mux_2_1_tb - Behavioral
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

entity mux_2_1_tb is
--  Port ( );
end mux_2_1_tb;

architecture Behavioral of mux_2_1_tb is
  component mux_2_1
      port (
            I0 : in std_logic;
            S0 : in std_logic;
            S1 : in std_logic;
            Z  : out std_logic);
  end component;

  signal I0 : std_logic;
  signal S0 : std_logic;
  signal S1 : std_logic;
  signal Z  : std_logic;

begin

  uut : mux_2_1
  port map (I0 => I0,
            S0 => S0,
            S1 => S1,
            Z  => Z);

  stimuli : process
  begin
      -- EDIT Adapt initialization as needed
      S0 <= '1';
      S1 <= '0';
              
      wait for 10ns;
      I0 <= '1';
              
      wait for 10ns;
      I0 <= '0';



      wait;
  end process;
end Behavioral;
