----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2018 03:36:14 PM
-- Design Name: 
-- Module Name: shifter - Behavioral
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

entity shifter is
  Port (
        INa : in STD_LOGIC_VECTOR(15 downto 0);
		INb : in STD_LOGIC_VECTOR(1 downto 0);
		INc, INd : in STD_LOGIC;
		H : out STD_LOGIC_VECTOR(15 downto 0)
		 );
end shifter;

architecture Behavioral of shifter is

	Component mux_3_1
		Port(
			In0, In1, In2 : in STD_LOGIC;
			S0, S1 : in STD_LOGIC;
            Z : out STD_LOGIC
		);
	End Component;

begin
	mux00: mux_3_1 PORT MAP(
		In0 => INa(0),
		In1 => INa(1),
		In2 => INc,
		S0 => INb(0),
		S1 => INb(1),
		Z => H(0)
	);
	
	mux01: mux_3_1 PORT MAP(
		In0 => INa(1),
		In1 => INa(2),
		In2 => INa(0),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(1)
	);
	
	mux02: mux_3_1 PORT MAP(
		In0 => INa(2),
		In1 => INa(3),
		In2 => INa(1),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(2)
	);
	
	mux03: mux_3_1 PORT MAP(
		In0 => INa(3),
		In1 => INa(4),
		In2 => INa(2),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(3)
	);
	
	mux04: mux_3_1 PORT MAP(
		In0 => INa(4),
		In1 => INa(5),
		In2 => INa(3),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(4)
	);
	
	mux05: mux_3_1 PORT MAP(
		In0 => INa(5),
		In1 => INa(6),
		In2 => INa(4),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(5)
	);
	
	mux06: mux_3_1 PORT MAP(
		In0 => INa(6),
		In1 => INa(7),
		In2 => INa(5),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(6)
	);
	
	mux07: mux_3_1 PORT MAP(
		In0 => INa(7),
		In1 => INa(8),
		In2 => INa(6),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(7)
	);
	
	mux08: mux_3_1 PORT MAP(
		In0 => INa(8),
		In1 => INa(9),
		In2 => INa(7),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(8)
	);
	
	mux09: mux_3_1 PORT MAP(
		In0 => INa(9),
		In1 => INa(10),
		In2 => INa(8),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(9)
	);
	
	mux10: mux_3_1 PORT MAP(
		In0 => INa(10),
		In1 => INa(11),
		In2 => INa(9),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(10)
	);
	
	mux11: mux_3_1 PORT MAP(
		In0 => INa(11),
		In1 => INa(12),
		In2 => INa(10),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(11)
	);
	
	mux12: mux_3_1 PORT MAP(
		In0 => INa(12),
		In1 => INa(13),
		In2 => INa(11),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(12)
	);
	
	mux13: mux_3_1 PORT MAP(
		In0 => INa(13),
		In1 => INa(14),
		In2 => INa(12),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(13)
	);
	
	mux14: mux_3_1 PORT MAP(
		In0 => INa(14),
		In1 => INa(15),
		In2 => INa(13),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(14)
	);
	
	mux15: mux_3_1 PORT MAP(
		In0 => INa(15),
		In1 => INd,
		In2 => INa(14),
		S0 => INb(0),
		S1 => INb(1),
		Z => H(15)
	);


end Behavioral;
