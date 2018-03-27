----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 11:44:56 AM
-- Design Name: 
-- Module Name: datapath - Behavioral
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

entity datapath is
  Port ( 
          data_in, constant_in : in STD_LOGIC_VECTOR(15 downto 0);
          control_word : in STD_LOGIC_VECTOR(17 downto 0); --mbselect
          TD, TA, TB : in STD_LOGIC;
          clk_sig : in STD_LOGIC;
          data_out, address_out : out STD_LOGIC_VECTOR(15 downto 0); 
          bus_a_adr_out : out std_logic_vector(15 downto 0);
          bus_b_data_out : out std_logic_vector(15 downto 0);  
            );
end datapath;

architecture Behavioral of datapath is
    Component file_reg
		Port(
		
		    d_a0, d_a1, d_a2 	: in STD_LOGIC;
            clk, data_load : in STD_LOGIC;
            data : in STD_LOGIC_VECTOR(15 downto 0);
            out_data_a, out_data_b : out STD_LOGIC_VECTOR(15 downto 0);
		);
    End Component;
	Component mux_2_16
         Port(
              In0, In1 : in STD_LOGIC_VECTOR(15 downto 0);
              s : in STD_LOGIC;
              Z : out STD_LOGIC_VECTOR(15 downto 0)
             );
    End Component;
    Component fillZero
            Port(    SB_in : in STD_LOGIC_VECTOR(2 downto 0);
                    zero_fill_out : out STD_LOGIC_VECTOR(15 downto 0)
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
begin
    signal mux_b_out, mux_d_out, mux_m_out, reg_file_out_a, reg_file_out_b, func_unit_out, zero_fill_out, pc_sig : STD_LOGIC_VECTOR(15 downto 0);
	signal dest_d, addr_a, addr_b, status_bits : STD_LOGIC_VECTOR(3 downto 0);

	mux_b00: mux_2_16 PORT MAP(
		In0 => reg_file_out_b,
		In1 => zero_fill_out,
		s => control_word(8),
		Z => mux_b_out
	);
	
	mux_d00: mux_2_16 PORT MAP(
		In0 => func_unit_out,
		In1 => data_in,
		s => control_word(2),
		Z => mux_d_out
	);
	pc_sig <= constant_in;
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
