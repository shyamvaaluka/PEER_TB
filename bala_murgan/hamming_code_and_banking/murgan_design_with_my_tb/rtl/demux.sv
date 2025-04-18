
// its  a demux here  use it to control the enable signal in memory module in multi bank memory
module demux (
  input  i_in, // enable from user
  input [1:0] i_sel, //selection port 
  output reg o_out1,o_out2,o_out3,o_out4  //output ports
  );
  always@(*)
  begin
    case(i_sel)
      2'b00:begin o_out1=i_in; o_out2=1'b0; o_out3=1'b0; o_out4=1'b0;end
      2'b01:begin o_out2=i_in; o_out1=1'b0; o_out3=1'b0; o_out4=1'b0;end
      2'b10:begin o_out3=i_in; o_out2=1'b0; o_out1=1'b0; o_out4=1'b0;end  //use case to select the respective memory module to enable
      2'b11:begin o_out4=i_in; o_out2=1'b0; o_out3=1'b0; o_out1=1'b0;end
      default:o_out4=0;
    endcase
  end
endmodule
