----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 11:48:10 AM
-- Design Name: 
-- Module Name: func_unit_tb - Behavioral
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

entity func_unit_tb is
--  Port ( );
end func_unit_tb;

architecture Behavioral of func_unit_tb is
    component func_unit
        port (FuncSelect : in std_logic_vector (4 downto 0);
              a_in       : in std_logic_vector (15 downto 0);
              b_in       : in std_logic_vector (15 downto 0);
              N_fun       : out std_logic;
              Z_fun       : out std_logic;
              V_fun       : out std_logic;
              C_fun       : out std_logic;
              F          : out std_logic_vector (15 downto 0));
    end component;

    signal FuncSelect : std_logic_vector (4 downto 0);
    signal a_in       : std_logic_vector (15 downto 0);
    signal b_in       : std_logic_vector (15 downto 0);
    signal N_fun       : std_logic;
    signal Z_fun       : std_logic;
    signal V_fun       : std_logic;
    signal C_fun       : std_logic;
    signal F          : std_logic_vector (15 downto 0);

begin
    ut : func_unit
    port map (FuncSelect => FuncSelect,
              a_in       => a_in,
              b_in       => b_in,
              N_fun       => N_fun,
              Z_fun       => Z_fun,
              V_fun       => V_fun,
              C_fun       => C_fun,
              F          => F);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
       
        a_in <= x"AAAA";
        b_in <= x"BBBB";
        
        wait for 20ns;
        FuncSelect <= "00000";
        
        wait for 10ns;
        FuncSelect <= "00001";
        
        wait for 10ns;
        FuncSelect <= "00010";
        
        wait for 10ns;
        FuncSelect <= "00011";
        
        wait for 10ns;
        FuncSelect <= "00100";
        
        wait for 10ns;
        FuncSelect <= "00101";
        
        wait for 10ns;
        FuncSelect <= "00110";
        
        wait for 10ns;
        FuncSelect <= "00111";
        
        wait for 10ns;
        FuncSelect <= "01000";
        
        wait for 10ns;
        FuncSelect <= "01010";
        
        wait for 10ns;
        FuncSelect <= "01100";
        
        wait for 10ns;
        FuncSelect <= "01110";
        
        wait for 10ns;
        FuncSelect <= "10000";
        
        wait for 10ns;
        FuncSelect <= "10100";
        
        wait for 10ns;
        FuncSelect <= "11000";
        
        wait;
    end process;

end;