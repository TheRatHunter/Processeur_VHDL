--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:54:25 05/28/2018
-- Design Name:   
-- Module Name:   /home/chassera/Processeur/testDecodeur.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: decodeur
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
 
ENTITY testDecodeur IS
END testDecodeur;
 
ARCHITECTURE behavior OF testDecodeur IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT decodeur
    PORT(
         INS_DI : IN  std_logic_vector(31 downto 0);
         A : OUT  std_logic_vector(15 downto 0);
         OP : OUT  std_logic_vector(7 downto 0);
         B : OUT  std_logic_vector(15 downto 0);
         C : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal INS_DI : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal A : std_logic_vector(15 downto 0);
   signal OP : std_logic_vector(7 downto 0);
   signal B : std_logic_vector(15 downto 0);
   signal C : std_logic_vector(15 downto 0);
   -- No clocks detected in port list. Replace clk below with 
   -- appropriate port name 
	
	signal clk: std_logic := '0';
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: decodeur PORT MAP (
          INS_DI => INS_DI,
          A => A,
          OP => OP,
          B => B,
          C => C
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
		
		INS_DI <= x"01123456";
		
		wait for 100 ns;
		
		INS_DI <= x"07654321";
		
		

		

      wait;
   end process;

END;
