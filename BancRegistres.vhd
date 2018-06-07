----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:57:31 05/18/2018 
-- Design Name: 
-- Module Name:    BancRegistres - Behavioral 
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
USE ieee.numeric_std.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BancRegistres is
    Port ( clk : in STD_LOGIC := '0';
			  AdrA : in  STD_LOGIC_VECTOR (15 downto 0);
           AdrB : in  STD_LOGIC_VECTOR (15 downto 0);
           AdrW : in  STD_LOGIC_VECTOR (15 downto 0);
           QA : out  STD_LOGIC_VECTOR (15 downto 0);
           QB : out  STD_LOGIC_VECTOR (15 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC);
end BancRegistres;

architecture Behavioral of BancRegistres is

type arrayRegister is array (integer range <>) of STD_LOGIC_VECTOR (15 downto 0);
signal registers : arrayRegister (0 to 15);

begin

	-- Lecture des valeurs si pas d'ecriture ou si ecriture dans un autre registre
	QA <= registers(to_integer(unsigned(AdrA))) when W='0' or AdrA /= AdrW else DATA; 
	QB <= registers(to_integer(unsigned(AdrB))) when W='0' or AdrB /= AdrW else DATA;	
	process
	begin
		wait until clk'event and clk='1'; 
		if RST = '0' then registers <= (others => x"0000"); -- Remise de tous les registres à 0 si RST = 0
		elsif W='1' then registers(to_integer(unsigned(AdrW)))<= DATA ; -- Si W = 1 , DATA -> W
		end if;
	end process;

end Behavioral;