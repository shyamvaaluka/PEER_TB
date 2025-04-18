
//top module which connect tb and design

import dual_package::*;      //import package which contain all the component

`include "interface.sv" //include the interface

module dual_tbb();
  
  test t;
  bit i_clka,i_clkb;
  
  always
  begin
    i_clka=0;
    #(CLK_FREQ[0]);                              //clock generation for port A
    i_clka=1;
    #(CLK_FREQ[0]);
  end

  always
  begin
    i_clkb=0;
    #(CLK_FREQ[1]);                                //clock generation for port B
    i_clkb=1;
    #(CLK_FREQ[1]);
  end
  
  inf in(i_clka,0);                     //instantiation of interface
  inf in1(i_clkb,1);
  MEMORY_TOP#(  .WR_LATENCYA(WRITE_LATENCY[0]),
                .RD_LATENCYA(READ_LATENCY[0]),
                .WR_LATENCYB(WRITE_LATENCY[1]),
                .RD_LATENCYB(READ_LATENCY[1]),
                .DATA_A(DATA_WIDTH),
                .MEM_DEPTH(ADDRESS_DEPTH))DUT (.clka(i_clka),.clkb(i_clkb),.i_data_in_a(in.i_din),.i_data_in_b(in1.i_din),.i_addra(in.i_addr),.i_addrb(in1.i_addr),.i_ena(in.i_en),.i_enb(in1.i_en),.i_wea(in.i_we),.i_web(in1.i_we),.o_dout_a(in.o_dout),.o_dout_b(in1.o_dout));
  initial
  begin
    t=new(in,in1);
    t.build_run(); 
    $finish;               //stop the simulation
  end

endmodule
