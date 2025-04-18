//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: hamming_encoder.sv
//	description			:	This module consists the functionality of the hamming encoder of input data using hamming code.By using hamming code the
//										encoded data wll be determined by inserting some parity bits in between the input data and so the datawidth of the encoded will
//										be more than input data width.
//										
//	parametrs used	:	DATA_WIDTH	=	8 ->	This parameter defines the data width of input data and accordingly the data width of the output will be
//																				calculated it self.
// 
//  Input Ports   	:	i_data		:	This is the input pin to the design and once the change happened in this port automatically the encoded data will
//  															be caluclated.
//
//  Output Ports		:	o_douta		: It is the output port of the module,whenever an change happens in the input the parity will be caluclated and then
//  															inserted in between the data bits and outputs the encoded data.
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef HAMMING_ENCODER_SV

module hamming_encoder #(parameter DATA_WIDTH	=	8)
												(	input 	[DATA_WIDTH-1:0]										i_data,
           								output 	[DATA_WIDTH+$clog2(DATA_WIDTH)+1:0]	o_enc_data
												);
  
	//This parameter is used to extend the data width's of the internal which will be used to make the logic more generalized.
	parameter	PARITY_WIDTH	=	$clog2(DATA_WIDTH)+1;
	parameter ENC_WIDTH			=	DATA_WIDTH + PARITY_WIDTH;

	//This E_WIDTH parameter is used to make the code more generalized and the E_WIDTH is 2 powered value of the PARITY_WIDTH.
	parameter E_WIDTH 			= 2**PARITY_WIDTH;
  
	//This internal variable is used to store the generate the parity value.
  logic [PARITY_WIDTH-1:0]parity;
  
	//These internal variables used to store the partial data that will be generated in the process of encoding the data. The ex_data variable is just
	//used to store the same input data and extend the data width and fill them with zero's. Which will be helpful while positioning the data in the
	//encoded data at the exact fields as per hamming code. While the out will store the partial exor values generated in middle of the process.
  logic [E_WIDTH-1:0]			edata,ex_data;
  logic [(E_WIDTH/2)-1:0]	out[PARITY_WIDTH];
  
	//This assignment will drives the input data continously to the internal variable ex_data which of width E_WIDTH used in the parity generation which
	//makes the logic more generalized.
  assign ex_data		=	{{(E_WIDTH-DATA_WIDTH){1'b0}},i_data};

	//This assignment will drives the caluclated encoded data onto the output port which is of width ENC_WIDTH.
  assign o_enc_data = {^edata[ENC_WIDTH-1:0],edata[ENC_WIDTH-1:0]};

	//genvar variables used as loop index for the for loop inside the generate block
  genvar i,j,k;

	//This block will generate the logic for the parity generation,Encoding of the input data.
  generate 
		//This loop will generate the logic for placing the input data bits on to the encoded data bus at the correct positions as per hamming code.
    for(k = 1;k < PARITY_WIDTH;k++) begin
      assign edata[(2**(k+1))-2:(2**k)] = {ex_data[((2**(k))-(k+1))+((2**k) -2):((2**(k))-(k+1))]};
    end
		//This loop will generate the logic for the parity generation.
    for(i = 0;i < PARITY_WIDTH;i++) begin
      for(j = 0;j < (E_WIDTH/(2**(i+1)));j++) begin
        if((i == 0)&(j == 0)) begin
            assign out[i][j] = 0;
        end
        else if(j == 0) begin
          assign out[i][j] = (^edata[(2*(2**i))-2:(2**i)]);
        end
        else assign out[i][j] = (^edata[(j*(2**(i+1)))+(2**i)+(2**i) -2 :(j*(2**(i+1)))+(2**i)-1])^out[i][j-1];
        if((j+1) == (E_WIDTH/(2**(i+1)))) assign parity[i] = out[i][j];
      end
    end
		//The below assignments will drive the edata with the generated parity values at the positions corresponding hamming code format.
    assign edata[0] = parity[0];
    assign edata[1] = parity[1];
    for(k = 1;k < PARITY_WIDTH;k++) begin
      assign edata[(2**(k+1))-1] = parity[(k+1)];
    end
  endgenerate
  
endmodule : hamming_encoder

`endif	//HAMMING_ENCODER_SV
