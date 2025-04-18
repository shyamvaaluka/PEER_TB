/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: multi_bank.sv
//	description			:	This module consists the functionality of multi bank memory, where it contains 4 instances of the dual port ram. Basically it is
//										designed with an intention that constructing larger memory bank using a set of smaller memory modules. So here in this design,
//										four dual port ram's are used to design a larger memory that used to store 8bits in 32 locations. And in addition to that it
//										will be also having the latency at both the ports. It is similar to the normal dual port ram, but it is	capable of storing more
//										no of bytes as compared to the dual port ram.
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

`ifndef MULTI_BANK_SV

module multi_bank	#(	parameter			WRITE_LATENCY_A = 4,
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
											output	logic [DATA_WIDTH-1:0]	o_douta,
											output	logic [DATA_WIDTH-1:0]	o_doutb);

	//Internal variables used to propagate the enable values to the exact ram depending on the MSB bits of address.
	logic	 									enb_a[4];	
	logic	 									enb_b[4];	

	//Internal variables used to store the dout's of each dual port ram in the design. 
	logic	[DATA_WIDTH-1:0] 	douta_out[4];
	logic	[DATA_WIDTH-1:0] 	doutb_out[4];
	
	//Internal variables used to store the synchronized read address, when an read transaction is happened.
	logic [1:0]							addra,addrb;

	//Generator variable: It is used inside the generate block as a loop variable.
	genvar i;

	//Generate Block
	//This block is used to generate the 4 dual port ram instances, and also to create an set of continious assignments for each of the port which
	//enables the particular ram to perform the write or read operation.
	generate
		for(i = 0;i < 4;i++)
		begin
			assign enb_a[i]		=	(i_addra[ADDR_WIDTH-1:ADDR_WIDTH-2]==i)?(i_ena):(1'b0);			
			assign enb_b[i]		=	(i_addrb[ADDR_WIDTH-1:ADDR_WIDTH-2]==i)?(i_enb):(1'b0);
			dual_port_ram #(WRITE_LATENCY_A,
											WRITE_LATENCY_B,
											READ_LATENCY_A,
											READ_LATENCY_B,
											DATA_WIDTH,
											ADDR_WIDTH-2)
											mem	(
													.i_dina(i_dina),
													.i_dinb(i_dinb),
													.i_addra(i_addra[ADDR_WIDTH-3:0]),
													.i_addrb(i_addrb[ADDR_WIDTH-3:0]),
													.i_clka(i_clka),
													.i_clkb(i_clkb),
  		                  	.i_ena(enb_a[i]),
													.i_enb(enb_b[i]),
  		                  	.i_wea(i_wea),
													.i_web(i_web),
  		                  	.o_douta(douta_out[i]),
													.o_doutb(doutb_out[i])
													);
		end
	endgenerate

	//Address Synchronization : These block's is used to genearate the bank address and it will used to pick the right address at the right time to
	//collect the proper data at that instance of time for an particular read operation.
	address_decode #(READ_LATENCY_A,
									 READ_LATENCY_B)
									 decode(.i_ena(i_ena),
													.i_enb(i_enb),
													.i_wea(i_wea),
													.i_web(i_web),
													.i_clka(i_clka),
													.i_clkb(i_clkb),
													.i_addra(i_addra[ADDR_WIDTH-1:ADDR_WIDTH-2]),
													.i_addrb(i_addrb[ADDR_WIDTH-1:ADDR_WIDTH-2]),
													.o_addra(addra),
													.o_addrb(addrb)
												 );

	//This block is used to select one of the amongst dual port ram outputs depending on the bank address generated by the address_decode design, and
	//the selected dout will be passed to the output ports as an final read data.
	always_comb
	begin
		o_douta	=	douta_out[addra];
		o_doutb	=	doutb_out[addrb];
	end

endmodule : multi_bank

`endif
