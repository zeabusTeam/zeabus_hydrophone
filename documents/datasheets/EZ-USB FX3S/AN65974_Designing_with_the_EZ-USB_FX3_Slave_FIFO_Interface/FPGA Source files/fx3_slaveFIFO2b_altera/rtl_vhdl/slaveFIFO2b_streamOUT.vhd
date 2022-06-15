library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity slaveFIFO2b_streamOUT is
	port(
		reset_in_n : in std_logic;                                ---input reset active low
		clk	   : in std_logic;                                ---input clp 50 Mhz  
		clk_out	   : out std_logic;                               ---output clk 100 Mhz 
		slcs 	   : out std_logic;                               ---output chip select
		fdata      : inout std_logic_vector(31 downto 0);         
		faddr      : out std_logic_vector(1 downto 0);            ---output fifo address
		slrd	   : out std_logic;                               ---output read select
		sloe	   : out std_logic;                               ---output output enable select
		slwr	   : out std_logic;                               ---output write select
                    
                flaga	   : in std_logic;                                
                flagb	   : in std_logic;
                flagc	   : in std_logic;
                flagd	   : in std_logic;

		pktend	   : out std_logic;                               ---output pkt end 
		PMODE	   : out std_logic_vector(1 downto 0);
		RESET	   : out std_logic
--		PMODE_2	   : out std_logic
--		int_n      : in std_logic;
--		tri_state  : in std_logic_vector(12 downto 0)
	    );

end entity slaveFIFO2b_streamOUT;

architecture slaveFIFO2b_streamOUT_arch of slaveFIFO2b_streamOUT is
--pll
component pll
	port(
	     areset	: in std_logic;
	     c0         : out std_logic;
	     inclk0     : in std_logic;
	     locked	: out std_logic);
end component;

component ddr
	port(
     	    datain_h    : in std_logic;
            datain_l    : in std_logic;
            outclock    : in std_logic;
	    dataout	: out std_logic);
end component; 

--stream OUT fsm
type streamOUT_states is (stream_out_idle, stream_out_flagc_rcvd, stream_out_wait_flagd, stream_out_read, stream_out_read_rd_and_oe_delay, stream_out_read_oe_delay);
signal current_stream_out_state, next_stream_out_state : streamOUT_states;

signal rd_oe_delay_cnt     : std_logic_vector(1 downto 0);
signal oe_delay_cnt        : std_logic_vector(1 downto 0);
signal data_in_stream_out  : std_logic_vector(31 downto 0);
signal slrd_streamOUT_n    : std_logic;
signal sloe_streamOUT_n    : std_logic;
signal flaga_d             : std_logic;
signal flagb_d             : std_logic;
signal flagc_d             : std_logic;
signal flagd_d             : std_logic;
signal clk_100             : std_logic;
signal lock                : std_logic;
signal reset_n             : std_logic;


begin  -- architecture begin
--pll instantiation
pll_inst : pll
	port map(
	     areset	=> '0',
	     c0         => clk_100,
	     inclk0     => clk,
	     locked	=> lock
        );

---ddr instantiation
ddr_inst : ddr
     	port map(
             datain_h   => '0',
             datain_l   => '1',
             outclock   => clk_100,
             dataout	=> clk_out
     ); 

reset_n <= lock;
--output signal asignments
slrd   <= slrd_streamOUT_n;
slwr   <= '1';   
faddr  <= "11";
sloe   <= sloe_streamOUT_n;
pktend <= '1';
PMODE  <= "11";		
RESET  <= '1';	
slcs   <= '0';

data_in_stream_out <= fdata;


     
--OUTPUT read control signals generation
process(current_stream_out_state)begin
	if((current_stream_out_state = stream_out_read) or (current_stream_out_state = stream_out_read_rd_and_oe_delay))then
		slrd_streamOUT_n <= '0';
	else
		slrd_streamOUT_n <= '1';
	end if;	
end process;	



