----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 03:50:55 PM
-- Design Name: 
-- Module Name: pro1_tb - Behavioral
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

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY pro1_tb IS
END pro1_tb;
 
ARCHITECTURE behavior OF pro1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT file_reg
    PORT(
         src_s0 : IN  std_logic;
         src_s1 : IN  std_logic;
         src_s2 : IN  std_logic;
         des_a0 : IN  std_logic;
         des_a1 : IN  std_logic;
         des_a2 : IN  std_logic;
         data_load : IN  std_logic;
         clk : IN  std_logic;
         data : IN  std_logic_vector(15 downto 0);
         Q : OUT  std_logic_vector(15 downto 0);
         reg0 : OUT  std_logic_vector(15 downto 0);
         reg1 : OUT  std_logic_vector(15 downto 0);
         reg2 : OUT  std_logic_vector(15 downto 0);
         reg3 : OUT  std_logic_vector(15 downto 0);
         reg4 : OUT  std_logic_vector(15 downto 0);
         reg5 : OUT  std_logic_vector(15 downto 0);
         reg6 : OUT  std_logic_vector(15 downto 0);
         reg7 : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal src_s0 : std_logic := '0';
   signal src_s1 : std_logic := '0';
   signal src_s2 : std_logic := '0';
   signal des_a0 : std_logic := '0';
   signal des_a1 : std_logic := '0';
   signal des_a2 : std_logic := '0';
   signal data_load : std_logic := '0';
   signal clk : std_logic := '0';
   signal data : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal Q : std_logic_vector(15 downto 0);
   signal reg0 : std_logic_vector(15 downto 0);
   signal reg1 : std_logic_vector(15 downto 0);
   signal reg2 : std_logic_vector(15 downto 0);
   signal reg3 : std_logic_vector(15 downto 0);
   signal reg4 : std_logic_vector(15 downto 0);
   signal reg5 : std_logic_vector(15 downto 0);
   signal reg6 : std_logic_vector(15 downto 0);
   signal reg7 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: file_reg PORT MAP (
          src_s0 => src_s0,
          src_s1 => src_s1,
          src_s2 => src_s2,
          des_a0 => des_a0,
          des_a1 => des_a1,
          des_a2 => des_a2,
          data_load => data_load,
          clk => clk,
          data => data,
          Q => Q,
          reg0 => reg0,
          reg1 => reg1,
          reg2 => reg2,
          reg3 => reg3,
          reg4 => reg4,
          reg5 => reg5,
          reg6 => reg6,
          reg7 => reg7
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
		des_a0 <= '0';
		des_a1 <= '0';
		des_a2 <= '0';
		data <= x"6666";
		
		wait for 10ns;
		des_a0 <= '0';
		des_a1 <= '0';
		des_a2 <= '1';
		data <= x"EEEE";
		
		wait for 10ns;
		des_a0 <= '0';
		des_a1 <= '1';
		des_a2 <= '0';
		data <= x"DDDD";
		
		wait for 10ns;
		des_a0 <= '0';
		des_a1 <= '1';
		des_a2 <= '1';
		data <= x"CCCC";
		
		wait for 10ns;
		des_a0 <= '1';
		des_a1 <= '0';
		des_a2 <= '0';
		data <= x"BBBB";
		
		wait for 10ns;
		des_a0 <= '1';
		des_a1 <= '0';
		des_a2 <= '1';
		data <= x"AAAA";
		
		wait for 10ns;
		des_a0 <= '1';
		des_a1 <= '1';
		des_a2 <= '0';
		data <= x"2222";
		
		wait for 10ns;
		des_a0 <= '1';
		des_a1 <= '1';
		des_a2 <= '1';
		data <= x"8888";
   end process;

end;