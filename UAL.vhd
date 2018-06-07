----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:35:58 05/03/2018 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
           S : out  STD_LOGIC_VECTOR (15 downto 0);
           op : in  STD_LOGIC_VECTOR (7 downto 0);
           flags : out  STD_LOGIC_VECTOR (3 downto 0));
end UAL;

architecture Behavioral of UAL is

	signal Smul: STD_LOGIC_VECTOR (31 downto 0);
	signal Stemp: STD_LOGIC_VECTOR (16 downto 0);
	
begin

	Stemp <=(('0'&A)+('0'&B)) when op=x"01" else
	(('0'&A)-('0'&B)) when op=x"03" else
	Smul(16 downto 0) when op=x"02" else --Smul est sur 16 bits
	"00"&A(15 downto 1) when op=x"fe" else
	'0'&A(14 downto 0)&'0' when op=x"ff" else
	(others => 'U');
	
	--ZNCV
	flags(3)<='1' when Stemp(15 downto 0)=x"0000" else '0';
	flags(2)<='1' when Stemp(15)='1' else '0';
	flags(1)<='1' when Stemp(16)='1' else '0';
	flags(0)<='1' when (    (Stemp(15)='1' and A(15)='0' and B(15)='0')
							 or   (Stemp(15)='0' and A(15)='1' and B(15)='1') ) else '0';
	
	Smul <=A*B;
	
	S<=Stemp(15 downto 0);
	
end Behavioral;

