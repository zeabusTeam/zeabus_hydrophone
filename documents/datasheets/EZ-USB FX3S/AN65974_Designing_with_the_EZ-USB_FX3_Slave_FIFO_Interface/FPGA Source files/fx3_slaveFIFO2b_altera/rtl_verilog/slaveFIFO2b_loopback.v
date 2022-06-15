module slaveFIFO2b_loopback(
	input  reset_in_,            //input reset active low
	input  clk,                  //input clp 50 Mhz
	inout  [31:0]fdata,          //data bus
	output [1:0]faddr,           //output fifo address  
	output slrd,                 //output read select
	output slwr,                 //output write select
	input  flaga,                //full flag
	input  flagb,                //partial full flag
      	input  flagc,                //empty flag
	input  flagd,                //empty partial flag
	output sloe,                 //output output enable select
	output clk_out,              //output clk 100 Mhz and 180 phase shift
	output slcs,                 //output chip select
	output pktend,               //output pkt end
	output [1:0]PMODE,
	output RESET,
	output PMODE_2               //used for debugging
); 


reg [1:0] oe_delay_cnt;	
reg rd_oe_delay_cnt; 
wire [31:0] fifo_data_in;

wire [31:0] data_out;
reg  [31:0] fdata_d;

reg slrd_loopback_d1_;
reg slrd_loopback_d2_;
reg slrd_loopback_d3_;
reg slrd_loopback_d4_;
reg [1:0]fifo_address;
reg [1:0]fifo_address_d;
reg flaga_d;
reg flagb_d;
reg flagc_d;
reg flagd_d;
wire [31:0] data_out_loopback;

reg [3:0]current_loop_back_state;
reg [3:0]next_loop_back_state;
reg slwr_loopback_1d_;

//parameters for LoopBack mode state machine
parameter [3:0] loop_back_idle                    = 4'd0;
parameter [3:0] loop_back_flagc_rcvd              = 4'd1;
parameter [3:0] loop_back_wait_flagd              = 4'd2;
parameter [3:0] loop_back_read                    = 4'd3;
parameter [3:0] loop_back_read_rd_and_oe_delay    = 4'd4;
parameter [3:0] loop_back_read_oe_delay           = 4'd5;
parameter [3:0] loop_back_wait_flaga              = 4'd6;
parameter [3:0] loop_back_wait_flagb              = 4'd7;
parameter [3:0] loop_back_write                   = 4'd8;
parameter [3:0] loop_back_write_wr_delay          = 4'd9;
parameter [3:0] loop_back_flush_fifo              = 4'd10;

//output signal assignment
assign slrd   = slrd_loopback_;
assign slwr   = slwr_loopback_1d_;   
assign faddr  = fifo_address_d;
assign sloe   = sloe_loopback_;
assign PMODE  = 2'b11;		
assign RESET  = 1'b1;	
assign slcs   = 1'b0;
assign pktend = 1'b1;


//assign clk_100 = clk;        //for TB

