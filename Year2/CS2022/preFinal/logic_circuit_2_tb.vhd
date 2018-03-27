----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 11:31:45 AM
-- Design Name: 
-- Module Name: logic_circuit_2_tb - Behavioral
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

entity logic_circuit_2_tb is
--  Port ( );
end logic_circuit_2_tb;

architecture Behavioral of logic_circuit_2_tb is
    
    component logic_circuit_2
    port (B: in std_logic_vector (15 downto 0);
          S_in  : in std_logic_vector (1 downto 0);
          Y_out : out std_logic_vector (15 downto 0));
    end component;

    signal B     : std_logic_vector (15 downto 0);
    signal S_in  : std_logic_vector (1 downto 0);
    signal Y_out : std_logic_vector (15 downto 0);

begin
    uut : logic_circuit_2
    port map (B     => B,
              S_in  => S_in,
              Y_out => Y_out);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        
        B <= x"FFFF";
        S_in <= "00";
                
        wait for 5ns;
        S_in <= "01";
                
        wait for 5ns;
        S_in <= "10";
                
        wait for 5ns;
        S_in <= "11";
        wait;
    end process;

end;