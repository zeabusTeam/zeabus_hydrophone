module biquad1
#(
   parameter coeffWidth = 1,
   parameter productWidth = 1,
   parameter sig1Width = 1 
)
(
   output wire       [sig1Width-1: 0]  IIRoutput_o ,
   input                                IIRclk_i ,
   input wire                           modeReset_i ,
   input wire  signed [sig1Width-1: 0]  IIRinput_i  ,
   input wire  signed [coeffWidth-1: 0] b0_i ,
   input wire  signed [coeffWidth-1: 0] b1_i ,
   input wire  signed [coeffWidth-1: 0] b2_i ,
   input wire  signed [coeffWidth-1: 0] NEGa1_i ,
   input wire  signed [coeffWidth-1: 0] NEGa2_i       
);


reg  signed [sig1Width-1: 0] s1 ;
reg  signed [sig1Width-1: 0] s2 ;

wire signed [sig1Width-1: 0] vk ;
reg  signed [sig1Width-1: 0] vkReg ;
reg  signed [sig1Width-1: 0] xk ;
reg  signed [sig1Width-1: 0] v1 ;
reg  signed [sig1Width-1: 0] v2 ;
reg  signed [sig1Width-1: 0] ykReg ;

wire signed [productWidth-1: 0] productB0;
wire signed [productWidth-1: 0] productB1 ;
wire signed [productWidth-1: 0] productB2 ;
wire signed [productWidth-1: 0] productA1;
wire signed [productWidth-1: 0] productA2 ;

assign vk = IIRinput_i+s1 ;
assign productA2 = NEGa2_i*vk ;
assign productA1 = NEGa1_i*vk ;
assign productB0 = b0_i*vkReg ;
assign productB1 = b1_i*vkReg ;
assign productB2 = b2_i*vkReg ;

wire sampleStrobe ;
assign sampleStrobe  = 1 ;
assign  IIRoutput_o = ykReg ;

always @(posedge  IIRclk_i ) begin
  if ( sampleStrobe ) begin
    xk <= IIRinput_i  ;
    if ( modeReset_i ) begin
      s1<=25'h0 ;
      s2<=25'h0 ;
      v1<=25'h0 ;
      v2<=25'h0 ;
      vkReg <= 0 ;
      ykReg <= 0 ;      
      end
     else begin   
      s1<=s2+  productA1[25-1+16:0+16] ;
      s2<=     productA2[25-1+16:0+16] ;
      v1<=v2 + productB1[25-1+16:0+16]  ;
      v2<=     productB2[25-1+16:0+16] ;
      vkReg <= vk ;
      ykReg <= v1 + productB0[25-1+16:0+16] ;
      end
    end
  end