
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
  top_module #(WRITE_LATENCY[0],READ_LATENCY[0],WRITE_LATENCY[1],READ_LATENCY[1],DATA_WIDTH,ADDRESS_DEPTH)DUT (.i_clka(i_clka),.i_clkb(i_clkb),.i_dina(in.i_din),.i_dinb(in1.i_din),.i_addra(in.i_addr),.i_addrb(in1.i_addr),.i_ena(in.i_en),.i_enb(in1.i_en),.i_wea(in.i_we),.i_web(in1.i_we),.o_douta(in.o_dout),.o_doutb(in1.o_dout));



  
  initial
  begin
    t=new(in,in1);
    t.build_run(); 
    $finish;               //stop the simulation
  end

endmodule
