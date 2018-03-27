----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2018 02:45:19 PM
-- Design Name: 
-- Module Name: pro2_tb - Behavioral
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

entity pro2_tb is
--  Port ( );
end pro2_tb;

architecture Behavioral of pro2_tb is
  component Project1B
      port (
            data_in      : in std_logic_vector (15 downto 0);
            constant_in  : in std_logic_vector (15 downto 0);
            control_word : in std_logic_vector (16 downto 0);
            Clk_sig      : in std_logic;
            data_out     : out std_logic_vector (15 downto 0);
            address_out  : out std_logic_vector (15 downto 0);
            N_out        : out std_logic;
            Z_out        : out std_logic;
            C_out        : out std_logic;
            V_out        : out std_logic);
  end component;

  signal data_in      : std_logic_vector (15 downto 0);
  signal constant_in  : std_logic_vector (15 downto 0);
  signal control_word : std_logic_vector (16 downto 0);
  signal Clk_sig      : std_logic;
  signal data_out     : std_logic_vector (15 downto 0);
  signal address_out  : std_logic_vector (15 downto 0);
  signal N_out        : std_logic;
  signal Z_out        : std_logic;
  signal C_out        : std_logic;
  signal V_out        : std_logic;

begin

  uut : Project1B
  port map (
            data_in      => data_in,
            constant_in  => constant_in,
            control_word => control_word,
            Clk_sig      => Clk_sig,
            data_out     => data_out,
            address_out  => address_out,
            N_out        => N_out,
            Z_out        => Z_out,
            C_out        => C_out,
            V_out        => V_out);

  stimuli : process
  begin
        data_in <= x"FFFF";
          constant_in <= x"1111";
          control_word <= "01010111111110011";
          
          wait for 40ns;
          data_in <= x"2222";
          control_word <= "00000000000000001";
          
          wait for 40ns;
          control_word <= "00000001111111111";
          
          wait for 40ns;
          control_word <= "00110011111111111";
          
          wait;
     end process;

end;
