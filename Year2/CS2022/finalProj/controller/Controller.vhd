----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 01:25:59 PM
-- Design Name: 
-- Module Name: MicroprogrammeController - Behavioral
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

entity Controller is
    Port (
        IR_in : in STD_LOGIC_VECTOR(15 downto 0);
        status : in STD_LOGIC_VECTOR(3 downto 0)     
    );
end Controller;

architecture Behavioral of Controller is

Component PC
    Port(
         PC_in : IN  std_logic_vector(15 downto 0);
         PC_reset, PL, PI, clk : IN  std_logic;
         PC_out : OUT  std_logic_vector(15 downto 0)
        );
    end Component;

            
    Component Extend
        Port(
             SR_SB : IN  std_logic_vector(5 downto 0);
             extend_out : OUT  std_logic_vector(15 downto 0)
            );
        end Component;
        
    Component mux_8_16
        Port(
           s0, s1, s2, s3 : in STD_LOGIC;
           in0, in1, in2, in3, in4, in5, in6, in7, in8 : in STD_LOGIC_VECTOR(15 downto 0);
           z : OUT STD_LOGIC
           );
    end Component;
        
         
    Component IR
        Port(
            IR : in  STD_LOGIC_VECTOR (15 downto 0);
            IL : in  STD_LOGIC;
            clk : in  STD_LOGIC;
            opcode : out  STD_LOGIC_VECTOR (6 downto 0);
            DR, SA, SB : out  STD_LOGIC_VECTOR (2 downto 0)
           );
    end Component;
        
     
    Component mux_2_1
        Port(
            I0, S0, S1 : in STD_LOGIC;
            Z : out STD_LOGIC
            );
        end Component;
        
         
    Component CAR
        Port(
            CAR_input : in  STD_LOGIC_VECTOR (7 downto 0);
            CAR_reset : in STD_LOGIC;
            CAR_select : in  STD_LOGIC;
            clk : in STD_LOGIC;
            CAR_output : out  STD_LOGIC_VECTOR (7 downto 0)
            );
        end Component;
        
     
    Component control_memory
        Port(
            IN_CAR : in  STD_LOGIC_VECTOR (7 downto 0);    
            MW, MM, RW, MD, MB, TB, TA, TD, PL, PI, IL, MC : out  STD_LOGIC;
            FS : out  STD_LOGIC_VECTOR (4 downto 0);
            MS : out  STD_LOGIC_VECTOR (2 downto 0);
            NA : out  STD_LOGIC_VECTOR (7 downto 0)
            );
        end Component;
        signal control_word_sig : STD_LOGIC_VECTOR(17 downto 0);
begin
--    pc_c : PC Port MAP(
--        PC_in => ,
--        PC_reset => ,
--        PL => ,
--        PI => ,         
--        clk => ,
--        PC_out => 
--        );
--
--     extend_c : extend Port MAP(
--        SR_SB =>
--        extend_out =>
--  
--     mux_c : mux_8_16 Port MAP(
--      s0, s1, s2, s3 : in STD_LOGIC;
--          in0, in1, in2, in3, in4, in5, in6, in7, in8 : in STD_LOGIC_VECTOR(15 downto 0);
--          z : OUT STD_LOGIC
--
--      IR
-- MUX_2_1
--  CAR
end Behavioral;
