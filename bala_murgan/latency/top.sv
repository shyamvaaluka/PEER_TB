import pkg_2::*;

`include "./rtl/dual_ram.sv"
`include "interface.sv"

import pkg::*;

module top;	
	bit clka,clkb;
	always #5 clka=~clka;
	always #10 clkb=~clkb;	

  	

	dual_port_ram#( .DATA_WIDTH(DATA_WIDTH),
                  .ADDRESS_DEPTH(MEM_DEPTH),
                  .A_W_LATENCY(WR_LATENCYA),
                  .B_W_LATENCY(WR_LATENCYB),
                  .A_R_LATENCY(RD_LATENCYA),
                  .B_R_LATENCY(RD_LATENCYB)
                )DUT(  .i_clka(in0.clka),
			 						    .i_clkb(in0.clkb),
									    .i_ena(in0.i_ena),
									    .i_enb(in0.i_enb),
									    .i_wea(in0.i_wea),
									    .i_web(in0.i_web),
									    .i_dina(in0.i_dina),
									    .i_dinb(in0.i_dinb),
									    .i_addra(in0.i_addra),
									    .i_addrb(in0.i_addrb),
									    .o_douta(in0.o_douta),
									    .o_doutb(in0.o_doutb));

  dual_iff in0(.clka(clka),
        			 .clkb(clkb));


 dual_test test_h;

 initial

  begin
    test_h=new(in0,in0,in0,in0);
    test_h.run();
  end
   

  

		//initial #5000 $finish;
endmodule
