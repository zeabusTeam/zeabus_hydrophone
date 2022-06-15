library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity slaveFIFO2b_streamIN is
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

end entity slaveFIFO2b_streamIN;

architecture slaveFIFO2b_streamIN_arch of slaveFIFO2b_streamIN is
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
--stream IN fsm
type streamIN_states is (stream_in_idle, stream_in_wait_flagb, stream_in_write, stream_in_write_wr_delay);
signal current_stream_in_state, next_stream_in_state : streamIN_states;

signal data_gen_stream_in   : std_logic_vector(31 downto 0);
signal slwr_streamIN_n      : std_logic;
signal slwr_streamIN_n_d    : std_logic;
signal flaga_d             : std_logic;
signal flagb_d             : std_logic;
signal flagc_d             : std_logic;
signal flagd_d             : std_logic;
signal clk_100             : std_logic;
signal lock                : std_logic;
signal reset_n             : std_logic;


begin --architecture begining
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
slrd   <= '1';
slwr   <= slwr_streamIN_n_d;   
faddr  <= "00";
sloe   <= '1';
pktend <= '1';
PMODE  <= "11";		
RESET  <= '1';	
slcs   <= '0';

process(current_stream_in_state)begin
	if((current_stream_in_state = stream_in_write))then
		slwr_streamIN_n <= '0';
	else
		slwr_streamIN_n <= '1';
	end if;
end process;	

process(clk_100, reset_n)begin
	if(reset_n = '0')then
		slwr_streamIN_n_d <= '1';
	elsif(clk_100'event and clk_100 = '1')then
		slwr_streamIN_n_d <= slwr_streamIN_n;
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

--streamIN mode state machine
stream_in_fsm_f : process(clk_100, reset_n)begin
	if(reset_n = '0')then 
		current_stream_in_state <= stream_in_idle;
	elsif(clk_100'event and clk_100 = '1')then 
		current_stream_in_state <= next_stream_in_state;
	end if;	
end process;

--StreamIN mode state machine combo
stream_in_fsm : process(current_stream_in_state, flaga_d, flagb_d)begin
	next_stream_in_state <= current_stream_in_state;
	case current_stream_in_state is
	when stream_in_idle =>
		if((flaga_d = '1'))then
			next_stream_in_state <= stream_in_wait_flagb; 
		else 
			next_stream_in_state <= stream_in_idle;
		end if;	
	
	when stream_in_wait_flagb =>
		if (flagb_d = '1')then
			next_stream_in_state <= stream_in_write; 
		else 
			next_stream_in_state <= stream_in_wait_flagb; 
		end if;
	
	when stream_in_write =>
		if(flagb_d = '0')then
			next_stream_in_state <= stream_in_write_wr_delay;
		else
		 	next_stream_in_state <= stream_in_write;
		end if;
	
        when stream_in_write_wr_delay =>
		next_stream_in_state <= stream_in_idle;
	when others =>
		next_stream_in_state <= stream_in_idle;
		
	end case;
end process;

--data generator counter for Partial mode
process(clk_100, reset_n)begin
	if(reset_n = '0')then
		data_gen_stream_in <= (others => '0');
	elsif(clk_100'event and clk_100 = '1')then
		if((slwr_streamIN_n_d = '0'))then
			data_gen_stream_in <= data_gen_stream_in + '1';
		end if;	
	end if;	
end process;

process(slwr_streamIN_n_d, data_gen_stream_in)begin
	if(slwr_streamIN_n_d = '0')then
		fdata <= data_gen_stream_in;
	else
		fdata <= (others => 'Z');	
	end if;
end process;

end architecture;

