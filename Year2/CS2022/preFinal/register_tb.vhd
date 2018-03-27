--------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:20:53 02/09/2016
-- Design Name:   
-- Module Name:   
-- Project Name:  Proj1a
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: reg
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY reg_test_bench IS
END reg_test_bench;
 
ARCHITECTURE behavior OF reg_test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT reg
    PORT(
         D : IN  std_logic_vector(15 downto 0);
         load0, load1 : IN  std_logic;
         clk : IN  std_logic;
         Q : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal D : std_logic_vector(15 downto 0) := (others => '0');
   signal load0 : std_logic := '0';
   signal load1 : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: reg PORT MAP (
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

end;