////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: latency.v
//	description			:	This module consists the functionality, so that it generates an latencied version of inputs as outputs,so that whatever the
//										inputs that it recivies it just makes them hold for some clock cycles and produce them as outputs after specfied number of clock
//										cycles(This information will be get through the several it has). Apart from that it is mainly intended to use for the dual port
//										ram, there will be seperate logics for the read and write. So, it allows only the write stimulus and the read data to propagate
//										to the outputs and if it is an read data, for such set of inputs they will driven to 'x. So that, there will be no interference
//										of read when a write is happening.
//										
//	parametrs used	:	DATA_WIDTH			=	8 -> This paramter specifies the data width of each location in the latency based multi bank memory.
//										ADDR_WIDTH			=	3 -> This parameter the address width of the latency based multi bank memory.
//										WRITE_LATENCY_A	=	4 -> This parameter is used to define the write latency for the porta of latency based multi bank memory.
//										WRITE_LATENCY_B	=	3 -> This parameter is used to define the write latency for the portb of latency based multi bank memory.
//										READ_LATENCY_A	=	2 -> This parameter is used to define the read latency for the porta of latency based multi bank memory.
//										READ_LATENCY_B	=	3 -> This parameter is used to define the read latency for the portb of latency based multi bank memory.
// 
//  Input Ports   	:	i_dina,i_dinb		:	These pins data will be driven to the out ports only if their corresponding port's write enable is high else
//  																		they will be driven to zero.  									
//																	
//  								:	i_addra,i_addrb	:	These pins data will be driven to the out ports only if their corresponding port's write enable is high else
//  																		they will be driven to zero.
//
//  								 	i_clka,i_clkb 	:	These are the clock pin's for both the ports.
//  								 	
//  								 	i_ena,i_enb  		: Even these pins will also driven to x when the wr en is low else whatever the data it is have it will be
//  								 										driven.
//
//  								 	i_wea,i_web			:	These are input pin's, when they are high each of the correspoding pins for that port will be driven their
//  								 										values else the x will be driven to outports.
//					
//  Output Ports		:	o_dina,o_dinb,o_addra,o_addrb,o_ena,o_enb,o_wea,o_web,o_douta,o_doutb.
//  									These outputs are nothing but the latencied values of inputs provided to this module and the how many does each consistutes the
//  									latency is determined by the parmeters provided to that module.
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef	LATENCY_SV