//clock generation(pll instantiation)
pll inst_clk_pll
	(
		.areset(/*reset2pll*/1'b0),
		.inclk0(clk),  
		.c0(clk_100),
		.locked(lock)
	);


//ddr is used to send out the clk(DDR instantiation)

ddr inst_ddr_to_send_clk_to_fx3                       
        ( 
	.datain_h(1'b0),
	.datain_l(1'b1),
	.outclock(clk_100),
	.dataout(clk_out) 
	); 


assign reset_ = lock;

///flopping the INPUTs flags
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		flaga_d <= 1'd0;
		flagb_d <= 1'd0;
		flagc_d <= 1'd0;
		flagd_d <= 1'd0;
	end else begin
		flaga_d <= flaga;
		flagb_d <= flagb;
		flagc_d <= flagc;
		flagd_d <= flagd;
	end	
end

// output control signal generation
assign slrd_loopback_      = ((current_loop_back_state == loop_back_read) | (current_loop_back_state == loop_back_read_rd_and_oe_delay)) ? 1'b0 : 1'b1;
assign sloe_loopback_      = ((current_loop_back_state == loop_back_read) | (current_loop_back_state == loop_back_read_rd_and_oe_delay) | (current_loop_back_state == loop_back_read_oe_delay)) ? 1'b0 : 1'b1; 
assign slwr_loopback_      = ((current_loop_back_state == loop_back_write)) ? 1'b0 : 1'b1;

always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		slwr_loopback_1d_ <= 1'b1;
	end else begin
		slwr_loopback_1d_ <=  slwr_loopback_;
	end	
end


//delay for reading from slave fifo(data will be available after two clk cycle) 
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		slrd_loopback_d1_ <= 1'b1;
		slrd_loopback_d2_ <= 1'b1;  
		slrd_loopback_d3_ <= 1'b1;
		slrd_loopback_d4_ <= 1'b1;
 	end else begin
 		slrd_loopback_d1_ <= slrd_loopback_;
		slrd_loopback_d2_ <= slrd_loopback_d1_; 
		slrd_loopback_d3_ <= slrd_loopback_d2_;
		slrd_loopback_d4_ <= slrd_loopback_d3_;
	end	
end

//flopping the input data
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		fdata_d <= 32'd0;
 	end else begin
		fdata_d <= fdata;
	end	
end


//Control signal of internal fifo for LoopBack mode 
assign fifo_push  = (slrd_loopback_d3_ == 1'b0);
assign fifo_pop   = (current_loop_back_state == loop_back_write);
assign fifo_flush = (current_loop_back_state == loop_back_flush_fifo); 

assign fifo_data_in = (slrd_loopback_d3_ == 1'b0) ? fdata_d : 32'd0;

///slave fifo address
always@(*)begin
	if((current_loop_back_state == loop_back_flagc_rcvd) | (current_loop_back_state == loop_back_wait_flagd) | (current_loop_back_state == loop_back_read) | (current_loop_back_state == loop_back_read_rd_and_oe_delay) | (current_loop_back_state == loop_back_read_oe_delay))begin
		fifo_address = 2'b11;
	end else 
		fifo_address = 2'b00;
end	

//flopping the output fifo address
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		fifo_address_d <= 2'd0;
 	end else begin
		fifo_address_d <= fifo_address;
	end	
end



//counter to delay the read and output enable signal
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		rd_oe_delay_cnt <= 1'b0;
	end else if(current_loop_back_state == loop_back_read) begin
		rd_oe_delay_cnt <= 1'b1;
        end else if((current_loop_back_state == loop_back_read_rd_and_oe_delay) & (rd_oe_delay_cnt > 1'b0))begin
		rd_oe_delay_cnt <= rd_oe_delay_cnt - 1'b1;
	end else begin
		rd_oe_delay_cnt <= rd_oe_delay_cnt;
	end	
end

//Counter to delay the OUTPUT Enable(oe) signal
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		oe_delay_cnt <= 2'd0;
	end else if(current_loop_back_state == loop_back_read_rd_and_oe_delay) begin
		oe_delay_cnt <= 2'd2;
        end else if((current_loop_back_state == loop_back_read_oe_delay) & (oe_delay_cnt > 1'b0))begin
		oe_delay_cnt <= oe_delay_cnt - 1'b1;
	end else begin
		oe_delay_cnt <= oe_delay_cnt;
	end	
end


//LoopBack state machine
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		current_loop_back_state <= loop_back_idle;
	end else begin
		current_loop_back_state <= next_loop_back_state;
	end	
end

//LoopBack mode state machine combo
always @(*)begin
	next_loop_back_state = current_loop_back_state;
	case(current_loop_back_state)
	loop_back_idle:begin
	        if(flagc_d == 1'b1)begin
			next_loop_back_state = loop_back_flagc_rcvd;
		end else begin
			next_loop_back_state = loop_back_idle;
		end
	end	
        loop_back_flagc_rcvd:begin
		next_loop_back_state = loop_back_wait_flagd;
	end	
	loop_back_wait_flagd:begin
		if(flagd_d == 1'b1)begin
			next_loop_back_state = loop_back_read;
		end else begin
			next_loop_back_state = loop_back_wait_flagd;
		end
	end	
        loop_back_read :begin
                if(flagd_d == 1'b0)begin
			next_loop_back_state = loop_back_read_rd_and_oe_delay;
		end else begin
			next_loop_back_state = loop_back_read;
		end
	end
	loop_back_read_rd_and_oe_delay : begin
		if(rd_oe_delay_cnt == 0)begin
			next_loop_back_state = loop_back_read_oe_delay;
		end else begin
			next_loop_back_state = loop_back_read_rd_and_oe_delay;
		end
	end
        loop_back_read_oe_delay : begin
		if(oe_delay_cnt == 0)begin
			next_loop_back_state = loop_back_wait_flaga;
		end else begin
			next_loop_back_state = loop_back_read_oe_delay;
		end
	end
	loop_back_wait_flaga :begin
		if (flaga_d == 1'b1)begin
			next_loop_back_state = loop_back_wait_flagb; 
		end else begin
			next_loop_back_state = loop_back_wait_flaga; 
		end
	end
	loop_back_wait_flagb :begin
		if (flagb_d == 1'b1)begin
			next_loop_back_state = loop_back_write; 
		end else begin
			next_loop_back_state = loop_back_wait_flagb; 
		end
	end
	loop_back_write:begin
		if(flagb_d == 1'b0)begin
			next_loop_back_state = loop_back_write_wr_delay;
		end else begin
		 	next_loop_back_state = loop_back_write;
		end
	end
        loop_back_write_wr_delay:begin
			next_loop_back_state = loop_back_flush_fifo;
	end
	loop_back_flush_fifo:begin
		next_loop_back_state = loop_back_idle;
	end
	endcase
end




///fifo instantiation for loop back mode
fifo fifo_inst(
	.din(fifo_data_in)
        ,.write_busy(fifo_push)
	,.fifo_full()
	,.dout(data_out_loopback)
	,.read_busy(fifo_pop)
	,.fifo_empty()
	,.fifo_clk(clk_100)
	,.reset_(reset_)
	,.fifo_flush(fifo_flush)
);

reg [31:0]data_out_loopback_d;
always@(posedge clk_100)begin
	data_out_loopback_d <= data_out_loopback;
end	

assign fdata = (slwr_loopback_1d_) ? 32'dz : data_out_loopback_d;


endmodule
