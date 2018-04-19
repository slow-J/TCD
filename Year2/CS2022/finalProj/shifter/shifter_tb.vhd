----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 11:26:57 AM
-- Design Name: 
-- Module Name: shifter_tb - Behavioral
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

entity shifter_tb is
--  Port ( );
end shifter_tb;

architecture Behavioral of shifter_tb is


    component shifter
        port( 
              INa  : in std_logic_vector (15 downto 0);
              INb  : in std_logic_vector (1 downto 0);
              INc : in std_logic;
              INd : in std_logic;
              H  : out std_logic_vector (15 downto 0));
    end component;

    signal INa  : std_logic_vector (15 downto 0);
    signal INb  : std_logic_vector (1 downto 0);
    signal INc : std_logic;
    signal INd : std_logic;
    signal H  : std_logic_vector (15 downto 0); --output

begin

    uut : shifter
    port map (INa  => INa,
              INb  => INb,
              INc => INc,
              INd => INd,
              H  => H);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
      	       INa <= "0000000000000000";
               INb <= "11";
               INc <= '1';
               INd <= '0';
            wait for 10ns;
            
               INd <= '1';
            wait for 10ns;
            
               INd <= '0';
            wait for 10ns;
end process;
end;