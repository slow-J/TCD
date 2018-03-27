----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 04:36:43 PM
-- Design Name: 
-- Module Name: mux_2_16_tb - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;

entity mux_2_16_tb is
end mux_2_16_tb;

architecture behavior of mux_2_16_tb is

    component mux_2_16
        port (in0 : in std_logic_vector (15 downto 0);
              in1 : in std_logic_vector (15 downto 0);
              s   : in std_logic;
              z   : out std_logic_vector (15 downto 0));
    end component;

    signal in0 : std_logic_vector (15 downto 0);
    signal in1 : std_logic_vector (15 downto 0);
    signal s   : std_logic;
    --output
    signal z   : std_logic_vector (15 downto 0);

begin

    dut : mux_2_16
    port map (in0 => in0,
              in1 => in1,
              s   => s,
              z   => z);

    stimulus : process
    begin
       wait for 10ns;
            in0 <= x"FFFF";
            in1 <= x"AAAA";
            
            wait for 10ns;
            s <= '1';
            
            wait for 10ns;
            s <= '0';
            
            wait for 10ns;
            s <= '1';
    end process;

end;
