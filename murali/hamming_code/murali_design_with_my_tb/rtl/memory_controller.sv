/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: memory_controller.sv
//	description			:	This module consists the functionality of memory controller, where it contains instanriation of multibank memeory. Basically it is
//										designed with an intention that constructing larger memory bank using a set of smaller memory modules. Basically this module is
//										designed to conditionally include the ECC and ERROR_INJECTION logic to the multibank design. If the ECC is defined the ecc
//										module will be included into the design and the encrypted data will be send to the multibank memory, else the original data in
//										will be passed to the multibank memory. When the ERROR_INJECT is defined Error Injection logic will be also be enabled and it
//										will inject the errors into the input data of the multibank.
//										
//	parametrs used	:	DATA_WIDTH			=	8 -> This paramter specifies the data width of each location in the latency based multi bank memory.
//										ADDR_WIDTH			=	5 -> This parameter the address width of the latency based multi bank memory.
//										WRITE_LATENCY_A	=	4 -> This parameter is used to define the write latency for the porta of latency based multi bank memory.
//										WRITE_LATENCY_B	=	3 -> This parameter is used to define the write latency for the portb of latency based multi bank memory.
//										READ_LATENCY_A	=	2 -> This parameter is used to define the read latency for the porta of latency based multi bank memory.
//										READ_LATENCY_B	=	3 -> This parameter is used to define the read latency for the portb of latency based multi bank memory.
// 
//  Input Ports   	:	i_dina,i_dinb			:	These pin used to drive the write data into the memory.
//
//                    i_addra,i_addrb		:	Depending on this values,the read or write operation is done at a specified location.
//
//  								 	i_clka,i_clkb     :	These are the clock pin for both the ports of dual port ram.
//
//  								 	i_ena,i_enb       : These are the input pin's and used to enable or disable the read and write operations.
//
//  								 	i_wea,i_web				:	These are input pin's, when they are high each performs performs the write operation and if they are
//  								 											low,devices will does read operation.
//				
//  Output Ports		:	o_douta,o_doutb 	: These are the output pin's, whenever an read operation in any of the ports the read data will be reflected
//  																			in their respective ports.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef MEMORY_CONTROLLER_SV

