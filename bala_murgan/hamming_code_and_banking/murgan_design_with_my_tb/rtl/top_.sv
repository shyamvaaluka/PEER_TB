/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//   Design of top module which doing hamming encoding,decoding,in dual port multi bank memory module
//
//   Description : its a design module of a sub system which contain
//                      *hamming encoding
// 			*hamming decoding
// 			*demux
//   			*dual port ram [multi bank memory module
//			*mux
//
//      -------- Parameters declared in the Test bench -------------
//
//
//      DATA_WIDTH                       =     Indicates the Data width of the one memory location 
//      ADDRESS_DEPTH		         =     Number of locations present in the memory
//      A_R_LATENCY            		 =     Port - A    read latency
//      A_W_LATENCY              	 =     Port - A    write latency
//      B_R_LATENCY                      =     Port - B    read latency
//      B_W_LATENCY                      =     Port - B    write latency 

//     



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/


module top_module #(parameter A_W_LATENCY=2,A_R_LATENCY=2,B_W_LATENCY=2,B_R_LATENCY=2,DATA_WIDTH=8,ADDRESS_DEPTH=32) (i_clka,i_clkb,i_dina,i_dinb,i_addra,i_addrb,i_ena,i_enb,i_wea,i_web,o_douta,o_doutb);

  input				     	i_clka, //clk for A process
					i_clkb, //clk for B process		
					i_ena,	//enable for A process
					i_enb,	//enable for B process
					i_wea, 	//write enable for A Process
					i_web;
                                        
  input   [DATA_WIDTH-1:0]		i_dina;	//data_in for A process
  input   [DATA_WIDTH-1:0]		i_dinb; //data_in for B process
  input	  [$clog2(ADDRESS_DEPTH)-1:0]	i_addra;//address for A process
  input	  [$clog2(ADDRESS_DEPTH)-1:0]	i_addrb;//address for B process
  output  [DATA_WIDTH-1:0]		o_douta;//data out for A process
  output  [DATA_WIDTH-1:0]		o_doutb;//data out for B process
	
  reg     [11:0]                        ha_dina,ha_dinb;   //to collect the encoded data
  
  reg     [11:0]                        ha_douta,ha_doutb;	//to collect the decoded data

  reg [11:0] ha_dina_e,ha_dinb_e;
 
  reg [2:0]l,m;
  
  reg [11:0] tempa,tempb;
 
  hamming_en_decode                                			        ENCODE_DECODE  (i_dina,i_dinb,ha_dina,ha_dinb,ha_douta,ha_doutb,o_douta,o_doutb);  //instantiation of design to HAMMING ENCODE AND DECODE
	
   
  multibank_controller #(A_W_LATENCY,A_R_LATENCY,B_W_LATENCY,B_R_LATENCY,12,32) MULTI_MEMORY  (i_clka,i_clkb,ha_dina_e,ha_dinb_e,i_addra,i_addrb,i_ena,i_enb,i_wea,i_web,ha_douta,ha_doutb);  //dual port ram 4
  
  always@(ha_dina or ha_dinb)                   //this module help to inject an error
  begin
    //if($test$plusargs("error"))
    if(1)
    begin                                       //error injection
      l=$urandom;
      m=$urandom;
      tempa=ha_dina;
      tempb=ha_dinb;
      tempa[l]=~tempa[l];                        // when we want to inject error in toggle the output from encoder and store in temp
      tempb[m]=~tempb[m];
    end
    else
    begin
      tempa=ha_dina;                                     // otherwise we pass the correct output
      tempb=ha_dinb;
    end
  end
  
  assign  ha_dina_e=tempa;
  assign  ha_dinb_e=tempb;
  
	
endmodule
