----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2018 11:21:51 AM
-- Design Name: 
-- Module Name: ripple_adder_16 - Behavioral
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

entity ripple_adder_16 is
    Port(
			inV0, inV1 : in STD_LOGIC_VECTOR(15 downto 0);
			Cin : in STD_LOGIC;
			Cout, V_out : out STD_LOGIC;
			G_out : out STD_LOGIC_VECTOR(15 downto 0)
		);
end ripple_adder_16;

architecture Behavioral of ripple_adder_16 is

Component full_add
		Port(
			in0, in1, Cin : in STD_LOGIC;
			Cout, S : out STD_LOGIC
			);
	End Component;
	
	--signals - 16 carry bits and 1 output
	signal C0, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C_out : STD_LOGIC;

begin
	full_adder_0: full_add PORT MAP(
		in0 => inV0(0),
		in1 => inV1(0),
		Cin => Cin,
		Cout => C0,
		S => G_out(0)
	);
	
	full_adder_1: full_add PORT MAP(
		in0 => inV0(1),
		in1 => inV1(1),
		Cin => C0,
		Cout => C1,
		S => G_out(1)
	);
	
	full_adder_2: full_add PORT MAP(
		in0 => inV0(2),
		in1 => inV1(2),
		Cin => C1,
		Cout => C2,
		S => G_out(2)
	);
	
	full_adder_3: full_add PORT MAP(
		in0 => inV0(3),
		in1 => inV1(3),
		Cin => C2,
		Cout => C3,
		S => G_out(3)
	);
	
	full_adder_4: full_add PORT MAP(
		in0 => inV0(4),
		in1 => inV1(4),
		Cin => C3,
		Cout => C4,
		S => G_out(4)
	);

	full_adder_5: full_add PORT MAP(
		in0 => inV0(5),
		in1 => inV1(5),
		Cin => C4,
		Cout => C5,
		S => G_out(5)
	);
	
	full_adder_6: full_add PORT MAP(
		in0 => inV0(6),
		in1 => inV1(6),
		Cin => C5,
		Cout => C6,
		S => G_out(6)
	);
	
	full_adder_7: full_add PORT MAP(
		in0 => inV0(7),
		in1 => inV1(7),
		Cin => C6,
		Cout => C7,
		S => G_out(7)
	);
	
	full_adder_8: full_add PORT MAP(
		in0 => inV0(8),
		in1 => inV1(8),
		Cin => C7,
		Cout => C8,
		S => G_out(8)
	);
	
	full_adder_9: full_add PORT MAP(
		in0 => inV0(9),
		in1 => inV1(9),
		Cin => C8,
		Cout => C9,
		S => G_out(9)
	);
	
	full_adder_10: full_add PORT MAP(
		in0 => inV0(10),
		in1 => inV1(10),
		Cin => C9,
		Cout => C10,
		S => G_out(10)
	);
	
	full_adder_11: full_add PORT MAP(
		in0 => inV0(11),
		in1 => inV1(11),
		Cin => C10,
		Cout => C11,
		S => G_out(11)
	);
	
	full_adder_12: full_add PORT MAP(
		in0 => inV0(12),
		in1 => inV1(12),
		Cin => C11,
		Cout => C12,
		S => G_out(12)
	);
	
	full_adder_13: full_add PORT MAP(
		in0 => inV0(13),
		in1 => inV1(13),
		Cin => C12,
		Cout => C13,
		S => G_out(13)
	);
	
	full_adder_14: full_add PORT MAP(
		in0 => inV0(14),
		in1 => inV1(14),
		Cin => C13,
		Cout => C14,
		S => G_out(14)
	);
	
	full_adder_15: full_add PORT MAP(
		in0 => inV0(15),
		in1 => inV1(15),
		Cin => C14,
		Cout => C15,
		S => G_out(15)
	);
	
	--carry
	Cout <= C_out;
	--overflow
	V_out <= (C_out xor C15);


end Behavioral;
