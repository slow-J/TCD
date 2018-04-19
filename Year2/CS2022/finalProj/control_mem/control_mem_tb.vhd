----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/29/2018 04:30:01 PM
-- Design Name: 
-- Module Name: control_mem_tb - Behavioral
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

entity control_mem_tb is
--  Port ( );
end control_mem_tb;

architecture Behavioral of control_mem_tb is
    component control_memory
        port (
            IN_CAR : in std_logic_vector (7 downto 0);
            MW     : out std_logic;
            MM     : out std_logic;
            RW     : out std_logic;
            MD     : out std_logic;
            FS     : out std_logic_vector (4 downto 0);
            MB     : out std_logic;
            TB     : out std_logic;
            TA     : out std_logic;
            TD     : out std_logic;
            PL     : out std_logic;
            PI     : out std_logic;
            IL     : out std_logic;
            MC     : out std_logic;
            MS     : out std_logic_vector (2 downto 0);
            NA     : out std_logic_vector (7 downto 0)
            );
    end component;

    signal IN_CAR : std_logic_vector (7 downto 0);
    signal MW     : std_logic;
    signal MM     : std_logic;
    signal RW     : std_logic;
    signal MD     : std_logic;
    signal FS     : std_logic_vector (4 downto 0);
    signal MB     : std_logic;
    signal TB     : std_logic;
    signal TA     : std_logic;
    signal TD     : std_logic;
    signal PL     : std_logic;
    signal PI     : std_logic;
    signal IL     : std_logic;
    signal MC     : std_logic;
    signal MS     : std_logic_vector (2 downto 0);
    signal NA     : std_logic_vector (7 downto 0);
begin
    uut : control_memory
    port map (
        IN_CAR => IN_CAR,
        MW     => MW,
        MM     => MM,
        RW     => RW,
        MD     => MD,
        FS     => FS,
        MB     => MB,
        TB     => TB,
        TA     => TA,
        TD     => TD,
        PL     => PL,
        PI     => PI,
        IL     => IL,
        MC     => MC,
        MS     => MS,
        NA     => NA);

   stimuli : process
   begin
       wait for 10ns;
       IN_CAR <= x"00";
                   
       wait for 10ns;
       IN_CAR <= x"08";
                   
       wait for 10ns;
       IN_CAR <= x"0D";
   
   wait;
end process;
end;