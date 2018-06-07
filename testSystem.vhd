--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:13:55 05/04/2018
-- Design Name:   
-- Module Name:   /home/chassera/Processeur/testSystem.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: System
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testSystem IS
END testSystem;
 
ARCHITECTURE behavior OF testSystem IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT System
    Port ( clk : in  STD_LOGIC;
           ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC;
			  data_di : in STD_LOGIC_VECTOR (15 downto 0);
			  data_we : out STD_LOGIC;
			  data_a : out STD_LOGIC_VECTOR (15 downto 0);
			  data_do: out STD_LOGIC_VECTOR (15 downto 0);
			  ins_a: out STD_LOGIC_VECTOR (15 downto 0));
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal ins_di : std_logic_vector(31 downto 0) := (others => '0');
	signal data_di : std_logic_vector(15 downto 0) := (others => '0');
	signal data_we : std_logic := '0';
	signal data_a : std_logic_vector(15 downto 0) := (others => '0');
	signal data_do : std_logic_vector(15 downto 0) := (others => '0');
	signal ins_a : std_logic_vector(15 downto 0) := (others => '0');
	signal RST : std_logic := '0';

 	--Outputs

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: System PORT MAP (
          clk => clk,
			 ins_di => ins_di,
			 data_di => data_di,
			 data_we => data_we,
			 data_a => data_a,
			 data_do => data_do,
			 ins_a => ins_a,
			 RST => RST
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		
		RST <= '1';
		--afc r3 2
		ins_di <= x"06030200";
		
		wait for 200 ns;
		
		--afc r5 6 
		ins_di <= x"06050600";
		
		wait for 200 ns;
		
		--add r3 r5
		ins_di <= x"01030500";
		
		wait for 200 ns;
		
		--mul r3 r3
		ins_di <= x"02030300";
		
		wait for 200 ns;
		
		--store 10 r5
		ins_di <= x"08100300";
		
		wait for 200 ns;
		
		--load 10 r1
		ins_di <= x"07100100";
		
      wait;
   end process;

END;
