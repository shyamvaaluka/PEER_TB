
// it is a mux design 
// we use this mux for multi bank memory to deliver a data of a respective memory



module mux_out#(parameter LATENCY=2)(
  input i_clk,input [11:0]i_in1,i_in2,i_in3,i_in4, // input from the different memory module
  input[1:0]i_sel,  //last 2 bit of address which going to select the correct output
  output reg[11:0]o_out  //output for the top module[multi bank]
  );
  reg [1:0]addr; // internal address suppose the module have LATENCY means we use this to add LATENCY to address
  
  always@(i_in1 or i_in2 or i_in3 or i_in4 or addr ) //sensitivity list 
  begin
    case(addr)
      2'b00:o_out=i_in1;
      2'b01:o_out=i_in2;            //use case to select the output
      2'b10:o_out=i_in3;
      2'b11:o_out=i_in4;
      default:o_out=0;
    endcase
  end
  generate
    latencys #(LATENCY,2)A1(i_clk,i_sel,addr);  // this module is used to add LATENCY in address
   
  endgenerate
endmodule

module latencys #(parameter LATENCY=1,WIDTH=2)(input i_clk,[WIDTH-1:0]i_in,output reg[WIDTH-1:0]o_out); //it is a shift register which help to add LATENCY
  
  reg [WIDTH-1:0]inter[LATENCY:0];   // internal register
  always@(posedge i_clk)
  begin
    inter[0]<=i_in;
    for(int i=0;i<=LATENCY;i++)
    begin
      inter[i+1]<=inter[i];          //  use for loop to run a shift register depends on LATENCY
    end
  end
  assign o_out=inter[LATENCY-1];      // output assigned
 
endmodule
    
