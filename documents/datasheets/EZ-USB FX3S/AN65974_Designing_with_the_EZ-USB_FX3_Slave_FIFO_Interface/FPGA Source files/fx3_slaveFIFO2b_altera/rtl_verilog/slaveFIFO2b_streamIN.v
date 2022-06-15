module slaveFIFO2b_streamIN(
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
	output RESET
//	output PMODE_2               //used for debugging
);


reg [2:0]current_stream_in_state;
reg [2:0]next_stream_in_state;
reg [31:0]data_gen_stream_in;

//parameters for StreamIN mode state machine
parameter [2:0] stream_in_idle                    = 3'd0;
parameter [2:0] stream_in_wait_flagb              = 3'd1;
parameter [2:0] stream_in_write                   = 3'd2;
parameter [2:0] stream_in_write_wr_delay          = 3'd3;


reg  flaga_d;
reg  flagb_d;
reg  flagc_d;
reg  flagd_d;


//output signal assignment 
assign slrd   = 1'b1;
assign slwr   = slwr_streamIN_d1_;   
assign faddr  = 2'd0;
assign sloe   = 1'b1;
assign fdata  = (slwr_streamIN_d1_) ? 32'dz : data_gen_stream_in;	
assign PMODE  = 2'b11;		
assign RESET  = 1'b1;	
assign slcs   = 1'b0;
assign pktend = 1'b1;

wire clk_100;
wire lock;
wire reset_;

//clock generation(pll instantiation)
pll inst_clk_pll
	(
		.areset(1'b0/*reset2pll*/),
		.inclk0(clk),  
		.c0(clk_100),
		.locked(lock)
	);


//ddr is used to send out the clk(ODDR2 instantiation)
//
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

assign slwr_streamIN_ = ((current_stream_in_state == stream_in_write)) ? 1'b0 : 1'b1;

reg slwr_streamIN_d1_;
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		slwr_streamIN_d1_ <= 1'b1;
	end else begin
		slwr_streamIN_d1_ <= slwr_streamIN_;
	end	
end


//streamIN mode state machine
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		current_stream_in_state <= stream_in_idle;
	end else begin
		current_stream_in_state <= next_stream_in_state;
	end	
end

//StreamIN mode state machine combo
always @(*)begin
	next_stream_in_state = current_stream_in_state;
	case(current_stream_in_state)
	stream_in_idle:begin
		if(flaga_d == 1'b1)begin
			next_stream_in_state = stream_in_wait_flagb; 
		end else begin
			next_stream_in_state = stream_in_idle;
		end	
	end
	stream_in_wait_flagb :begin
		if (flagb_d == 1'b1)begin
			next_stream_in_state = stream_in_write; 
		end else begin
			next_stream_in_state = stream_in_wait_flagb; 
		end
	end
	stream_in_write:begin
		if(flagb_d == 1'b0)begin
			next_stream_in_state = stream_in_write_wr_delay;
		end else begin
		 	next_stream_in_state = stream_in_write;
		end
	end
        stream_in_write_wr_delay:begin
			next_stream_in_state = stream_in_idle;
	end
	endcase
end

//data generator counter for StreamIN modes
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		data_gen_stream_in <= 32'd0;
	end else if(slwr_streamIN_d1_ == 1'b0) begin
		data_gen_stream_in <= data_gen_stream_in + 1;
	end 
end


endmodule
