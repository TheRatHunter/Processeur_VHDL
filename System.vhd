----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:03:55 05/03/2018 
-- Design Name: 
-- Module Name:    System - Behavioral 
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

entity System is
    Port ( clk : in  STD_LOGIC;
           ins_di : in  STD_LOGIC_VECTOR (31 downto 0);
			  RST : in STD_LOGIC;
			  data_di : in STD_LOGIC_VECTOR (15 downto 0);
			  data_we : out STD_LOGIC;
			  data_a : out STD_LOGIC_VECTOR (15 downto 0);
			  data_do: out STD_LOGIC_VECTOR (15 downto 0);
			  ins_a: out STD_LOGIC_VECTOR (15 downto 0));
end System;

architecture Behavioral of System is

	component UAL
		port (
			A : in std_logic_vector (15 downto 0);
			B : in std_logic_vector (15 downto 0);
			S : out std_logic_vector (15 downto 0);
			op : in std_logic_vector (7 downto 0);
			flags : out std_logic_vector (3 downto 0)
		);
	end component;
	
	component PIPELINE
		port (
			op_out : out STD_LOGIC_VECTOR (7 downto 0);
			A_out : out STD_LOGIC_VECTOR (15 downto 0);
			B_out : out STD_LOGIC_VECTOR (15 downto 0);
			C_out : out STD_LOGIC_VECTOR (15 downto 0);
			op_in : in STD_LOGIC_VECTOR (7 downto 0);
			A_in : in STD_LOGIC_VECTOR (15 downto 0);
			B_in : in STD_LOGIC_VECTOR (15 downto 0);
			C_in : in STD_LOGIC_VECTOR (15 downto 0);
			clk : in STD_LOGIC := '0'
		);
	end component;
	
	component DECODEUR
		port (
			INS_DI : in  STD_LOGIC_VECTOR (31 downto 0);
			A : out  STD_LOGIC_VECTOR (15 downto 0);
			OP : out  STD_LOGIC_VECTOR (7 downto 0);
			B : out  STD_LOGIC_VECTOR (15 downto 0);
			C : out  STD_LOGIC_VECTOR (15 downto 0)
		);
	end component;
		
	component BANCREGISTRES
		port ( clk : in STD_LOGIC := '0';
			  AdrA : in  STD_LOGIC_VECTOR (15 downto 0);
           AdrB : in  STD_LOGIC_VECTOR (15 downto 0);
           AdrW : in  STD_LOGIC_VECTOR (15 downto 0);
           QA : out  STD_LOGIC_VECTOR (15 downto 0);
           QB : out  STD_LOGIC_VECTOR (15 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (15 downto 0);
           RST : in  STD_LOGIC
		);
	end component;
	
	-- Signaux pour relier les composants entre eux
	type sig_dec is record
		op : STD_LOGIC_VECTOR (7 downto 0);
		a,b,c : STD_LOGIC_VECTOR (15 downto 0);
	end record;
	signal di : sig_dec;
	
	type sig_br is record
		adra : STD_LOGIC_VECTOR (15 downto 0);
		adrb : STD_LOGIC_VECTOR (15 downto 0);
		adrw : STD_LOGIC_VECTOR (15 downto 0);
		qa : STD_LOGIC_VECTOR (15 downto 0);
		qb : STD_LOGIC_VECTOR (15 downto 0);
		w : STD_LOGIC;
		data : STD_LOGIC_VECTOR (15 downto 0);
		rst : STD_LOGIC;
	end record;
	signal br : sig_br;
		
	type sig_pip is record
		op_out, op_in : STD_LOGIC_VECTOR (7 downto 0);
      A_out, B_out, C_out : STD_LOGIC_VECTOR (15 downto 0);
	   A_in, B_in, C_in : STD_LOGIC_VECTOR (15 downto 0);
	end record;	
	signal p0, p1, p2, p3 : sig_pip;
	
	type sig_ual is record
		a, b, s : std_logic_vector (15 downto 0);
		op : std_logic_vector (7 downto 0);
		flags : std_logic_vector (3 downto 0);
	end record;
	signal ualsig : sig_ual;
	
	
	signal val_W : std_logic;
	signal val_C : std_logic_vector (15 downto 0);
	signal val_B2 : std_logic_vector (15 downto 0);
	signal val_DATA : std_logic_vector (15 downto 0);
	signal val_data_a : std_logic_vector (15 downto 0);
	
	
	signal compteur : std_logic_vector (15 downto 0) := (others => '0');
	
begin
	 dec : DECODEUR port map (INS_DI => ins_di, A => di.a, B => di.b, OP => di.op, C => di.c);
	 
	 pip0 : PIPELINE port map (op_out => p0.op_out, A_out => p0.A_out, B_out => p0.B_out, C_out => p0.C_out, op_in => di.op, A_in => di.a, B_in => di.b, C_in => di.c, clk => clk);
	 
	 banc_reg : BANCREGISTRES port map (clk => clk, AdrA => p0.B_out, AdrB => p0.C_out, AdrW => p3.A_out, QA => br.qa, QB => br.qb, W => val_W, DATA => val_DATA, RST => RST);

	 val_W <= '0' when (p3.op_out = x"05" or p3.op_out = x"08" or p3.op_out=x"0e" or p3.op_out=x"0f") else '1';
	 val_C <= p0.C_out when (p0.op_out = x"05" or p0.op_out = x"06" or p0.op_out=x"07" or p0.op_out=x"0e") else br.qb;	 
	 val_B2 <= ualsig.s when (p1.op_out = x"01" or p1.op_out = x"02" or p1.op_out=x"03") else p1.B_out when (p1.op_out=x"08") else p1.C_out ;
	 val_DATA <= data_di when (p3.op_out = x"07") else p3.B_out;
	 val_data_a <= p2.A_out when (p2.op_out = x"08") else p2.B_out;

	 
	 pip1 : PIPELINE port map (op_out=>p1.op_out, A_out=>p1.A_out, B_out=>p1.B_out, C_out=>p1.C_out, op_in=>p0.op_out, A_in=>p0.A_out, B_in=> br.qa, C_in=> val_C, clk=>clk);
	 
	 ual1 : UAL port map (A=> p1.B_out, B=>p1.C_out , S=>ualsig.s , op=>p1.op_out , flags=> ualsig.flags);
	 
	 pip2 : PIPELINE port map (op_out=>p2.op_out, A_out=>p2.A_out, B_out=>p2.B_out, C_out=>p2.C_out, op_in=>p1.op_out, A_in=>p1.A_out, B_in=>val_B2, C_in=>x"abcd", clk=>clk);
	 
	 pip3 : PIPELINE port map (op_out => p3.op_out, A_out => p3.A_out, B_out => p3.B_out, C_out => p3.C_out, op_in => p2.op_out, A_in => p2.A_out, B_in => p2.B_out, C_in => p2.C_out, clk => clk);
	 
	 
	 data_do <= p2.B_out;
	 
	 data_we <= '1' when (p2.op_out = x"08") else '0';
	 
	 data_a <= val_data_a; 
	 
	 ins_a <= compteur;
	 
	 process
		begin
			wait until clk'event and clk='1';
			compteur <= compteur+x"0001";
	 end process;
	 
	 
	 

end Behavioral;

