////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: dual_port_ram.v
//	description			:	This module consists the functionality of dual port ram. It has two ports named PORTA and PORTB. Both ports supports read and
//										write operation. So,it supports dual writes and dual reads, and it is also having a exception that writing into a same location
//										at an same instace of time will result in storing any of the write data.So it is not recommended to create this scneario. The
//										operation of the dual port ram is similar to the single port ram, but as compared with this, dual port can perform more write
//										and reads. But to this there is another additional feature that does delaying the write and read operation.So that, whenever a
//										read operation is performed the read data will be reflected on the data out pin after specified no.of clock cycles. Even for the
//										write whatever the write data we are driving to ram, the write will be happened after a specified no. of clock cycles. (Have to
//										specify before the READ and WRITE latency for both the ports.)
//										
//	parametrs used	:	DATA_WIDTH			=	8 -> This paramter specifies the data width of each location in the latency based dual port ram.
//										ADDR_WIDTH			=	3 -> This parameter the address width of the latency based dual port ram.
//										WRITE_LATENCY_A	=	4 -> This parameter is used to define the write latency for the porta of latency dual port ram. 
//										WRITE_LATENCY_B	=	3 -> This parameter is used to define the write latency for the portb of latency dual port ram.
//										READ_LATENCY_A	=	2 -> This parameter is used to define the read latency for the porta of the latency dual port ram.
//										READ_LATENCY_B	=	3 -> This parameter is used to define the read latency for the portb of the latency dual port ram.
// 
//  Input Ports   	:	i_dina,i_dinb		:	These pin used to drive the write data into the memory.
//
//                    i_addra,i_addrb	:	Depending on this values,the read or write operation is done at a specified location.
//
//  								 	i_clka,i_clkb		:	These are the clock pin for both the ports of dual port ram.
//
//  								 	i_ena,i_enb			: These are the input pin's and used to enable or disable the read and write operations.
//
//  								 	i_wea,i_web			:	These are input pin's, when they are high each performs performs the write operation, and if they are low,
//  								 										devices will does read operation.
//  								 								
//  Output Ports		:	o_douta,o_doutb	: These are the output pin's, whenever an read operation in any of the ports the read data will be reflected in
//  																		their respective ports.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef DUAL_PORT_RAM

