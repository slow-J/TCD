----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 06:43:17 PM
-- Design Name: 
-- Module Name: reg_file_tb - Behavioral
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

entity reg_file_tb is
--  Port ( );
end reg_file_tb;

architecture Behavioral of reg_file_tb is
     component file_reg
       port (des_a0     : in std_logic;
             des_a1     : in std_logic;
             des_a2     : in std_logic;
             clk        : in std_logic;
             data_load  : in std_logic;
             data       : in std_logic_vector (15 downto 0);
             out_data_a : out std_logic_vector (15 downto 0);
             out_data_b : out std_logic_vector (15 downto 0);
             reg0       : out std_logic_vector (15 downto 0);
             reg1       : out std_logic_vector (15 downto 0);
             reg2       : out std_logic_vector (15 downto 0);
             reg3       : out std_logic_vector (15 downto 0);
             reg4       : out std_logic_vector (15 downto 0);
             reg5       : out std_logic_vector (15 downto 0);
             reg6       : out std_logic_vector (15 downto 0);
             reg7       : out std_logic_vector (15 downto 0));
   end component;

   signal des_a0     : std_logic;
   signal des_a1     : std_logic;
   signal des_a2     : std_logic;
   signal clk        : std_logic;
   signal data_load  : std_logic;
   signal data       : std_logic_vector (15 downto 0);
   signal out_data_a : std_logic_vector (15 downto 0);
   signal out_data_b : std_logic_vector (15 downto 0);
   signal reg0       : std_logic_vector (15 downto 0);
   signal reg1       : std_logic_vector (15 downto 0);
   signal reg2       : std_logic_vector (15 downto 0);
   signal reg3       : std_logic_vector (15 downto 0);
   signal reg4       : std_logic_vector (15 downto 0);
   signal reg5       : std_logic_vector (15 downto 0);
   signal reg6       : std_logic_vector (15 downto 0);
   signal reg7       : std_logic_vector (15 downto 0);
   
begin

    uut : file_reg
    port map (des_a0     => des_a0,
              des_a1     => des_a1,
              des_a2     => des_a2,
              clk        => clk,
              data_load  => data_load,
              data       => data,
              out_data_a => out_data_a,
              out_data_b => out_data_b,
              reg0       => reg0,
              reg1       => reg1,
              reg2       => reg2,
              reg3       => reg3,
              reg4       => reg4,
              reg5       => reg5,
              reg6       => reg6,
              reg7       => reg7);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
              data_load <= '1';               
              
               des_a2 <= '0';
               wait for 10ns;
               data <= x"000F";
               wait for 10ns;
               
               des_a2 <= '1';
               wait for 1ns;
               data <= x"00F0";
               wait for 10ns;
               
               des_a2 <= '0';
               wait for 1ns;
               data <= x"0FCD";
               wait for 10ns;
               
               des_a2 <= '1';
               wait for 1ns;
               data <= x"A0FD";
               wait for 10ns;
       
               des_a2 <= '0';
               wait for 1ns;
               data <= x"00FE";
               wait for 10ns;
               
               des_a2 <= '1';
               wait for 1ns;
               data <= x"E0FF";
               wait for 10ns;
               
               des_a2 <= '0';
               wait for 1ns;
               data <= x"0FFA";
               wait for 10ns;
               
               des_a2 <= '1';
               wait for 10ns;
               data <= x"0FBA";
               wait for 10ns;
               des_a2 <= '0';
               
               des_a0 <= '0';
               des_a1 <= '0';
               wait for 10ns;
               
               des_a0 <= '1';
               des_a1 <= '1';
               wait for 10ns;
           
               des_a0 <= '0';
              des_a1 <= '0';
              wait for 10ns;
    
              des_a0 <= '1';
              des_a1 <= '1';
              wait for 10ns;
               
            wait;  
    end process;
    
end Behavioral;