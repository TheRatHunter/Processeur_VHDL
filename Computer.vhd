----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:27:45 06/04/2018 
-- Design Name: 
-- Module Name:    Computer - Behavioral 
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

entity Computer is
    Port ( clk : in  STD_LOGIC;
			  rst : in STD_LOGIC
			  );
end Computer;

architecture Behavioral of Computer is
	component System
		Port ( clk : in  STD_LOGIC;
           ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC;
			  data_di : in STD_LOGIC_VECTOR (15 downto 0);
			  data_we : out STD_LOGIC;
			  data_a : out STD_LOGIC_VECTOR (15 downto 0);
			  data_do: out STD_LOGIC_VECTOR (15 downto 0);
			  ins_a: out STD_LOGIC_VECTOR (15 downto 0));
  end component;
  
  component bram16
	generic (
    init_file : String := "none";
    adr_width : Integer := 11);
	  port (
	  -- System
	  sys_clk : in std_logic;
	  sys_rst : in std_logic;
	  -- Master
	  di : out std_logic_vector(15 downto 0);
	  we : in std_logic;
	  a : in std_logic_vector(15 downto 0);
	  do : in std_logic_vector(15 downto 0));
	end component;
	
	component bram32
	  generic (
		 adr_width : Integer := 11);
	  port (
	  -- System
	  sys_clk : in std_logic;
	  sys_rst : in std_logic;
	  -- Master
	  di : out std_logic_vector(31 downto 0);
	  we : in std_logic;
	  a : in std_logic_vector(15 downto 0);
	  do : in std_logic_vector(31 downto 0));
	end component;
	
	type sig_system is record
		clk, rst, data_we : STD_LOGIC;
		ins_di : STD_LOGIC_VECTOR (31 downto 0);
		data_di,  data_a, data_do, ins_a : STD_LOGIC_VECTOR (15 downto 0);
	end record;
	signal syst : sig_system;
	
	type sig_ram is record
		sys_clk, sys_rst, we : STD_LOGIC;
		di, a, do: STD_LOGIC_VECTOR (15 downto 0);
	end record;
	signal ram : sig_ram;
	
	type sig_rom is record
		sys_clk, sys_rst, we : STD_LOGIC;
		a: STD_LOGIC_VECTOR (15 downto 0);
		di, do: STD_LOGIC_VECTOR (31 downto 0);
	end record;
	signal rom : sig_rom;
	
	  
	  

begin

	ma_ram : bram16 port map (sys_clk => clk,
									  sys_rst => rst,
									  we => syst.data_we,
									  di => ram.di,
									  a => syst.data_a,
									  do => syst.data_do);
									  
	mon_syst : System port map (clk => clk,
										 rst => rst,
										 ins_di => rom.di,
										 data_di => ram.di,
										 data_we => syst.data_we,
										 data_a => syst.data_a,
										 data_do => syst.data_do,
										 ins_a => syst.ins_a);
										 
	ma_rom : bram32 port map (sys_clk => clk,
									  sys_rst => rst,
									  di => rom.di,
									  a => syst.ins_a(13 downto 0)&"00" ,
									  we => '0',
									  do => x"00000000" );

end Behavioral;

