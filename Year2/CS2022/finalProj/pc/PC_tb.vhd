----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/10/2018 02:09:30 PM
-- Design Name: 
-- Module Name: PC_tb - Behavioral
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

entity PC_tb is
--  Port ( );
end PC_tb;

library ieee;
use ieee.std_logic_1164.all;

entity tb_PC is
end tb_PC;

architecture tb of tb_PC is

    component PC
        port (
              PC_in    : in std_logic_vector (15 downto 0);
              PC_reset : in std_logic;
              PL       : in std_logic;
              PI       : in std_logic;
              clk      : in std_logic;
              PC_out   : out std_logic_vector (15 downto 0)
              );
    end component;

    signal PC_in    : std_logic_vector (15 downto 0);
    signal PC_reset : std_logic;
    signal PL       : std_logic;
    signal PI       : std_logic;
    signal clk      : std_logic;
    signal PC_out   : std_logic_vector (15 downto 0);

begin

    uut : PC
    port map (PC_in    => PC_in,
              PC_reset => PC_reset,
              PL       => PL,
              PI       => PI,
              clk      => clk,
              PC_out   => PC_out);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        PC_in <= (others => '0');
        PC_reset <= '0';
        PL <= '0';
        PI <= '0';
        clk <= '0';

        -- EDIT Add stimuli here

            wait for 5ns;
            PC_reset <= '1';
            PC_in <= x"0000";
                
            wait for 5ns;
            PC_reset <= '0';
                
            wait for 5ns;
            PC_reset <= '1';
            PC_in <= x"0002";
                
            wait for 20ns;
            PC_in <=  x"0000";
            PC_in <=  x"1111";
            PC_in <= x"EEEE";
        
        
        
        
    end process;

end;