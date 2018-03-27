----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2018 11:17:06 AM
-- Design Name: 
-- Module Name: Project1B - Behavioral
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

entity Project1B is
    Port(
	
		data_in, constant_in : in STD_LOGIC_VECTOR(15 downto 0);
		control_word : in STD_LOGIC_VECTOR(17 downto 0); --mbselect
		clk_sig : in STD_LOGIC;
		
        d_a0 : in  STD_LOGIC;
        d_a1 : in  STD_LOGIC;
        d_a2 : in  STD_LOGIC;
		d_a3 : in STD_LOGIC;
		data_load : in STD_LOGIC;
		
		data_out, address_out : out STD_LOGIC_VECTOR(15 downto 0);
		N_out, Z_out, C_out, V_out : out STD_LOGIC;
        bus_a_adr_out : out std_logic_vector(15 downto 0);
        bus_b_data_out : out std_logic_vector(15 downto 0);
        f_data_out : out std_logic_vector(15 downto 0);

	);
end Project1B;

architecture Behavioral of Project1B is
--components
	--reg file
	Component file_reg
		Port(
		
		    d_a0, d_a1, d_a2 	: in STD_LOGIC;
            clk, data_load : in STD_LOGIC;
            data : in STD_LOGIC_VECTOR(15 downto 0);
            out_data_a, out_data_b : out STD_LOGIC_VECTOR(15 downto 0);
            reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--2-1 mux
	Component mux_2_16
		Port(
			In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
			s : in STD_LOGIC;
			Z : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	--function unit
	Component func_unit
		Port(
			FuncSelect : in STD_LOGIC_VECTOR(4 downto 0); -- 5 input
			a_in, b_in : in STD_LOGIC_VECTOR(15 downto 0);
			N_fun, Z_fun, V_fun, C_fun : out STD_LOGIC;
			F : out STD_LOGIC_VECTOR(15 downto 0)
		);
	End Component;
	
	signal mux_b_out, mux_d_out, reg_file_out_a, reg_file_out_b, func_unit_out : STD_LOGIC_VECTOR(15 downto 0);

begin

	mux_b00: mux_2_16 PORT MAP(
		In0 => constant_in,
		In1 => reg_file_out_b,
		s => control_word(7),
		Z => mux_b_out
	);
	
	mux_d00: mux_2_16 PORT MAP(
		In0 => func_unit_out,
		In1 => data_in,
		s => control_word(1),
		Z => mux_d_out
	);
	
	all_reg: file_reg PORT MAP(
		d_a0 => control_word(15),
		d_a1 => control_word(12),
		d_a2 => control_word(9),
		clk => clk_sig,
		data_load => control_word(0),
		data => mux_d_out,
		out_data_a => reg_file_out_a,
		out_data_b => reg_file_out_b
	
	);
	
	data_out <= mux_b_out;
	address_out <= reg_file_out_a;
	
	func_unit00: func_unit PORT MAP(
		FuncSelect => control_word(6 downto 2),
		A_in => reg_file_out_a,
		B_in => mux_b_out,
		N_fun => N_out,
		Z_fun => Z_out,
		C_fun => C_out,
		V_fun => V_out,
		F => func_unit_out
	);

end Behavioral;
