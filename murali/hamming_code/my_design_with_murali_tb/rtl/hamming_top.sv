/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name         : hamming_top.sv                                                                                 //
//  Version           : 0.2                                                                                            //
//                                                                                                                     //
//  parameters used   : DATA_A       : Width of the data from port-a                                                   //
//                      DATA_B       : Width of the data from port-b                                                   //
//                      DATA_BITS    : Number of data bits                                                             //
//                      PARITY_BITS  : Number of parity bits injected in the encoded word                              //
//                      ENCODED_WORD : Length of the encoded word                                                      //
//                                                                                                                     //
//  File Description  : This is the top module of the error detection and correction logic that                        //
//                      connects the error_injector, hamming_encoder and hamming_decoder modules.                      //
//                      which inturn deals with the one-bit error detection and correction.                            //  
//                                                                                                                     //  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

module hamming_encoder_top#(  parameter DATA_A       = 8,
	                            parameter DATA_B       = DATA_A,
	                            parameter DATA_BITS    = DATA_A,
                              parameter PARITY_BITS  = $clog2(DATA_BITS) + 1,
	                            parameter ENCODED_WORD = DATA_BITS + PARITY_BITS
                          )( input bit  [DATA_A-1:0]       i_data_a,                  // Input data from port-a.
	                           input bit  [ENCODED_WORD+1:1] i_temp_a,i_temp_b,         // Error inputs for port-a and port-b.
	                           input bit  [DATA_B-1:0]       i_data_b,                  // Input data from port-b.
	                           output reg [ENCODED_WORD+1:1] o_douta,                   // Output data for port-a.
	                           output reg [ENCODED_WORD+1:1] o_doutb                    // Output data for port-b.
                           );

  wire [ENCODED_WORD+1:1] encoded_output_a,encoded_output_b; // Wires for port-a and port-b to transimit hamming encoded data to error injector.
	
  // The hamming encoder module performs the encoding of input data from
  // port-a and port-b and it is then sent to  the error injector.	
  ham_enc#( .DATA_A(DATA_A),
            .DATA_B(DATA_B),
            .ENCODED_WORD(ENCODED_WORD))HAM_ENCODER( .i_data_in_a(i_data_a),
                                                     .i_data_in_b(i_data_b),
                                                     .o_hamming_a(encoded_output_a),
  	 				                                         .o_hamming_b(encoded_output_b));
  
  //The error injector recieves the hamming encoded word and injects error
  //into the data by doing bitwise XOR operation. This error input acts as
  //a bit mask.
  err_inj#( .DATA_A(ENCODED_WORD+1),
            .DATA_B(ENCODED_WORD+1))ERROR_INJECTOR( .i_data_a(encoded_output_a),
                                                    .i_data_b(encoded_output_b),
                                                    .i_temp_a(i_temp_a),
                                                    .i_temp_b(i_temp_b),
  					                                        .o_err_out_a(o_douta),
                                                    .o_err_out_b(o_doutb));
  	
  endmodule
