----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 03:59:49 PM
-- Design Name: 
-- Module Name: file_reg - Behavioral
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

entity file_reg is
Port(
			--src_s0, src_s1, src_s2 	: in STD_LOGIC;
			des_a0, des_a1, des_a2 	: in STD_LOGIC;
			clk, data_load : in STD_LOGIC;
			data : in STD_LOGIC_VECTOR(15 downto 0);
			out_data_a, out_data_b : out STD_LOGIC_VECTOR(15 downto 0);
			reg0, reg1, reg2, reg3, reg4, reg5, reg6, reg7 : out STD_LOGIC_VECTOR(15 downto 0)
		);
end file_reg;	
	architecture Behavioral of file_reg is
    --register component
        Component reg
            Port(
                     D : in STD_LOGIC_VECTOR(15 downto 0);
                     load0, load1, clk : in STD_LOGIC;
                     Q : out STD_LOGIC_VECTOR(15 downto 0)
                 );
        End Component;
    --decoder 3 to 8 bit
        Component decoder
            Port(
                    a0, a1, a2 : in STD_LOGIC;
                    Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : out STD_LOGIC 
                    );
        End Component;
    --mux 2 to 16 bit
        Component mux_2_16
            Port(
                    in0, in1 : in STD_LOGIC_VECTOR(15 downto 0);
                    s : in STD_LOGIC;
                    z : out STD_LOGIC_VECTOR(15 downto 0)
                    );
        End Component;
    --mux 8 to 16 bit
        Component mux_8_16
            Port(
                    in0, in1, in2, in3, in4, in5, in6, in7 : in STD_LOGIC_VECTOR(15 downto 0);
                    s0, s1, s2 : STD_LOGIC;
                    z : out STD_LOGIC_VECTOR(15 downto 0)
                    );
        End Component;
	
	--inter-component signals
      signal load_reg0, load_reg1, load_reg2, load_reg3, load_reg4, load_reg5, load_reg6, load_reg7 : STD_LOGIC;
        signal data_src_mux_out, src_reg, q_reg0, q_reg1, q_reg2, q_reg3, q_reg4, q_reg5, q_reg6, q_reg7, out_sig_a, out_sig_b: STD_LOGIC_VECTOR(15 downto 0);
        signal  src_s0, src_s1, src_s2 : STD_LOGIC;
        
   
    begin
        reg00 : reg PORT MAP(
                load0   =>        load_reg0,
                load1   =>        data_load,
                clk     =>        clk,
                D         =>       data,
                Q         =>        q_reg0
        );
        
        reg01 : reg PORT MAP(
                load0     =>    load_reg1,
                load1   =>      data_load,
                clk     =>          clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg1
        );
        
        reg02 : reg PORT MAP(
                load0     =>        load_reg2,
                load1 => data_load,
                clk     =>        clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg2
        );
    
        reg03 : reg PORT MAP(
                load0     =>        load_reg3,
                load1 => data_load,
                clk     =>        clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg3
        );
        
        
        reg04 : reg PORT MAP(
                load0     =>        load_reg4,
                load1 => data_load,
                clk     =>        clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg4
        );
        
        reg05 : reg PORT MAP(
                load0     =>        load_reg5,
                load1 => data_load,
                clk     =>        clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg5
        );
        
        reg06 : reg PORT MAP(
                load0     =>        load_reg6,
                load1 => data_load,
                clk     =>        clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg6
        );
        
        reg07 : reg PORT MAP(
                load0     =>        load_reg7,
                load1 => data_load,
                clk     =>        clk,
                D        =>        data_src_mux_out,
                Q         =>        q_reg7
        );
        
	des_decoder_3_8 : decoder PORT MAP(
                a0     =>    des_a0,
                a1     =>    des_a1,
                a2     =>    des_a2,
                q0     =>    load_reg0,
                q1     =>    load_reg1,
                q2     =>    load_reg2,
                q3     =>    load_reg3,
                q4     =>    load_reg4,
                q5     =>    load_reg5,
                q6     =>    load_reg6,
                q7     =>    load_reg7
            );
            
	src_muxA_8_16 : mux_8_16 PORT MAP(
			in0	=>	q_reg0,
            in1    =>    q_reg1,
            in2    =>    q_reg2,
            in3    =>    q_reg3,
            in4    =>    q_reg4,
            in5    =>    q_reg5,
            in6    =>    q_reg6,
            in7    =>    q_reg7,
            s0     =>    src_s0,
            s1     =>    src_s1,
            s2     =>    src_s2,
            z      =>    out_sig_a
		);
	
	src_muxB_8_16 : mux_8_16 PORT MAP(
			in0	=>	q_reg0,
			in1	=>	q_reg1,
			in2	=>	q_reg2,
			in3	=>	q_reg3,
			in4	=>	q_reg4,
			in5	=>	q_reg5,
			in6	=>	q_reg6,
			in7	=>	q_reg7,
			s0		=>	src_s0,
			s1		=>	src_s1,
			s2		=>	src_s2,
			z		=>	out_sig_b
		);
		reg0 <= q_reg0;
            reg1 <= q_reg1;
            reg2 <= q_reg2;
            reg3 <= q_reg3;
            reg4 <= q_reg4;
            reg5 <= q_reg5;
            reg6 <= q_reg6;
            reg7 <= q_reg7;
            
	out_data_a <= out_sig_a;
    out_data_b <= out_sig_b;
	
end Behavioral;