module dual_port_ram #(parameter 	WRITE_LATENCY_A	=	4,
																	WRITE_LATENCY_B	=	3,
																	READ_LATENCY_A	=	2,
																	READ_LATENCY_B	=	3,
																	DATA_WIDTH			=	8,
																	ADDR_WIDTH			=	3)	
											(	input					[DATA_WIDTH-1:0]	i_dina,i_dinb,
												input 				[ADDR_WIDTH-1:0]	i_addra,i_addrb,
												input 													i_clka,i_clkb,
												input 													i_ena,i_enb,
												input 													i_wea,i_web,
												output logic	[DATA_WIDTH-1:0]	o_douta,o_doutb
											);

	//Memory For the DUAL port RAM
	logic [DATA_WIDTH-1:0]	mem	[2**ADDR_WIDTH];

	//Internal varaibled to stores the latencied values for the dual port ram inputs and outputs.
	logic	[DATA_WIDTH-1:0]	l_dina;
	logic	[ADDR_WIDTH-1:0]	l_addra;
	logic	 									l_ena;	
	logic	 									l_wea;
	logic	[DATA_WIDTH-1:0] 	l_dinb;
	logic	[ADDR_WIDTH-1:0] 	l_addrb;
	logic	 									l_enb;
	logic	 									l_web;
	logic	[DATA_WIDTH-1:0] 	douta_out;
	logic	[DATA_WIDTH-1:0] 	doutb_out;
	
	
	//Module: "latency"
	//latency module instantiation. This module consists the functionality of the producing the latencied values for the given set of inputs. This will
	//be take care of introducing the Latency into the dual port ram.
	latency	#(WRITE_LATENCY_A,
						WRITE_LATENCY_B,
						READ_LATENCY_A,
						READ_LATENCY_B,
						DATA_WIDTH,
						ADDR_WIDTH)	latency 
						(	.i_dina(i_dina),
							.i_dinb(i_dinb),
							.i_addra(i_addra),
							.i_addrb(i_addrb),
							.i_clka(i_clka),
							.i_clkb(i_clkb),
							.i_ena(i_ena),
							.i_enb(i_enb),
							.i_wea(i_wea),
							.i_web(i_web),
							.i_douta(douta_out),
							.i_doutb(doutb_out),
							.o_dina(l_dina),
							.o_dinb(l_dinb),
							.o_addra(l_addra),
							.o_addrb(l_addrb),
							.o_ena(l_ena),
							.o_enb(l_enb),
							.o_wea(l_wea),
							.o_web(l_web),
							.o_douta(o_douta),
							.o_doutb(o_doutb)
						);
	
	//PortA Write and Read Logic
	//This block will constitute the functionality of the reading from and writing to the memory. And the Writing is done using the latencied values.
	//Which are been generated by the latency module. While the reading is happens on the non latencied vlaues. Whatever the inputs for the dual port
	//ram specifically for this port will be directly used to perfrom the read operation. 
	always_ff@(posedge i_clka)
	begin
		if(l_ena && l_wea)
		begin
			mem[l_addra]	<=	l_dina;					//Writing the write data into the specified memory location.
			`ifdef DATA_LOGGING
				dispf(WRITE,PORTA,l_addra,l_dina);	
			`endif
		end
		if(i_ena && (!i_wea))	
		begin
			douta_out			<=	mem[i_addra];		//reading the data from specified location and storing into the internal dout.
			`ifdef DATA_LOGGING
				dispf(READ,PORTA,i_addra,,douta_out);	
			`endif
		end
	end

	//PortB Write and Read Logic
	//This block will constitute the functionality of the reading from and writing to the memory. And the Writing is done using the latencied values.
	//Which are been generated by the latency module. While the reading is happens on the non latencied vlaues. Whatever the inputs for the dual port
	//ram specifically for this port will be directly used to perfrom the read operation.
	always_ff@(posedge i_clkb)
	begin
		if(l_enb && l_web)
		begin
			mem[l_addrb]	<=	l_dinb;						//Writing the write data into the specified memory location.
			`ifdef DATA_LOGGING
				dispf(WRITE,PORTB,l_addrb,l_dinb);	
			`endif
		end
		if(i_enb && (!i_web))
		begin
			doutb_out			<=	mem[i_addrb];     //reading the data from specified location and storing into the internal dout.
			`ifdef DATA_LOGGING
				dispf(READ,PORTB,i_addrb,,doutb_out);	
			`endif
		end
	end

	`ifdef DATA_LOGGING
		`ifdef ECC
			`ifdef ERROR_INJECT
				`define ERROR_STATUS 1
			`endif
		`endif
		typedef enum logic {READ,WRITE}	 operation;
		typedef enum logic {PORTA,PORTB} port;
		int fd;
		initial begin
			fd	=	$fopen("../sim/memory_controller.log","w");
			$fdisplay(fd,"***********************************************************************************************************************************");
			$fdisplay(fd,"FILE NAME				:	dual_port_ram.sv");
			$fdisplay(fd,"ERROR INJECTION	:	%0d",`ERROR_STATUS);
			$fdisplay(fd,"PARAMETRS USED	:	DATA_WIDTH			=	%0d",DATA_WIDTH);
			$fdisplay(fd,"									ADDRRESS_WIDTH	=	%0d",ADDR_WIDTH);
			$fdisplay(fd,"									WRITE_LATENCY_A	=	%0d",WRITE_LATENCY_A);
			$fdisplay(fd,"									WRITE_LATENCY_B	=	%0d",WRITE_LATENCY_B);
			$fdisplay(fd,"									READ_LATENCY_A	=	%0d",WRITE_LATENCY_A);
			$fdisplay(fd,"									READ_LATENCY_B	=	%0d",WRITE_LATENCY_B);
			$fdisplay(fd,"***********************************************************************************************************************************");
			$fdisplay(fd,"at time : %0t,								OPERATION		PORT		ADDRESS				INPUT_DATA						OUTPUT_DATA",$time);
		end

		task automatic dispf(input operation oper,input port port_sel,logic [ADDR_WIDTH-1:0] addr,logic [DATA_WIDTH-1:0] data = 'hx,logic [DATA_WIDTH-1:0]out_data = 'hx);
			$fdisplay(fd,"at time : %0t,							%s				%s			%0h						%0h									%0h",$time,oper.name,port_sel.name,addr,data,out_data);
		endtask
	`endif
endmodule

`endif
