----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 11:44:25 AM
-- Design Name: 
-- Module Name: tb_mux_3_1 - Behavioral
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

entity tb_mux_3_1 is
--  Port ( );
end tb_mux_3_1;

architecture Behavioral of tb_mux_3_1 is

    component mux_3_1
        port (In0 : in std_logic;
              In1 : in std_logic;
              In2 : in std_logic;
              S0  : in std_logic;
              S1  : in std_logic;
              Z  : out std_logic);
              
    end component;

    signal In0 : std_logic;
    signal In1 : std_logic;
    signal In2 : std_logic;
    signal S0  : std_logic;
    signal S1  : std_logic;
    signal Z   : std_logic;
    
begin
    uut : mux_3_1
    port map (In0 => In0,
             In1 => In1,
             In2 => In2,
             S0  => S0,
             S1  => S1,
             Z   => Z);

   stimuli : process
   begin
       -- EDIT Adapt initialization as needed
       wait for 10ns;	
               In0 <= '1';
               In1 <= '0';
               In2 <= '1';
               
               wait for 5ns;
               S0 <= '0';
               S1 <= '1';
               
               wait for 5ns;
               S0 <= '1';
               S1 <= '0';
               
               wait for 5ns;
               S0 <= '1';
               S1 <= '1';

       wait;
   end process;


end;
