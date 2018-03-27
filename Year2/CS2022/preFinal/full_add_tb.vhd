----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 07:14:44 PM
-- Design Name: 
-- Module Name: full_add_tb - Behavioral
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

entity full_add_tb is
--  Port ( );
end full_add_tb;

architecture Behavioral of full_add_tb is
 component full_add
       port (
             X    : in std_logic;
             Y    : in std_logic;
             Cin  : in std_logic;
             Cout : out std_logic;
             S    : out std_logic);
   end component;

   signal X    : std_logic;
   signal Y    : std_logic;
   signal Cin  : std_logic;
   signal Cout : std_logic;
   signal S    : std_logic;

begin

   uut : full_add
   port map (X    => X,
             Y    => Y,
             Cin  => Cin,
             Cout => Cout,
             S    => S);

   stimuli : process
   begin
       -- EDIT Adapt initialization as needed
     wait for 10ns;
     X <= '1';
               
     wait for 10ns;
     X <= '0';
     Y <= '1';
      
     wait for 10ns;
     X <= '1';
               
     wait for 10ns;
     Cin <= '1';
               
     wait for 10ns;
     Y <= '0';
               
     wait for 10ns;
     X <= '0';
       wait;
   end process;

end;
