----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2018 02:43:02 PM
-- Design Name: 
-- Module Name: memoryM - Behavioral
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

entity memoryM is
    Port ( 
        address : in STD_LOGIC_VECTOR (15 downto 0);
        write_data : in  STD_LOGIC_VECTOR (15 downto 0);
        MW, MR : in  STD_LOGIC;
        clk : in STD_LOGIC;
        
        out_data : out  STD_LOGIC_VECTOR (15 downto 0)
    );
end memoryM;

architecture Behavioral of memoryM is type mem_array is array(0 to 511) of std_logic_vector(15 downto 0);

begin
memory_m: process(address, write_data, MW)
	variable control_mem : mem_array:=(
		-- 0
		X"FFFFFFF", -- 0
		X"0000000", -- 1
		X"AAAAAAA", -- 2
		X"0000000", -- 3
		X"BBBBBBB", -- 4
		X"0000000", -- 5
		X"CCCCCCC", -- 6
		X"0000000", -- 7
		X"DDDDDDD", -- 8
		X"0000000", --
		X"1111111", -- A
		X"0000000", -- B
		X"2222222", -- C
		X"0000000", -- D
		X"3333333", -- E
		X"0000000", -- F
				-- 1	
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7				
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F
				
				-- 2
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7				
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

		-- 3
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7				
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

				-- 4
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

				-- 5
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7				
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

				-- 6
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
	    X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

		-- 7
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

				-- 8
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

				-- 9
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F
				-- A
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F
				-- B
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7		
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F
				
		-- C
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

				-- D
		X"0000000", -- 0
		X"0000000", -- 1
	    X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7				
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F
				
				-- E
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7				
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F

		-- F
		X"0000000", -- 0
		X"0000000", -- 1
		X"0000000", -- 2
		X"0000000", -- 3
		X"0000000", -- 4
		X"0000000", -- 5
		X"0000000", -- 6
		X"0000000", -- 7			
		X"0000000", -- 8
		X"0000000", -- 9
		X"0000000", -- A
		X"0000000", -- B
		X"0000000", -- C
		X"0000000", -- D
		X"0000000", -- E
		X"0000000", -- F
		
		
                -- 10
                X"FFFFFFF", -- 0
                X"0000000", -- 1
                X"AAAAAAA", -- 2
                X"0000000", -- 3
                X"BBBBBBB", -- 4
                X"0000000", -- 5
                X"CCCCCCC", -- 6
                X"0000000", -- 7
                X"DDDDDDD", -- 8
                X"0000000", --
                X"1111111", -- A
                X"0000000", -- B
                X"2222222", -- C
                X"0000000", -- D
                X"3333333", -- E
                X"0000000", -- F
                        -- 11    
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7                
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
                        
                        -- 12
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7                
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                -- 13
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7                
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                        -- 14
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                        -- 15
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7                
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                        -- 16
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                -- 17
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                        -- 18
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                        -- 19
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
                        -- A1
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
                        -- B2
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7        
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
                        
                -- C2
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                        -- D2
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7                
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
                        
                        -- E2
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7                
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000", -- F
        
                -- F2
                X"0000000", -- 0
                X"0000000", -- 1
                X"0000000", -- 2
                X"0000000", -- 3
                X"0000000", -- 4
                X"0000000", -- 5
                X"0000000", -- 6
                X"0000000", -- 7            
                X"0000000", -- 8
                X"0000000", -- 9
                X"0000000", -- A
                X"0000000", -- B
                X"0000000", -- C
                X"0000000", -- D
                X"0000000", -- E
                X"0000000" -- F
    );
    variable addr:integer;
        begin 
        addr:=conv_integer(address(2 downto 0));
            if MW ='1' then
                control_mem(addr):= write_data;
            else  
                out_data <= control_mem(addr) after 10 ns;
            end if;
        end process;


end Behavioral;
