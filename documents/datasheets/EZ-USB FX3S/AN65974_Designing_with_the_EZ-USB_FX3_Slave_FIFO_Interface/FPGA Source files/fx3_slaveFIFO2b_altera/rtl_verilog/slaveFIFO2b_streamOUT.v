module slaveFIFO2b_streamOUT(
	input  reset_in_,            //input reset active low
	input  clk,                  //input clp 50 Mhz
	input  [31:0]fdata,          //data bus
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


reg [2:0]current_stream_out_state;
reg [2:0]next_stream_out_state;

//parameters for StreamOUT mode state machine
parameter [2:0] stream_out_idle                   = 3'd0;
parameter [2:0] stream_out_flagc_rcvd             = 3'd1;
parameter [2:0] stream_out_wait_flagd             = 3'd2;
parameter [2:0] stream_out_read                   = 3'd3;
parameter [2:0] stream_out_read_rd_and_oe_delay   = 3'd4;
parameter [2:0] stream_out_read_oe_delay          = 3'd5;

reg [1:0] oe_delay_cnt;	
reg rd_oe_delay_cnt; 
reg  flaga_d;
reg  flagb_d;
reg  flagc_d;
reg  flagd_d;

wire slrd_streamOUT_;
wire sloe_streamOUT_;

wire [31:0]data_in_stream_out;

//output signal assignment 
assign slrd   = slrd_streamOUT_;
assign slwr   = 1'b1;   
assign faddr  = 2'b11;
assign sloe   = slrd_streamOUT_;
assign data_in_stream_out = fdata;	
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

//control ouput signals
assign slrd_streamOUT_ = ((current_stream_out_state == stream_out_read) | (current_stream_out_state == stream_out_read_rd_and_oe_delay)) ? 1'b0 : 1'b1;
assign sloe_streamOUT_ = ((current_stream_out_state == stream_out_read) | (current_stream_out_state == stream_out_read_rd_and_oe_delay) | (current_stream_out_state == stream_out_read_oe_delay)) ? 1'b0 : 1'b1;

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


//counter to delay the read and output enable signal
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		rd_oe_delay_cnt <= 1'b0;
	end else if(current_stream_out_state == stream_out_read) begin
		rd_oe_delay_cnt <= 1'b1;
        end else if((current_stream_out_state == stream_out_read_rd_and_oe_delay) & (rd_oe_delay_cnt > 1'b0))begin
		rd_oe_delay_cnt <= rd_oe_delay_cnt - 1'b1;
	end else begin
		rd_oe_delay_cnt <= rd_oe_delay_cnt;
	end	
end

//Counter to delay the OUTPUT Enable(oe) signal
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		oe_delay_cnt <= 2'd0;
	end else if(current_stream_out_state == stream_out_read_rd_and_oe_delay) begin
		oe_delay_cnt <= 2'd2;
        end else if((current_stream_out_state == stream_out_read_oe_delay) & (oe_delay_cnt > 1'b0))begin
		oe_delay_cnt <= oe_delay_cnt - 1'b1;
	end else begin
		oe_delay_cnt <= oe_delay_cnt;
	end	
end

//streamOUT mode state machine
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		current_stream_out_state <= stream_out_idle;
	end else begin
		current_stream_out_state <= next_stream_out_state;
	end	
end

//steamOUT mode state machine combo
always @(*)begin
	next_stream_out_state = current_stream_out_state;
	case(current_stream_out_state)
	stream_out_idle:begin
		if(flagc_d == 1'b1)begin
			next_stream_out_state = stream_out_flagc_rcvd;
		end else begin
			next_stream_out_state = stream_out_idle;
		end
	end	
        stream_out_flagc_rcvd:begin
		next_stream_out_state = stream_out_wait_flagd;
	end	
	stream_out_wait_flagd:begin
		if(flagd_d == 1'b1)begin
			next_stream_out_state = stream_out_read;
		end else begin
			next_stream_out_state = stream_out_wait_flagd;
		end
	end	
        stream_out_read :begin
                if(flagd_d == 1'b0)begin
			next_stream_out_state = stream_out_read_rd_and_oe_delay;
		end else begin
			next_stream_out_state = stream_out_read;
		end
	end
	stream_out_read_rd_and_oe_delay : begin
		if(rd_oe_delay_cnt == 0)begin
			next_stream_out_state = stream_out_read_oe_delay;
		end else begin
			next_stream_out_state = stream_out_read_rd_and_oe_delay;
		end
	end
        stream_out_read_oe_delay : begin
		if(oe_delay_cnt == 0)begin
			next_stream_out_state = stream_out_idle;
		end else begin
			next_stream_out_state = stream_out_read_oe_delay;
		end
	end
	endcase
end

endmodule