module latency	#(parameter WRITE_LATENCY_A	=	4,
														WRITE_LATENCY_B	=	3,
														READ_LATENCY_A	=	2,
														READ_LATENCY_B	=	3,
														DATA_WIDTH			=	8,
														ADDR_WIDTH			=	3)	
									(	input		[DATA_WIDTH-1:0]	i_dina,i_dinb,
										input 	[ADDR_WIDTH-1:0]	i_addra,i_addrb,
										input 										i_clka,i_clkb,
										input 										i_ena,i_enb,
										input 										i_wea,i_web,
										input		[DATA_WIDTH-1:0]	i_douta,i_doutb,
										output	[DATA_WIDTH-1:0]	o_dina,o_dinb,
										output	[ADDR_WIDTH-1:0]	o_addra,o_addrb,
										output										o_ena,o_enb,
										output										o_wea,o_web,
										output	[DATA_WIDTH-1:0]	o_douta,o_doutb);
	

	
	
	//PORTA Logic
	//This block filters the write data and move it to the next position in the array and at every positive edge of the clock so that the data whatever
	//comes in shiting will be happened towards the right at each clock edge. And when a read data recievied then the instead of that data all of the
	//variables for that stage will be driven to the X. So that the dual reads won't be happened. The reason behind this is, whenever a read operation
	//is done on the design immediately at the posedge of the clk the data will read from the memory and makes it delays for several clock cycles and
	//then passes to the actual output ports. But as coming to the write, it self the operation will be happened after a several clock cycles.
	genvar i,k;
	generate
		if(WRITE_LATENCY_A > 1)
		begin
			//These are the interal variables used to store the input data temporarily so, that for each of the clock cycles the data will be moved to end
			//of the array.All the inputs variables will be stored in this reisters depending one READ and WRITE latencies for both the ports.
			logic 									l_ena[WRITE_LATENCY_A-1];
			logic 									l_wea[WRITE_LATENCY_A-1];
			logic [ADDR_WIDTH-1:0]	l_addra[WRITE_LATENCY_A-1];
			logic [DATA_WIDTH-1:0]	l_dina[WRITE_LATENCY_A-1];
			always_ff@(posedge i_clka)
			begin
				l_dina[0] 	<= 	i_dina; //(i_wea)?(i_dina):('x);
				l_addra[0] 	<= 	i_addra;//(i_wea)?(i_addra):('x);
				l_ena[0]		<=	i_ena;  //(i_wea)?(i_ena):(1'b0);
				l_wea[0]		<=	i_wea;  //(i_wea)?(i_wea):(1'b0);
			end
			for(i=1;i<WRITE_LATENCY_A;i=i+1'b1)
			begin
				always_ff@(posedge i_clka)
				begin
					l_dina[i]		<=	l_dina[i-1];
					l_addra[i]	<= 	l_addra[i-1];
					l_ena[i]		<=	l_ena[i-1];
					l_wea[i]		<=	l_wea[i-1];
				end
			end
			assign  o_ena  	=	l_ena[WRITE_LATENCY_A-2];	 
			assign  o_wea  	=	l_wea[WRITE_LATENCY_A-2];	 
			assign  o_addra	=	l_addra[WRITE_LATENCY_A-2];
			assign 	o_dina 	=	l_dina[WRITE_LATENCY_A-2]; 
		end
		else
		begin
			assign  o_ena  	=	i_dina;   //(i_wea)?(i_ena):(1'b0);
			assign  o_wea  	=	i_addra;  //(i_wea)?(i_wea):(1'b0);
			assign  o_addra	=	i_ena;    //(i_wea)?(i_addra):('x);
			assign 	o_dina 	=	i_wea;    //(i_wea)?(i_dina):('x); 
		end                 
		if(READ_LATENCY_A	> 1)
		begin
			logic [DATA_WIDTH-1:0]	l_douta[READ_LATENCY_A-1];
			always@(posedge i_clka)
			begin
				l_douta[0]		<=	i_douta;
			end
			for(k=1;k<READ_LATENCY_A;k=k+1'b1)
			begin
				always_ff@(posedge i_clka)
				begin
					l_douta[k]	<=	l_douta[k-1];
				end
			end
			assign 	o_douta	=	l_douta[READ_LATENCY_A-2];
		end
		else	assign 	o_douta	=	i_douta;
	endgenerate

	//PORTB Logic
	//This block filters the write data and move it to the next position in the array and at every positive edge of the clock so that the data whatever
	//comes in shiting will be happened towards the right at each clock edge. And when a read data recievied then the instead of that data all of the
	//variables for that stage will be driven to the X. So that the dual reads won't be happened. The reason behind this is, whenever a read operation
	//is done on the design immediately at the posedge of the clk the data will read from the memory and makes it delays for several clock cycles and
	//then passes to the actual output ports. But as coming to the write, it self the operation will be happened after a several clock cycles.

	genvar j,l;
	generate
		if(WRITE_LATENCY_B > 1)
		begin
			//These are the interal variables used to store the input data temporarily so, that for each of the clock cycles the data will be moved to end
			//of the array.All the inputs variables will be stored in this reisters depending one READ and WRITE latencies for both the ports.
			logic 									l_enb[WRITE_LATENCY_B-1];
			logic										l_web[WRITE_LATENCY_B-1];
			logic [ADDR_WIDTH-1:0]	l_addrb[WRITE_LATENCY_B-1];
			logic [DATA_WIDTH-1:0]	l_dinb[WRITE_LATENCY_B-1];
			always_ff@(posedge i_clkb)
			begin
				l_enb[0]		<=	i_enb;  //(i_web)?(i_enb):(1'b0);
				l_web[0]		<=	i_web;  //(i_web)?(i_web):(1'b0);
				l_addrb[0]	<=	i_addrb;//(i_web)?(i_addrb):('x);
				l_dinb[0] 	<= 	i_dinb; //(i_web)?(i_dinb):('x);
			end
			for(j=1;j<WRITE_LATENCY_B;j=j+1'b1)
			begin
				always_ff@(posedge i_clkb)
				begin
					l_dinb[j]		<=	l_dinb[j-1];
					l_addrb[j]	<= 	l_addrb[j-1];
					l_enb[j]		<=	l_enb[j-1];
					l_web[j]		<=	l_web[j-1];
				end
			end
			assign  o_enb  	=	l_enb[WRITE_LATENCY_B-2];	 
			assign  o_web  	=	l_web[WRITE_LATENCY_B-2];	 
			assign 	o_addrb	=	l_addrb[WRITE_LATENCY_B-2];
			assign 	o_dinb 	=	l_dinb[WRITE_LATENCY_B-2]; 
		end
		else begin
			assign  o_enb  	=	 i_enb;      //(i_web)?(i_enb):(1'b0); 
			assign  o_web  	=	 i_web;      //(i_web)?(i_web):(1'b0);
			assign 	o_addrb	=	 i_addrb;    //(i_web)?(i_addrb):('x);
			assign 	o_dinb 	=	 i_dinb;     //(i_web)?(i_dinb):('x);
		end
		if(READ_LATENCY_B > 1)
		begin
			logic [DATA_WIDTH-1:0]	l_doutb[READ_LATENCY_B-1];
			always@(posedge i_clkb)
			begin
			 	l_doutb[0]		<=	i_doutb;
			end
			for(l=1;l<READ_LATENCY_B;l=l+1'b1)
			begin
				always_ff@(posedge i_clkb)
				begin
					l_doutb[l]	<=	l_doutb[l-1];
				end
			end
			assign 	o_doutb	=	l_doutb[READ_LATENCY_B-2];
		end
		else assign o_doutb	=	i_doutb;
	endgenerate
	
endmodule

`endif
