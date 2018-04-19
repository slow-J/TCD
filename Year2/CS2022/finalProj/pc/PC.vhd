----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 03:20:12 PM
-- Design Name: 
-- Module Name: PC - Behavioral
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

entity PC is
    Port ( 
        PC_in : in  STD_LOGIC_VECTOR (15 downto 0);
        PC_reset : in STD_LOGIC;
        PL : in  STD_LOGIC;
        PI : in  STD_LOGIC;
        clk : in STD_LOGIC;
        PC_out : out  STD_LOGIC_VECTOR (15 downto 0)
        );
end PC;

architecture Behavioral of PC is

Component reg is
	Port (
	   D : in  STD_LOGIC_VECTOR (15 downto 0);
       load : in  STD_LOGIC;
       clk : in  STD_LOGIC;
       Q : out  STD_LOGIC_VECTOR (15 downto 0)
       );
end Component reg;

Component mux_2_16 is
	Port (
	   in0 : in  STD_LOGIC_VECTOR (15 downto 0);
       in1 : in  STD_LOGIC_VECTOR (15 downto 0);
       s : in  STD_LOGIC;
       z : out  STD_LOGIC_VECTOR (15 downto 0)
       );
end Component mux_2_16;

Component ripple_adder_16 is
	Port (
	      inV0, inV1 : in STD_LOGIC_VECTOR(15 downto 0);
          Cin : in STD_LOGIC;
          Cout, V_out : out STD_LOGIC;
          G_out : out STD_LOGIC_VECTOR(15 downto 0)
          );
end Component ripple_adder_16;

signal reg_input : STD_LOGIC_VECTOR(15 downto 0);
signal PC_ADD : STD_LOGIC_VECTOR(15 downto 0);
signal carry_out : STD_LOGIC;
signal PC_Q : STD_LOGIC_VECTOR(15 downto 0);
begin

resetMuxPC : mux_2_16
    PORT MAP (
	   in0 => PC_in,
	   in1 => X"0000",
	   s => PC_reset,
	   z => reg_input
);

regPC : reg
    PORT MAP (
	   D => reg_input,
	   load => PL,
	   clk => clk,
	   Q => PC_Q
       );

adderPC : ripple_adder_16
    PORT MAP (
	   inV0 => PC_Q,
	   inV1 => X"0001",
	   Cin => '0',
	   G_out => PC_ADD,
	   Cout => carry_out
       );

muxPC : mux_2_16
    PORT MAP (
	   in0 => PC_Q,
	   in1 => PC_ADD,
	   s => PI,
	   z => PC_out
       );

end Behavioral;
