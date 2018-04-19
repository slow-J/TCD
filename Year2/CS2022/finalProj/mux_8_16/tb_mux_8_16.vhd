----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/19/2018 04:35:34 PM
-- Design Name: 
-- Module Name: mux_8_16_tb - Behavioral
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


-- Generation date : 20.2.2018 11:30:35 GMT

library ieee;
use ieee.std_logic_1164.all;

entity tb_mux_8_16 is
end tb_mux_8_16;

architecture behavior of tb_mux_8_16 is

    component mux_8_16
        port (
              s0  : in std_logic;
              s1  : in std_logic;
              s2  : in std_logic;
              s3  : in std_logic;
              in0 : in std_logic_vector (15 downto 0);
              in1 : in std_logic_vector (15 downto 0);
              in2 : in std_logic_vector (15 downto 0);
              in3 : in std_logic_vector (15 downto 0);
              in4 : in std_logic_vector (15 downto 0);
              in5 : in std_logic_vector (15 downto 0);
              in6 : in std_logic_vector (15 downto 0);
              in7 : in std_logic_vector (15 downto 0);
              in8 : in std_logic_vector (15 downto 0);
              z   : out std_logic_vector (15 downto 0));
    end component;

    signal s0  : std_logic := '0';
    signal s1  : std_logic := '0';
    signal s2  : std_logic := '0';
    signal s3  : std_logic := '0';    
    signal in0 : std_logic_vector (15 downto 0);
    signal in1 : std_logic_vector (15 downto 0);
    signal in2 : std_logic_vector (15 downto 0);
    signal in3 : std_logic_vector (15 downto 0);
    signal in4 : std_logic_vector (15 downto 0);
    signal in5 : std_logic_vector (15 downto 0);
    signal in6 : std_logic_vector (15 downto 0);
    signal in7 : std_logic_vector (15 downto 0);
    signal in8 : std_logic_vector (15 downto 0);
    --output
    signal z   : std_logic_vector (15 downto 0);

begin

    uut : mux_8_16
    port map (
        s0  => s0,
        s1  => s1,
        s2  => s2,
        s3  => s3,
        in0 => in0,
        in1 => in1,
        in2 => in2,
        in3 => in3,
        in4 => in4,
        in5 => in5,
        in6 => in6,
        in7 => in7,
        in8 => in8,
        z   => z
        );

    stimuli : process
    begin
       in0 <= x"1111";
		in1 <= x"2222";
		in2 <= x"3333";
		in3 <= x"4444";
		in4 <= x"5555";
		in5 <= x"AAAA";
		in6 <= x"9999";
		in7 <= x"7777";
		in8 <= x"8888";
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '0';
		s2 <= '0';
		
		wait for 10ns;
		s0 <= '0';
		s1 <= '1';
		s2 <= '0';
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '1';
		s2 <= '0';
		
		wait for 10ns;
		s0 <= '0';
		s1 <= '0';
		s2 <= '1';
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '0';
		s2 <= '1';
		
		wait for 10ns;
		s0 <= '0';
		s1 <= '1';
		s2 <= '1';
		
		wait for 10ns;
		s0 <= '1';
		s1 <= '1';
		s2 <= '1';
    end process;

end;