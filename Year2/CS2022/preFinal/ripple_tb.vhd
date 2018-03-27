----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 11:32:55 AM
-- Design Name: 
-- Module Name: ripple_tb - Behavioral
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

entity ripple_tb is
--  Port ( );
end ripple_tb;

architecture Behavioral of ripple_tb is
 component ripple_adder_16
       port (A     : in std_logic_vector (15 downto 0);
             B     : in std_logic_vector (15 downto 0);
             Cin : IN  std_logic;
             Cout  : out std_logic;
             V_out : out std_logic;
             G_out : out std_logic_vector (15 downto 0));
   end component;

   signal A     : std_logic_vector (15 downto 0);
   signal B     : std_logic_vector (15 downto 0);
   signal Cin : std_logic := '0';
   signal Cout  : std_logic;
   signal V_out : std_logic;
   signal G_out : std_logic_vector (15 downto 0);
begin
    uut : ripple_adder_16
    port map(A     => A,
             B     => B,
             Cin => Cin,
             Cout  => Cout,
             V_out => V_out,
             G_out => G_out);

    stimuli : process
    begin
      -- hold reset state for 80 ns.
       wait for 80ns;
       A <= x"AAAA";
       B <= x"BBBB";
       Cin <= '1';
               
       
               
     
       wait;
       end process;
end;