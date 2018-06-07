----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:34:03 05/03/2018 
-- Design Name: 
-- Module Name:    Pipeline - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pipeline is
    Port ( op_out : out  STD_LOGIC_VECTOR (7 downto 0);
           A_out : out  STD_LOGIC_VECTOR (15 downto 0);
           B_out : out  STD_LOGIC_VECTOR (15 downto 0);
           C_out : out  STD_LOGIC_VECTOR (15 downto 0);
           op_in : in  STD_LOGIC_VECTOR (7 downto 0);
           A_in : in  STD_LOGIC_VECTOR (15 downto 0);
           B_in : in  STD_LOGIC_VECTOR (15 downto 0);
           C_in : in  STD_LOGIC_VECTOR (15 downto 0);
			  clk : in STD_LOGIC := '0');
end Pipeline;

architecture Behavioral of Pipeline is

begin
	process
	begin
		wait until clk'event and clk='1';
		op_out<=op_in;
		A_out<=A_in;
		B_out<=B_in;
		C_out<=C_in;
	end process;


end Behavioral;

