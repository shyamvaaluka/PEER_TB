/*//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: hamming_decoder.sv
//	description			:	This module consists the functionality of the hamming decoder of input encoded data using hamming code.By using hamming code
//										the	decoded data wll be determined by determining the parity bits values. If all the parity bits are 0 it indicates that there
//										is no error in the input data and if the combination of parity bits results a non zero value then it returns the error modified
//										data using that non zero value and it will flip the bit at that corresponding position and determines the actual data from that
//										encoded data. This logic will is capable to correct upto 1bit error in the encoded data.
//										
//	parametrs used	:	DATA_WIDTH	=	8 -> This Parameter is used to define the data width of the out data that it can generate and in addition to that
//																				depending on this value the data width of input will also be decided.
// 
//  Input Ports   	:	i_data		:	This is the input pin to the design and once a data change happens in this port,automatically the decoded data will
//  															be caluclated.
//
//  Output Ports		:	o_error		:	This signal is used to know the type of error this module is identified.
//										o_douta		: It is the output port of the module, whenever an change happens in the input, the parity will be caluclated and then
//																if it is a non zero value then the bit corresponding to the parity value will be flipped and then the actual data
//																will be decoded from this error free encoded data as an decoded data.
//																
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef HAMMING_DECODER_SV

module hamming_decoder #(	parameter DATA_WIDTH = 8)
												(	input 	[DATA_WIDTH + $clog2(DATA_WIDTH)+1:0]	i_enc_data,
													output	      																o_error,
													output	[DATA_WIDTH-1:0]											o_decr_data);

	//These parameters are used to generalize the datawidths of internal registers to make the design more generalized.
	parameter	PARITY_WIDTH	=	$clog2(DATA_WIDTH)+1;
	parameter	ENC_WIDTH			=	DATA_WIDTH + PARITY_WIDTH;
	parameter E_WIDTH 			= 2**PARITY_WIDTH;

	//This internal wire is used to determine the parity of the Encoded data. 
	logic	[PARITY_WIDTH-1:0]	parity;

	//This variable is used to store the extra parity bit caluclated for the given input encoded data. Where the xparity denotes the extra parity.
	logic 										xparity;

	//This internal wire is used to store the data by extending the data width. 
	logic [E_WIDTH-1:0]				edata;
	
	//This internal wire is used to store the error corrected values of the encoded data. 
	logic	[E_WIDTH-1:0]				dec_data;
	
	//This internal wire is used to store the decoded data which will be decoded from the error free encryted data.
	logic [E_WIDTH-1:0]				d_data;

	//This internal variables is used to store the partial parities generated in the process of parity generation.
	logic	[(E_WIDTH/2)-1:0]		out[PARITY_WIDTH];

	//This assignment will extend the data width of the encoded which will be used to make the parity bit generation more generalized.
	assign edata		=	{{(E_WIDTH-ENC_WIDTH){1'b0}},i_enc_data[ENC_WIDTH-1:0]};

	//This assigment will drive the xparity with the xor'ed value of encoded data input.
	assign xparity	=	(^i_enc_data);

	//generate block variables used as loop index in the generate block
  genvar i,j,k;

	//This will generate the logic for parity generation, error correction and decoding the data from the error correction data.
  generate 
		//This loop will generate the parity bits from the recieved encoded data - The even parity is used for encoding and decoding of the data.
    for(i = 0;i < PARITY_WIDTH;i++) begin
      for(j = 0;j < (E_WIDTH/(2**(i+1)));j++) begin
        if((i == 0)&(j == 0)) begin
            assign out[i][j] = edata[0];
        end
        else if(j == 0) begin
          assign out[i][j] = (^edata[(2*(2**i))-2:(2**i)-1]);
        end
        else assign out[i][j] = (^edata[(j*(2**(i+1)))+(2**i)+(2**i) -2 :(j*(2**(i+1)))+(2**i)-1])^out[i][j-1];
        if((j+1) == (E_WIDTH/(2**(i+1)))) assign parity[i]=out[i][j];
      end
    end
		//This generate block will drive the encoded bits to another wire conditionally, like when the (parity-1) value matches with an index that
		//corresponding index bit will be flipped.
		//for(i = 0;i < E_WIDTH;i++)
		//begin
		//	assign dec_data[i]	=	(i==(parity-1))?(!edata[i]):(edata[i]);
		//end
    always_comb
    begin
			dec_data	          =	edata;
      dec_data[parity-1]  = ~edata[parity-1];
    end
		//This assinment will drives the output port with the updated error free data in the encoded data.
		assign d_data[0]	=	dec_data[2];
    for(k = 2;k < PARITY_WIDTH;k++) begin
      assign d_data[((2**k)-(k+1))+(2**k)-2:((2**k)-(k+1))] = dec_data[(2**(k+1))-2:(2**k)];
    end
  endgenerate

	//This assignment will drives the output with the decoded value which is an error free data and the actual that has been sent.
	assign o_decr_data	=	d_data[DATA_WIDTH-1:0];
	
	//This assignment information about type error the data comes in to this design. Whether it is a 0,1, or 2 bit error or Pn+1 parity bit error it
	//denotes.
	assign o_error	=	(|parity) && (!xparity);

	//This macro will be enabled only when ECC and ERROR_INJECT are defined else it will be disabled. It is used to monitor the type of error, the Data
	//Decoding module is noticed while decoded the recieved data by displaying the Parity related information.
	`ifdef ECC
		`ifdef ERROR_INJECT
			always_comb
			begin
				case({(|parity),xparity})
					2'b00		: $display("at time: %0tns : PORTA: NO ERROR OCCURED",$time);
					//2'b01		: $display("at time: %0tns : PORTA: ERROR ocured in Pn+1 bit",$time);
					2'b10		: $display("at time: %0tns : PORTA: DOUBLE BIT ERROR ENCOUNTERED",$time);
					2'b11		: $display("at time: %0tns : PORTA: SINGLE BIT ERROR OCCURED",$time);
				endcase
			end
      always@(o_error)
      begin
        $display("***************************************************at time: %0tns : o_error  = %0b***************************************************",$time,o_error); 
      end
		`endif
	`endif

endmodule :	hamming_decoder

`endif //HAMMING_DECODER_SV
