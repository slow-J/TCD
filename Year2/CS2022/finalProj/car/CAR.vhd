----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 11:56:50 AM
-- Design Name: 
-- Module Name: CAR - Behavioral
-- Project Name: CAR - Control Adress Register 
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

entity CAR is
    Port ( 
        CAR_input : in  STD_LOGIC_VECTOR (7 downto 0);
		CAR_reset : in STD_LOGIC;
        CAR_select : in  STD_LOGIC;
		clk : in STD_LOGIC;
        CAR_output : out  STD_LOGIC_VECTOR (7 downto 0)
        );
end CAR;

architecture Behavioral of CAR is

Component ripple_adder_16 is
	Port ( 
	      inV0, inV1 : in  STD_LOGIC_VECTOR (15 downto 0);
          Cin : in  STD_LOGIC;
          G_out : out  STD_LOGIC_VECTOR (15 downto 0);
          Cout, V_out : out  STD_LOGIC
          );
end Component ripple_adder_16;

Component reg is
	Port (
	      D : in  STD_LOGIC_VECTOR (15 downto 0);
          load : in  STD_LOGIC;
          clk : in  STD_LOGIC;
          Q : out  STD_LOGIC_VECTOR (15 downto 0)
          );
end Component reg;

Component mux_2_16
		Port(
			in0, in1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
end Component;

signal mux_intermediary : STD_LOGIC_VECTOR (15 downto 0);
signal reg_intermediary : STD_LOGIC_VECTOR (15 downto 0);
signal REG_Q : STD_LOGIC_VECTOR(15 downto 0);
signal ADD_Q : STD_LOGIC_VECTOR(15 downto 0);
signal carry_out : STD_LOGIC;
signal CAR_Q : STD_LOGIC_VECTOR(15 downto 0);

begin

mux_intermediary(15 downto 8) <= X"00";
mux_intermediary(7 downto 0) <= CAR_input;

resetMuxCar : mux_2_16 
Port MAP(
	in0 => mux_intermediary,
	in1 => X"0000",
	s => CAR_reset,
	z => reg_intermediary
);

regCAR : reg 
Port MAP(
	D => reg_intermediary,
	load => CAR_select,
	clk => clk,
	Q => REG_Q
);

adderCAR : ripple_adder_16
Port MAP(
	inV0 => REG_Q,
	inV1 => X"0001",
	Cin => '0',
	G_out => ADD_Q,
	Cout => carry_out
    );

muxCAR : mux_2_16 
Port MAP(
	in0 => REG_Q,
	in1 => ADD_Q,
	s => CAR_select,
	z => CAR_Q
);

CAR_output <= CAR_Q(7 downto 0);

end Behavioral;
