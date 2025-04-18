/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  File name         : error_injector.sv                                                                              //
//  Version           : 0.2                                                                                            //
//                                                                                                                     //
//  parameters used   : DATA_A : Width of the hamming encoded data from port-a                                         //
//                      DATA_B : Width of the hamming encoded data from port-b                                         //
//                                                                                                                     //
//  File Description  : This module injects one_bit error into the hamming_encoded word by doing                       //
//                      bitwise XOR operation of the error bit mask with the hamming encoded data                      //
//                      word that flips the data bits accordingly. Here we have used "o_dbit_err_x"                    //
//                      (x = a or b which reperesents port-a or port-b) signal for ports A and B                       //
//                      which is asserted when the error is a 2-bit error.                                             //      
//                                                                                                                     //  
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 

module err_inj#(parameter DATA_A = 16,
                parameter DATA_B = DATA_A
               )(
                input      [DATA_A-1:0]  i_data_a,    // Input hamming_encoded word for port-a.
                input      [DATA_B-1:0]  i_data_b,    // Input hamming_encoded word for port-b.
                output reg [DATA_A-1:0]  o_err_out_a, // Corrupted hamming_encoded output for port-a.
                output reg [DATA_B-1:0]  o_err_out_b  // Corrupted hamming_encoded output for port-b.
                );
 
  reg      [DATA_A-1:0]  i_temp_a;    // Error input for port-a.
  reg      [DATA_B-1:0]  i_temp_b;    // Error input for port-b.
  reg                    err_a,err_b; // Internal variables to randomize single_bit and double_bit.
  logic                  rand_status_a;
  logic                  rand_status_b;

  // This procedural block performs XOR opeartion of the hamming_encoded word,
  // with the bit mask error input that can be a one-bit, two-bit or no-bit
  // error.
  always@(*)
  begin
    //err_a generates random values between 0-1.
    err_a         = $urandom_range(0,1);
    //Here we are randomizing the error input i_temp_a with 0,1 bit errors
    //using scope randomization and $countones function for port-a.
    rand_status_a = (std::randomize(i_temp_a)with{$countones(i_temp_a) == err_a;});
    //err_b generates random values between 0-1. 
    err_b         = $urandom_range(0,1);
    //Here we are randomizing the error input i_temp_a with 0,1 bit errors
    //using scope randomization and $countones function for port-b.
    rand_status_b = (std::randomize(i_temp_b)with{$countones(i_temp_b) == err_b;});
    o_err_out_a = i_data_a  ^  i_temp_a;
    o_err_out_b = i_data_b  ^  i_temp_b;	
  end
  
endmodule
