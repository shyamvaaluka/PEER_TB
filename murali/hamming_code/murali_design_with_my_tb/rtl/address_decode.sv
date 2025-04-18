/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: address_decode.sv
//	description			:	This module consists the functionality of address decoding logic for the data out picking for the memory controller. This module
//										synchronoizes the read addr and the read data and so, the correct data will be picked at right amongst the set of data out's
//										present at that time instant. This module takes the bank address and then make it delayed for the port specific latency cycles
//										and then it will be sent as an decoded bank for propagating the correct data out to the output port.
//										
//	parametrs used	:	READ_LATENCY_A	=	2 -> This parameter is used to delay the bank address for the specified no of latency cycles for Port A.
//										READ_LATENCY_B	=	3 -> This parameter is used to delay the bank address for the specified no of latency cycles for Port B.
// 
//  Input Ports   	:	i_addra,i_addrb		:	These are the input bank address values, which comes from the top module the decoded bank address will be
//  																			obtained from the input address value passed to the design.
//
//  								 	i_clka,i_clkb     :	These are the clock pin for both the ports of address decode design.
//
//  								 	i_ena,i_enb       : These are the input pin's and used to synchronize the bank address with it's corresponding data out
//  								 											generated.
//
//  								 	i_wea,i_web				:	These are input pin's, when these pins are low indicating the read operation and the correspoding bank
//  								 											address will delayed as per read latency delay corresponding to their ports.
//				
//  Output Ports		:	o_addra,o_addrb 	: These are the output pin's, whenever an read operation in any of the ports the bank address will be reflected
//  																			in their respective ports after certain no of clock cycles with respective to their ports in synchronous
//  																			with the read data.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef ADDRESS_DECODE_SV

module address_decode #(	parameter READ_LATENCY_A = 2,
																		READ_LATENCY_B = 3)
											 (	input								i_ena,i_enb,
											 		input 							i_wea,i_web,
													input 							i_clka,i_clkb,
													input 	logic [1:0]	i_addra,i_addrb,
													output	logic [1:0]	o_addra,o_addrb
											 );
	
	//Internal variables used to store the synchronized read address, when an read transaction is happened.
	logic [1:0]	addra[READ_LATENCY_A];
	logic [1:0]	addrb[READ_LATENCY_B];

	//Address Synchronization :These block's is used to pass an bank address to the latency shift registers conditionally and synchronous to the clock.
	//So,when it detects an read operation then it will samples the bank address and pass to the further combinational circuit after the specified no of
	//clock cycles depending on the read latency parameters defined for the design.
	genvar i;
	generate 
		always_ff@(posedge i_clka)
		begin
			if(i_ena && (!i_wea))	addra[0] <= i_addra;
		end
		if(READ_LATENCY_A > 1)
		begin
			for(i = 1; i < READ_LATENCY_A ;i++)
			begin
				always_ff@(posedge i_clka)
				begin
					addra[i]	<=	addra[i-1];
				end
			end
		end
		always_ff@(posedge i_clkb)
		begin
			if(i_enb && (!i_web))	addrb[0] <= i_addrb;
		end
		if(READ_LATENCY_B > 1)
		begin
			for(i = 1;i < READ_LATENCY_B;i++)
			begin
				always@(posedge i_clkb)
				begin
					addrb[i] <= addrb[i-1];
				end
			end
		end
	endgenerate

	//The bank address will be passed to the output bank address from each latency register end data. Which will used by top module to pick the correct
	//read data.
	always_comb
	begin
		o_addra	=	addra[READ_LATENCY_A-1];
		o_addrb	=	addrb[READ_LATENCY_B-1];
	end

endmodule : address_decode

`endif