--OUTPUT read oe control signals generation
process(current_stream_out_state)begin
	if((current_stream_out_state = stream_out_read) or (current_stream_out_state = stream_out_read_rd_and_oe_delay) or (current_stream_out_state = stream_out_read_oe_delay)) then
		sloe_streamOUT_n <= '0';
	else
	 	sloe_streamOUT_n <= '1';
	end if;
end process;

--flopping the INPUTs flags
process(clk_100, reset_n)begin
	if(reset_n = '0')then 
		flaga_d <= '0';
		flagb_d <= '0';
		flagc_d <= '0';
		flagd_d <= '0';
	elsif(clk_100'event and clk_100 = '1')then
		flaga_d <= flaga;
		flagb_d <= flagb;
		flagc_d <= flagc;
		flagd_d <= flagd;
	end if;	
end process;


--counter to delay the read and output enable signal
process(clk_100, reset_n)begin
	if(reset_n = '0')then 
		rd_oe_delay_cnt <= "00";
	elsif(clk_100'event and clk_100 = '1')then	
	 	if(current_stream_out_state = stream_out_read) then
			rd_oe_delay_cnt <= "01";
        	elsif((current_stream_out_state = stream_out_read_rd_and_oe_delay) and (rd_oe_delay_cnt > 0))then
			rd_oe_delay_cnt <= rd_oe_delay_cnt - 1;
		else
			rd_oe_delay_cnt <= rd_oe_delay_cnt;
		end if;
	end if;
end process;

--Counter to delay the OUTPUT Enable(oe) signal
process(clk_100, reset_n)begin
	if(reset_n = '0')then 
		oe_delay_cnt <= "00";
	elsif(clk_100'event and clk_100 = '1')then	
	 	if(current_stream_out_state = stream_out_read_rd_and_oe_delay) then
			oe_delay_cnt <= "10";
        	elsif((current_stream_out_state = stream_out_read_oe_delay) and (oe_delay_cnt > 0))then
			oe_delay_cnt <= oe_delay_cnt - 1;
		else
			oe_delay_cnt <= oe_delay_cnt;
		end if;
	end if;
end process;


--streamOUT mode state machine
stream_out_fsm_f : process(clk_100, reset_n)begin
	if(reset_n = '0')then
		current_stream_out_state <= stream_out_idle;
	elsif(clk_100'event and clk_100 = '1')then 
		current_stream_out_state <= next_stream_out_state;
	end if;	
end process;

--steamOUT mode state machine combo
stream_out_fsm : process(current_stream_out_state, flagc_d, flagd_d, rd_oe_delay_cnt, oe_delay_cnt)begin
	next_stream_out_state <= current_stream_out_state;
	case current_stream_out_state is
	when stream_out_idle =>
		if((flagc_d = '1'))then
			next_stream_out_state <= stream_out_flagc_rcvd;
		else 
			next_stream_out_state <= stream_out_idle;
		end if;
		
        when stream_out_flagc_rcvd =>
		next_stream_out_state <= stream_out_wait_flagd;
	
	when stream_out_wait_flagd =>
		if(flagd_d = '1')then
			next_stream_out_state <= stream_out_read;
		else
			next_stream_out_state <= stream_out_wait_flagd;
		end if;
		
        when stream_out_read =>
		if(flagd_d = '0')then
			next_stream_out_state <= stream_out_read_rd_and_oe_delay;
		else
			next_stream_out_state <= stream_out_read;
		end if;
	
	when stream_out_read_rd_and_oe_delay =>
		if(rd_oe_delay_cnt = "00")then
			next_stream_out_state <= stream_out_read_oe_delay;
		else
			next_stream_out_state <= stream_out_read_rd_and_oe_delay;
		end if;
	
        when stream_out_read_oe_delay =>
		if(oe_delay_cnt = "00")then
			next_stream_out_state <= stream_out_idle;
		else
			next_stream_out_state <= stream_out_read_oe_delay;
		end if;
	when others =>
		next_stream_out_state <= stream_out_idle;
		
	end case;
end process;

end architecture;

