----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 
-- Design Name: 
-- Module Name: reg1_tb - Behavioral
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

entity reg1_tb is
--  Port ( );
end reg1_tb;

architecture Behavioral of reg1_tb is
    Component reg
    Port(
            D : in STD_LOGIC_VECTOR(15 downto 0);
            load, clk : in STD_LOGIC;
            Q : out STD_LOGIC_VECTOR(15 downto 0)
        );
    end Component;
    --Inputs
       signal D : std_logic_vector(15 downto 0) := (others => '0');
       signal load : std_logic := '0';
       signal clk : std_logic := '0';
    
         --Outputs
       signal Q : std_logic_vector(15 downto 0);
    
       -- Clock period definitions
       constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
   uut: reg PORT MAP (
          D => D,
          load => load,
          clk => clk,
          Q => Q
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 10ns;
		D <= x"FFFF";
		load <= '1';
		
		wait for 10ns;
		D <= x"AAAA";
		load <= '0';
		
		wait for 10ns;
		load <= '1';
		
		wait for 10ns;
		load <= '0';
		load <= '1';
		
   end process;

end Behavioral;
--------------------------------------------
