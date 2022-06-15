library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity slaveFIFO2b_partial is
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

	end entity slaveFIFO2b_partial;

architecture slaveFIFO2b_partial_arch of slaveFIFO2b_partial is
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

--partial fsm
type partial_states is (partial_idle, partial_wait_flagb, partial_write, partial_write_wr_delay, partial_wait);
signal current_partial_state, next_partial_state : partial_states;

signal short_pkt_cnt       : std_logic_vector(3 downto 0);
signal strob_cnt           : std_logic_vector(3 downto 0);
signal strob		   : std_logic;
signal data_gen_partial    : std_logic_vector(31 downto 0);
signal slwr_partial_n	   : std_logic;
signal slwr_partial_n_d	   : std_logic;
signal pktend_partial_n	   : std_logic;
signal pktend_partial_n_d  : std_logic;
signal flaga_d             : std_logic;
signal flagb_d             : std_logic;
signal flagc_d             : std_logic;
signal flagd_d             : std_logic;
signal clk_100             : std_logic;
signal lock                : std_logic;
signal reset_n             : std_logic;


begin -- architecture begining
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
slwr   <= slwr_partial_n_d;   
faddr  <= "00";
sloe   <= '1';
pktend <= pktend_partial_n_d;
PMODE  <= "11";		
RESET  <= '1';	
slcs   <= '0';

process(current_partial_state)begin
	if((current_partial_state = partial_write))then
		slwr_partial_n <= '0';
	else
		slwr_partial_n <= '1';
	end if;
end process;	

process(clk_100, reset_n)begin
	if(reset_n = '0')then
		slwr_partial_n_d <= '1';
	elsif(clk_100'event and clk_100 = '1')then
		slwr_partial_n_d <= slwr_partial_n;
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

--counters for short pkt
process(clk_100, reset_n)begin
	if(reset_n = '0')then 
		short_pkt_cnt <= "0000";
	elsif(clk_100'event and clk_100 = '1')then	
		if(current_partial_state = partial_idle)then
			short_pkt_cnt <= "0000";
		elsif((current_partial_state = partial_write) or (current_partial_state = partial_write_wr_delay))then
			short_pkt_cnt <= short_pkt_cnt + 1;
		else 
		 	short_pkt_cnt <= short_pkt_cnt;
	        end if;	
        end if;
end process;	

--counter to generate the strob for PARTIAL and ZLP data pkts
process(clk_100, reset_n)begin
	if(reset_n = '0')then 
		strob_cnt <= "0000";
	elsif(clk_100'event and clk_100 = '1')then	
		if(current_partial_state = partial_idle)then
			strob_cnt<= "0000";
		elsif(current_partial_state = partial_wait)then
			strob_cnt <= strob_cnt + 1;
		else 
		 	strob_cnt <= strob_cnt;
	        end if;	
        end if;
end process;

--Strob logic
process(clk_100, reset_n)begin
	if(reset_n = '0')then
		strob <= '0';
	elsif(clk_100'event and clk_100 = '1')then	
		if((current_partial_state = partial_wait) and (strob_cnt = "0111"))then
			strob <= not strob;
		else
		        strob <= strob;
	        end if;
	end if;	
end process;

--OUTPUT packetend generation logic 
process(strob, short_pkt_cnt)begin
	if((strob = '1') and (short_pkt_cnt = "1111"))then
		pktend_partial_n <= '0';
	else
		pktend_partial_n <= '1';
	end if;
end process;	

process(clk_100, reset_n)begin
	if(reset_n = '0')then
		pktend_partial_n_d <= '1';
	elsif(clk_100'event and clk_100 = '1')then
		pktend_partial_n_d <= pktend_partial_n;
	end if;	 
end process;


--partial mode fsm
partial_mode_fsm_f : process(clk_100, reset_n) begin
	if(reset_n = '0')then
      		current_partial_state <= partial_idle;
        elsif(clk_100'event and clk_100 = '1')then
                current_partial_state <= next_partial_state;
        end if;
end process;

--PARTIAL mode state machine combo
partial_mode_fsm : process(current_partial_state, flaga_d, flagb_d, strob_cnt, strob, short_pkt_cnt)begin
	next_partial_state <= current_partial_state;
	case current_partial_state is
	when partial_idle =>
		if((flaga_d = '1'))then
			next_partial_state <= partial_wait_flagb; 
	  	else 
			next_partial_state <= partial_idle;
		end if;	
		
	when partial_wait_flagb =>
		if (flagb_d = '1')then
			next_partial_state <= partial_write; 
		else 
			next_partial_state <= partial_wait_flagb; 
		end if;

	when partial_write =>
		if((flagb_d = '0') or ((strob = '1') and (short_pkt_cnt = "1111")))then
			next_partial_state <= partial_write_wr_delay;
		else 
	 		next_partial_state <= partial_write;
		end if;	
	
	when partial_write_wr_delay =>
		next_partial_state <= partial_wait;
	
	when partial_wait =>
		if(strob_cnt = "1111")then
			next_partial_state <= partial_idle;
		else 
			next_partial_state <= partial_wait;
		end if;

	when others =>
		next_partial_state <= partial_idle;
	
	end case;
end process;




--data generator counter for Partial mode
process(clk_100, reset_n)begin
	if(reset_n = '0')then
		data_gen_partial <= (others => '0');
	elsif(clk_100'event and clk_100 = '1')then
		if((slwr_partial_n_d = '0'))then
			data_gen_partial <= data_gen_partial + '1';
	        end if;	
	end if;	
end process;

process(slwr_partial_n_d, data_gen_partial)begin
	if(slwr_partial_n_d = '0')then
		fdata <= data_gen_partial;
	else
		fdata <= (others => 'Z');	
	end if;
end process;

end architecture;
