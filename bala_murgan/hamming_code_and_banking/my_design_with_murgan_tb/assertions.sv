module assertions #(NO_BIT=4)(
  input                           i_clk,   // input clock signal
                                  i_rstn,  // input low_active reset signal
                                  i_start, // input start signal
  input          [NO_BIT-1:0]     i_dinA,  // input for adder A
                                  i_dinB,  // input for adder B
    
  input  logic   [NO_BIT:0]       sum);    // final output

  
    assert property (@(posedge i_clk)i_start&&i_rstn  |=>  (!i_start&&i_rstn[*2+NO_BIT])##1 ($past(i_dinA,1)+$past(i_dinB,1)==sum));
 

  
endmodule
    