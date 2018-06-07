--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:36:29 05/03/2018
-- Design Name:   
-- Module Name:   /home/chassera/Processeur/testPipeline.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Pipeline
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
 
ENTITY testPipeline IS
END testPipeline;
 
ARCHITECTURE behavior OF testPipeline IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pipeline
    PORT(
         op_out : OUT  std_logic_vector(7 downto 0);
         A_out : OUT  std_logic_vector(15 downto 0);
         B_out : OUT  std_logic_vector(15 downto 0);
         C_out : OUT  std_logic_vector(15 downto 0);
         op_in : IN  std_logic_vector(7 downto 0);
         A_in : IN  std_logic_vector(15 downto 0);
         B_in : IN  std_logic_vector(15 downto 0);
         C_in : IN  std_logic_vector(15 downto 0);
			clk : IN std_logic := '0'
        );
    END COMPONENT;
    

   --Inputs
   signal op_in : std_logic_vector(7 downto 0) := (others => '0');
   signal A_in : std_logic_vector(15 downto 0) := (others => '0');
   signal B_in : std_logic_vector(15 downto 0) := (others => '0');
   signal C_in : std_logic_vector(15 downto 0) := (others => '0');
	signal clk: std_logic := '0';

 	--Outputs
   signal op_out : std_logic_vector(7 downto 0);
   signal A_out : std_logic_vector(15 downto 0);
   signal B_out : std_logic_vector(15 downto 0);
   signal C_out : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Pipeline PORT MAP (
          op_out => op_out,
          A_out => A_out,
          B_out => B_out,
          C_out => C_out,
          op_in => op_in,
          A_in => A_in,
          B_in => B_in,
          C_in => C_in,
			 clk => clk
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
		
		op_in <= x"01" after 100 ns;
		A_in <= x"0022" after 100 ns;
		B_in <= x"0033" after 100 ns;
		C_in <= x"0044" after 100 ns;

      wait;
   end process;

END;
