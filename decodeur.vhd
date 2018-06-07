----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:18:01 05/28/2018 
-- Design Name: 
-- Module Name:    decodeur - Behavioral 
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

entity decodeur is
    Port ( INS_DI : in  STD_LOGIC_VECTOR (31 downto 0);
           A : out  STD_LOGIC_VECTOR (15 downto 0);
           OP : out  STD_LOGIC_VECTOR (7 downto 0);
           B : out  STD_LOGIC_VECTOR (15 downto 0);
           C : out  STD_LOGIC_VECTOR (15 downto 0));
end decodeur;

architecture Behavioral of decodeur is

signal op_int : STD_LOGIC_VECTOR (7 downto 0);

begin

	op_int <= INS_DI(31 downto 24);
	OP <= op_int;

	A	<= x"00" & INS_DI(15 downto 8) when op_int = x"07" else x"00" & INS_DI(23 downto 16);
	B <= x"00" & INS_DI(15 downto 8) when op_int = x"08" or op_int = x"0f" or op_int = x"0e" else x"00" & INS_DI(23 downto 16);
	C <= x"00" & INS_DI(23 downto 16) when op_int = x"07" else x"0000" when op_int = x"08" or op_int = x"0f" or op_int = x"0e" else x"00" & INS_DI(15 downto 8); 

end Behavioral;

