--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:41:47 05/03/2018
-- Design Name:   
-- Module Name:   /home/chassera/Processeur/testUAL.vhd
-- Project Name:  Processeur
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UAL
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
 
ENTITY testUAL IS
END testUAL;
 
ARCHITECTURE behavior OF testUAL IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UAL
    PORT(
         A : IN  std_logic_vector(15 downto 0);
         B : IN  std_logic_vector(15 downto 0);
         S : OUT  std_logic_vector(15 downto 0);
         op : IN  std_logic_vector(7 downto 0);
         flags : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(15 downto 0) := (others => '0');
   signal B : std_logic_vector(15 downto 0) := (others => '0');
   signal op : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal S : std_logic_vector(15 downto 0);
   signal flags : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal my_clock: std_logic := '0';
   constant my_clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UAL PORT MAP (
          A => A,
          B => B,
          S => S,
          op => op,
          flags => flags
        );

   -- Clock process definitions
   my_clock_process :process
   begin
		my_clock <= '0';
		wait for my_clock_period/2;
		my_clock <= '1';
		wait for my_clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for my_clock_period*10;

      -- insert stimulus here 
		op <= x"00";
		A <= x"FFFF";
		B <= x"0001";
		
		op <= x"01" after 100 ns;
		A <= x"0009" after 100 ns;
		B <= x"000F" after 100 ns;
		
		op <= x"02" after 200 ns;
		A <= x"0009" after 200 ns;
		B <= x"0007" after 200 ns;
		
		op <= x"03" after 300 ns;
		A <= x"000E" after 300 ns;
		
		op <= x"04" after 400 ns;
		A <= x"0007" after 400 ns;

      wait;
   end process;

END;
