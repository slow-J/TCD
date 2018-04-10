----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2018 11:18:32 AM
-- Design Name: 
-- Module Name: func_unit - Behavioral
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

entity func_unit is
Port(
		FuncSelect : in STD_LOGIC_VECTOR(4 downto 0); -- 5 input
		a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
		N_fun, Z_fun, V_fun, C_fun : out STD_LOGIC;
		F : out STD_LOGIC_VECTOR(15 downto 0)
	);
end func_unit;

architecture Behavioral of func_unit is

--2 to 1 mux
	Component mux_2_16
		Port(
			In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--shifter
	Component shifter
		Port(
			INa : in STD_LOGIC_VECTOR(15 downto 0);
			INb : in STD_LOGIC_VECTOR(1 downto 0);
			INc, INd : in STD_LOGIC;
			H : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--alu
	Component alu_unit
		Port(
			a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
			G_select : in STD_LOGIC_VECTOR(3 downto 0);
			V, C : out STD_LOGIC; -- flags
			G : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	
	signal H_out, ALU_out, mux_out : STD_LOGIC_VECTOR(15 downto 0);

begin
	shifter00: shifter PORT MAP(
		INa => b_in,
		INb => FuncSelect(3 downto 2),
		INc => '0',
		INd => '0',
		H => H_out
	);
	
	mux00: mux_2_16 PORT MAP(
		In0 => ALU_out,
		In1 => H_out,
		s => FuncSelect(4),
		z => mux_out
	);
	
	alu: alu_unit PORT MAP(
		a_in => a_in,
		b_in => b_in,
		G_select => FuncSelect(3 downto 0),
		V => V_fun,
		C => C_fun,
		G => ALU_out
	);
	
	F <= mux_out;
	N_fun <= mux_out(15);
	Z_fun <= (mux_out(15) or mux_out(14) or mux_out(13) or mux_out(12) or mux_out(11) 
				or mux_out(10) or mux_out(9) or mux_out(8) or mux_out(7) or mux_out(6) 
				or mux_out(5) or mux_out(4) or mux_out(3) or mux_out(2) or mux_out(1) or mux_out(0));


end Behavioral;
