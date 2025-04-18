//
// this a multi bank memory module in which we have
// 4    8*12 memory
// 2    demux
// 2    mux
//
//
module multibank_controller #(parameter A_W_LATENCY=3,A_R_LATENCY=3,B_W_LATENCY=3,B_R_LATENCY=3,DATA_WIDTH=8,ADDRESS_DEPTH=8) (i_clka,i_clkb,i_dina,i_dinb,i_addra,i_addrb,i_ena,i_enb,i_wea,i_web,o_douta,o_doutb);

  input				     	i_clka, //clk for A process
					i_clkb, //clk for B process		
					i_ena,	//enable for A process
					i_enb,	//enable for B process
					i_wea, 	//write enable for A Process
					i_web;	//write enable for B process
  input   [DATA_WIDTH-1:0]		i_dina;	//data_in for A process
  input   [DATA_WIDTH-1:0]		i_dinb; //data_in for B process
  input	  [$clog2(ADDRESS_DEPTH)-1:0]	i_addra;//address for A process
  input	  [$clog2(ADDRESS_DEPTH)-1:0]	i_addrb;//address for B process
  
  output  [DATA_WIDTH-1:0]		o_douta,o_doutb;//outputs
  reg     [DATA_WIDTH-1:0]		o_douta1,o_douta2,o_douta3,o_douta4;//data out for A process
  reg     [DATA_WIDTH-1:0]		o_doutb1,o_doutb2,o_doutb3,o_doutb4;//data out for B process
	
 

  dual_port_ram #(A_W_LATENCY,A_R_LATENCY,B_W_LATENCY,B_R_LATENCY,12,8) mem1  (i_clka,i_clkb,i_dina,i_dinb,i_addra[2:0],i_addrb[2:0],de_ena1,de_enb1,i_wea,i_web,o_douta1,o_doutb1);  //dual port ram 1

  dual_port_ram #(A_W_LATENCY,A_R_LATENCY,B_W_LATENCY,B_R_LATENCY,12,8) mem2  (i_clka,i_clkb,i_dina,i_dinb,i_addra[2:0],i_addrb[2:0],de_ena2,de_enb2,i_wea,i_web,o_douta2,o_doutb2);  //dual port ram 2

  dual_port_ram #(A_W_LATENCY,A_R_LATENCY,B_W_LATENCY,B_R_LATENCY,12,8) mem3  (i_clka,i_clkb,i_dina,i_dinb,i_addra[2:0],i_addrb[2:0],de_ena3,de_enb3,i_wea,i_web,o_douta3,o_doutb3);  //dual port ram 3

  dual_port_ram #(A_W_LATENCY,A_R_LATENCY,B_W_LATENCY,B_R_LATENCY,12,8) mem4  (i_clka,i_clkb,i_dina,i_dinb,i_addra[2:0],i_addrb[2:0],de_ena4,de_enb4,i_wea,i_web,o_douta4,o_doutb4);  //dual port ram 4

  demux  				    				DEMUX_C1  (i_ena,i_addra[4:3],de_ena1,de_ena2,de_ena3,de_ena4);   //demux for control the memory for a port

  demux  				    				DEMUX_C2  (i_enb,i_addrb[4:3],de_enb1,de_enb2,de_enb3,de_enb4);	 //demux for control the memory for b port

  mux_out       #(A_R_LATENCY)                     			MUX1  (i_clka,o_douta1,o_douta2,o_douta3,o_douta4,i_addra[4:3],o_douta);  // which select the correct output
 
  mux_out       #(B_R_LATENCY)                     			MUX2 (i_clkb,o_doutb1,o_doutb2,o_doutb3,o_doutb4,i_addrb[4:3],o_doutb);  // which select the correct output

endmodule
