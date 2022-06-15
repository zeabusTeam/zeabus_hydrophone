module slaveFIFO2b_ZLP(
	input  reset_in_,            //input reset active low
	input  clk,                  //input clp 50 Mhz
	inout  [31:0]fdata,                //data bus
	output [1:0]faddr,                //output fifo address  
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
reg [2:0]current_zlp_state;
reg [2:0]next_zlp_state;

//parameters for ZLP mode state machine
parameter [2:0] zlp_idle                          = 3'd0;
parameter [2:0] zlp_wait_flagb              	  = 3'd1;
parameter [2:0] zlp_write                   	  = 3'd2;
parameter [2:0] zlp_write_wr_delay          	  = 3'd3;
parameter [2:0] zlp_wait		          = 3'd4;

reg  [3:0]strob_cnt;
reg  strob;
reg  [31:0]data_gen_zlp;
reg  pktend_zlp_;  
reg  flaga_d;
reg  flagb_d;
reg  flagc_d;
reg  flagd_d;
wire slwr_zlp_;

//output signal assignment 
assign slrd   = 1'b1;
assign slwr   = slwr_zlp_d1_;   
assign faddr  = 2'd0;
assign sloe   = 1'b1;
assign fdata  = (slwr_zlp_d1_) ? 32'dz : data_gen_zlp;
assign PMODE  = 2'b11;		
assign RESET  = 1'b1;	
assign slcs   = 1'b0;
assign pktend = pktend_zlp_d1_;

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
ddr inst_ddr_to_send_clk_out                       
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


assign slwr_zlp_ = ((current_zlp_state == zlp_write)) ? 1'b0 : 1'b1;


reg slwr_zlp_d1_;

always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		slwr_zlp_d1_ <= 1'd1;
	end else begin
		slwr_zlp_d1_ <= slwr_zlp_;
	end	
end


//counter to generate the strob for ZLP data pkts
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		strob_cnt <= 4'd0;
	end else if(current_zlp_state == zlp_idle)begin
		strob_cnt <= 4'd0;
	end else if(current_zlp_state == zlp_wait)begin
		strob_cnt <= strob_cnt + 1'b1;
	end	
end

//Strob logic
always@(posedge clk_100, negedge reset_)begin
	if(!reset_)begin
		strob <= 1'b0;
	end else if((current_zlp_state == zlp_wait) && (strob_cnt == 4'b0111)) begin
		strob <= !strob;
	end
end

always@(*)begin
	if((strob_cnt == 4'b0011) && (strob == 1'b1))begin
		pktend_zlp_ = 1'b0;
	end else begin
		pktend_zlp_ = 1'b1;
	end
end

reg pktend_zlp_d1_;

always@(posedge clk_100, negedge reset_)begin
	if(!reset_)begin
		pktend_zlp_d1_ <= 1'b1;
	end else begin
		pktend_zlp_d1_ <= pktend_zlp_;
	end
end

//ZLP mode state machine
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		current_zlp_state <= zlp_idle;
	end else begin
		current_zlp_state <= next_zlp_state;
	end	
end

//ZLP mode state machine combo
always@(*)begin
	next_zlp_state = current_zlp_state;
	case(current_zlp_state)
	zlp_idle:begin
		if(flaga_d == 1'b1)begin
			next_zlp_state = zlp_wait_flagb; 
		end else begin
			next_zlp_state = zlp_idle;
		end	
	end
	zlp_wait_flagb :begin
		if((strob == 1'b1) && (flagb_d == 1'b1))begin
			next_zlp_state = zlp_wait;
		end else if ((strob == 1'b0) && (flagb_d == 1'b1))begin
			next_zlp_state = zlp_write; 
		end else begin
			next_zlp_state = zlp_wait_flagb; 
		end
	end
	zlp_write:begin
		if(flagb_d == 1'b0)begin
			next_zlp_state = zlp_write_wr_delay;
		end else begin
		 	next_zlp_state = zlp_write;
		end
	end
        zlp_write_wr_delay:begin
		next_zlp_state = zlp_wait;
	end
	zlp_wait:begin
		if(strob_cnt == 4'b1111)begin
			next_zlp_state = zlp_idle;
		end else begin
			next_zlp_state = zlp_wait;
		end
	end	
	endcase
end

//data generator counter for zlp mode
always @(posedge clk_100, negedge reset_)begin
	if(!reset_)begin 
		data_gen_zlp <= 32'd0;
	end else if(slwr_zlp_d1_ == 1'b0)begin
		data_gen_zlp <= data_gen_zlp + 1;
	end 
end

endmodule
