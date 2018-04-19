----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 01:47:27 PM
-- Design Name: 
-- Module Name: reg2ins_tb - Behavioral
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

entity reg2ins_tb is
--  Port ( );
end reg2ins_tb;

architecture Behavioral of reg2ins_tb is
    Component reg2ins
    Port(
        D : IN  std_logic_vector(15 downto 0);
        load0, load1 : IN  std_logic;
        clk : IN  std_logic;
        Q : OUT  std_logic_vector(15 downto 0)
        );
    end Component;
    --Inputs
       signal D : std_logic_vector(15 downto 0) := (others => '0');
       signal load0 : std_logic := '0';
       signal load1 : std_logic := '0';
       signal clk : std_logic := '0';
    
         --Outputs
       signal Q : std_logic_vector(15 downto 0);
    
       -- Clock period definitions
       constant clk_period : time := 10 ns;
begin
    -- Instantiate the Unit Under Test (UUT)
   uut: reg2ins PORT MAP (
          D => D,
          load0 => load0,
          load1 => load1,
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
		load0 <= '1';
		load1 <= '1';
		
		wait for 10ns;
		D <= x"AAAA";
		load0 <= '0';
		
		wait for 10ns;
		load1 <= '0';
		
		wait for 10ns;
		load0 <= '1';
		load1 <= '1';
		
   end process;

end Behavioral;
--------------------------------------------