module memory_controller	#(	parameter			WRITE_LATENCY_A = 4,
																						WRITE_LATENCY_B	= 3,
																						READ_LATENCY_A	=	2,
																						READ_LATENCY_B	=	3,
																						DATA_WIDTH			=	8,
																						ADDR_WIDTH			=	5)
													 (	input 				[DATA_WIDTH-1:0]	i_dina,
															input					[DATA_WIDTH-1:0]	i_dinb,
															input					[ADDR_WIDTH-1:0]	i_addra,
															input					[ADDR_WIDTH-1:0]	i_addrb,
															input														i_clka,
															input 													i_clkb,
															input 													i_ena,
															input														i_enb,
															input														i_wea,
															input														i_web,
															`ifdef ECC
															output				    							o_errora,
															output				    							o_errorb,
															`endif
															output	logic [DATA_WIDTH-1:0]	o_douta,
															output	logic [DATA_WIDTH-1:0]	o_doutb);

	//This macro will be enabled only when an encryption is required else it will be disabled and it behaves like a normal multibank memory. This entire
	//macro also even controlls the DATA WIDTH of the data_in that is propagating to the Dual port ram's.
	`ifdef ECC
	parameter RAM_DATA_WIDTH	=	DATA_WIDTH + $clog2(DATA_WIDTH)+2;
	`else
	parameter	RAM_DATA_WIDTH	=	DATA_WIDTH;
	`endif

	//Internal Variables used to store the encrypted read data while an read operation is performed.
	logic	[RAM_DATA_WIDTH-1:0] 	edouta;
	logic	[RAM_DATA_WIDTH-1:0] 	edoutb;

	//Internal Variables used to pass the data conditionally to the din ports of dual port ram.
	logic [RAM_DATA_WIDTH-1:0]	final_dina;
	logic [RAM_DATA_WIDTH-1:0]	final_dinb;

	//Internal variables used to store the dout's of each dual port ram in the design. 
	logic	[RAM_DATA_WIDTH-1:0] 	douta_out[4];
	logic	[RAM_DATA_WIDTH-1:0] 	doutb_out[4];
	
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//
	// ECC Instantiation(Conditional):
	//
	// This Macro will instantiates the data encrypting designs when an ECC is defined and the input data will be passed to these designs and the final
	// encrypted data will passed to the multi_bank memory and And also It includes the Data De encrypting design when ecc is defined and the data
	// comes from the multi_bank will be passed to these modules as an input and the data will be decrypted with capable of correcting 1bit error and
	// 2bit error detection. If the ECC is not defined, the data_in ports of multi_bank memory are connected directly with data_in's, and the dout comes
	// from the ram directly connects with the output ports.
	//
	///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	`ifdef ECC
		//Internal Variables used to store the encrypted data while it is generated.
		logic [RAM_DATA_WIDTH-1:0]	e_dina,e_dinb;

		ecc #(DATA_WIDTH)	
					ecc_dut (
										.i_data_a(i_dina),
										.i_data_b(i_dinb),
										.i_enc_dina(edouta),
										.i_enc_dinb(edoutb),
										.o_enc_data_a(e_dina),
										.o_enc_data_b(e_dinb),
										.o_decr_data_a(o_douta),
										.o_decr_data_b(o_doutb),
										.o_errora(o_errora),
										.o_errorb(o_errorb)
									);
	`else
		assign final_dina		=	i_dina;
		assign final_dinb		=	i_dinb;
		assign o_douta			=	edouta;
		assign o_doutb			=	edoutb;
	`endif
	
	//This macro enables the error injection functionality only if the ECC and ERROR_INJECTION will be defined and whenever an data is being propagating
	//to the dual port automatically it will inject the zero bit,one bit and 2bit error into the data_in. If the ECC itself not defined this macro will
	//be disabled and the else it behaves like an normal multi_bank memory. And if the ECC is defined and ERROR_INJECTION is not defined then the
	//Encrypted data width and din will be given to the multi_bank.
	`ifdef ECC
		`ifdef ERROR_INJECT
			bit 												injecta;
			bit 												injectb; 
			bit		[RAM_DATA_WIDTH-1:0] 	error;
			typedef enum logic [1:0]	{ZERO,ONE,TWO}	error_type;
			typedef enum logic 				{PORTA,PORTB}		port_sel;
			
			//Error Injection Task: It is used to inject error into the write data while performing the write operation and especially while the task gets
			//called from the top.
			task automatic error_inject(input logic port,input error_type er = $urandom_range(0,2));
			begin
			  void'(std::randomize(error) with {$countones(error) == er;});
				injecta	=	1'b0;
				injectb	=	1'b0;
				if(port == PORTA) begin
					injecta	=	1'b1;
					@(posedge i_clka);
					injecta	=	1'b0;
				end
				else begin
					injectb	=	1'b1;
					@(posedge i_clkb);
					injectb	= 1'b0;
				end
				$display("at time:%0t : error = %b",$time,error);
			end
			endtask : error_inject
			assign	final_dina	=	(injecta == 1)?(e_dina ^ error):(e_dina);
			assign	final_dinb	=	(injectb == 1)?(e_dinb ^ error):(e_dinb);
		`else
			assign final_dina	=	e_dina;
			assign final_dinb	=	e_dinb;
		`endif
	`endif

	//MULTI_BANK Instantiation
	multi_bank #(	WRITE_LATENCY_A,
								WRITE_LATENCY_B,
								READ_LATENCY_A,
								READ_LATENCY_B,
								RAM_DATA_WIDTH,
								ADDR_WIDTH)
							multi_bank_dut
							(
								.i_dina(final_dina),
								.i_dinb(final_dinb),
								.i_addra(i_addra),
								.i_addrb(i_addrb),
								.i_clka(i_clka),
								.i_clkb(i_clkb),
                .i_ena(i_ena),
								.i_enb(i_enb),
                .i_wea(i_wea),
								.i_web(i_web),
                .o_douta(edouta),
								.o_doutb(edoutb)
								);

endmodule : memory_controller

`endif
