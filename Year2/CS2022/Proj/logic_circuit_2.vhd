----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/12/2018 11:19:54 AM
-- Design Name: 
-- Module Name: logic_circuit_2 - Behavioral
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

entity logic_circuit_2 is
  Port ( 
        B : in STD_LOGIC_VECTOR(15 downto 0);
		S_in : in STD_LOGIC_VECTOR(1 downto 0);
		Y_out : out STD_LOGIC_VECTOR(15 downto 0)
		);
end logic_circuit_2;

architecture Behavioral of logic_circuit_2 is
	--mux 2-1 component
	Component mux_2_1
	Port(
		I0, S0, S1 : in STD_LOGIC;
		Z : out STD_LOGIC
	);
	End Component;

begin
	mux00: mux_2_1 PORT MAP(
		I0 => B(0),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(0)
	);
	
	mux01: mux_2_1 PORT MAP(
		I0 => B(1),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(1)
	);
	
	mux02: mux_2_1 PORT MAP(
		I0 => B(2),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(2)
	);
	
	mux03: mux_2_1 PORT MAP(
		I0 => B(3),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(3)
	);
	
	mux04: mux_2_1 PORT MAP(
		I0 => B(4),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(4)
	);
	
	mux05: mux_2_1 PORT MAP(
		I0 => B(5),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(5)
	);
	
	mux06: mux_2_1 PORT MAP(
		I0 => B(6),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(6)
	);
	
	mux07: mux_2_1 PORT MAP(
		I0 => B(7),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(7)
	);
	
	mux08: mux_2_1 PORT MAP(
		I0 => B(8),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(8)
	);
	
	mux09: mux_2_1 PORT MAP(
		I0 => B(9),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(9)
	);
	
	mux10: mux_2_1 PORT MAP(
		I0 => B(10),
		S0 => S_in(0),
		S1 => S_in(1),
		Z => Y_out(10)
	);

end Behavioral;