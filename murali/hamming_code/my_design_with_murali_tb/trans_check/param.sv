/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: param.sv
//	description			:	These parameters are define the address and data width of the memory controller and these parameters can be accessed globally.
//										Since all the parameters are incuded into this package file and imported in the test bench top module. Also this method will
//										reduce the difficulty of changing the parameter's vaue by manually entering into all files and changing the values, instead just
//										by changing value in this file the change will be visible to all the remaining files including the top file, since it is
//										imported in the testbench top module.
//										
//	parametrs used	:	D_W								-> This is parameter is used to define the data width of original data in the memory controller. 
//										A_W								-> This is parameter is used to define the address width of each location in the memory controller.
//										W_LAT[<0/1>]			-> This is parameter is used to define the write latency of port[<a/b>] for te memory controller write operation.
//										R_LAT[<0/1>]			-> This is parameter is used to define the read latency for port[<a/b>] read operation using memory controller.
//										CLK_PERIOD[<0/1>]	-> This is parameter is used to define the clock period for the port[<a/b>].
// 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef PARAM_SV
`define PARAM_SV

package param;
	
	//Parameters defined to use in the design and tb files.
	parameter	int D_W						=	32;
	parameter	int A_W						=	2;
	parameter	int W_LAT			[2]	=	{4,4};
	parameter	int R_LAT			[2]	=	{5,5};
	parameter	int CLK_PERIOD[2]	=	{10,20};

	//These enum variables are declared to increase the readbilty and to easily indentify the type of operation being performed and these can be
	//accessed globally.
	typedef enum logic 				{PORTA,PORTB} 						port;
	typedef enum logic 	[1:0]	{NONE = 0,READ = 2,WRITE}	trans_type;
	typedef enum logic	[1:0] {ZERO,ONE,TWO}						error_type;
	typedef	enum logic 				{EN_DEASSERT,EN_ASSERT}		en_type;
	typedef	enum logic 				{WR,RD}										we_type;


endpackage : param

`endif	//PARAM_SV
