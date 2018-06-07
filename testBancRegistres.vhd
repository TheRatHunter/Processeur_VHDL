--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:20:39 05/18/2018
-- Design Name:   
-- Module Name:   /home/chassera/Processeur/testBancRegistres.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: BancRegistres
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
 
ENTITY testBancRegistres IS
END testBancRegistres;
 
ARCHITECTURE behavior OF testBancRegistres IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT BancRegistres
    PORT(
         clk : IN  std_logic;
         AdrA : IN  std_logic_vector(15 downto 0);
         AdrB : IN  std_logic_vector(15 downto 0);
         AdrW : IN  std_logic_vector(15 downto 0);
         QA : OUT  std_logic_vector(15 downto 0);
         QB : OUT  std_logic_vector(15 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(15 downto 0);
         RST : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal AdrA : std_logic_vector(15 downto 0) := (others => '0');
   signal AdrB : std_logic_vector(15 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(15 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal AdrW : std_logic_vector(15 downto 0) := (others => '0');

 	--Outputs
   signal QA : std_logic_vector(15 downto 0);
   signal QB : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: BancRegistres PORT MAP (
          clk => clk,
          AdrA => AdrA,
          AdrB => AdrB,
          AdrW => AdrW,
          QA => QA,
          QB => QB,
          W => W,
          DATA => DATA,
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
		
		wait for 100 ns;
		
		W <= '1';
		
		wait for 100 ns;
		
		AdrW <= x"0000";
		DATA <= x"bbbb";
		
		wait for 100 ns;
		
		AdrW <= x"0001";
		DATA <= x"cccc";
		
		wait for 100 ns;
		
		W <= '0';
		AdrA <= x"0000";
		AdrB <= x"0001";
		
      wait;
   end process;

END;
