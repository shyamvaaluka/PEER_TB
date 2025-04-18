//
//in this module we have hamming encoding and decoding
//hammig encoding
//hamming decoding
//
module hamming_en_decode  (i_dina,i_dinb,o_douta,o_doutb,d_dina,d_dinb,d_outa,d_outb);
			     	
  input   [7:0]		   i_dina; //data_in for A process for encoding
  input   [7:0]		   i_dinb; //data_in for B process for encoding
  
  output  [11:0]           o_douta;//data out for A process after encoding
  output  [11:0]	   o_doutb;//data out for B process after encoding

  input   [11:0]	   d_dina;//data out for A process  for decoding
  input   [11:0]	   d_dinb;//data out for B process  for decoding

  output  [7:0]		   d_outa; //data_in for A process  after decoding
  output  [7:0]		   d_outb; //data_in for B process  after decoding

  
 
  hamming                  ENCODER1  (i_dina,o_douta);  //instantiation of design to encode data for port1
	
  hamming                  ENCODER2  (i_dinb,o_doutb);   //instantiation of design to encode data for port2

  hamming_decod            DECODER1  (d_dina,d_outa);    //instantiation of design to decode data for port1

  hamming_decod            DECODER2  (d_dinb,d_outb);    //instantiation of design to decode data for port2

endmodule