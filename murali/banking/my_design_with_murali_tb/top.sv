///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: top.sv
//	description			:	This module consists the entire functionality of the memeory controller and the system verilog test bench environment for the
//										memory controller. It will instantiate the memory controller design and connectes it to the system verilog testbench through the
//										interface designed for the memory controller. All the packages are inculuded and imported into the design, the packges which
//										also contains the system verilog test bench components in an hierarchial way.
//	
//	parametrs used	:	All the paramters are imported from an param.sv package file.	
//
//	Input Ports			:	en,we,addr,din
//
//	Output Ports		:	dout,error
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef TOP_TB_SV
`define TOP_TB_SV

//Including and importing of the paramters package(param.sv) into the top file.
`include "param.sv"
import param::*;

//The below statement includes the memory controller interface in to this top design module.
`include "ram_if.sv"

//The below statements includes and imports the ram_pkg.sv file which includes all the sv test bench components.
`include "ram_pkg.sv"
import ram_pkg::*;

//The below statements include the scoreboard, environment and the test class in to this top module.
`include "ram_sb.sv"
`include "ram_env.sv"
`include "ram_test.sv"

module top;
	
	//Declaration of clock as an array for both the ports.
	bit clk[2];
	
	//Instantiating the interfaces for the ports by providing the neccessary arguments to each instantiation.
	ram_if	intf0(clk[PORTA],PORTA);
	ram_if	intf1(clk[PORTB],PORTB);
	
	//Memeory Controller Instantiation
	MEMORY_TOP #(	.WR_LATENCYA(W_LAT[PORTA]),
								.WR_LATENCYB(W_LAT[PORTB]),
								.RD_LATENCYA(R_LAT[PORTA]),
								.RD_LATENCYB(R_LAT[PORTB]),
								.DATA_A(D_W),
								.ADDR_A(A_W)
					  	)	
							dut	
							(
								.i_data_in_a(intf0.din),
								.i_data_in_b(intf1.din),
								.i_addra(intf0.addr),
								.i_addrb(intf1.addr),
								.clka(intf0.clk),
								.clkb(intf1.clk),
                .i_ena(intf0.en),
								.i_enb(intf1.en),
                .i_wea(intf0.we),
								.i_web(intf1.we),
								`ifdef ECC
								.o_errora(intf0.error),
								.o_errorb(intf1.error),
								`endif
                .o_dout_a(intf0.dout),
								.o_dout_b(intf1.dout)
							);

	//This initial block will contains the logic for the clock generation for both of the ports.
	initial
	fork
		begin
			clk[0]	=	1'b1;
			forever #(CLK_PERIOD[PORTA]/2)	clk[0] = ~clk[0];
		end
		begin
			forever #(CLK_PERIOD[PORTB]/2)	clk[1] = ~clk[1];
		end
	join_none
	
	//Test handle declaration : Which constists the further system verilog test bench envrionment as hierarchy in it.
	ram_test testh;

	//Transaction handle declaration : Used to assign the value to the static variable for some purpose discussed in the below parts.
	ram_trans	transh;

	//This initial does the following intiations in the memeory_controller test bench.
	//File Decsiptor Value Intialization : Since the static variables can be access with out creating an object for the class, so assigning the file
	//descriptor value to that variable(which will be shared across all the objects of type ram_trans).
	initial begin
		transh.fd	=	$fopen("port_a.log","w");
		testh	=	new('{intf0,intf1},'{intf0,intf1});	//Calling the new() function of test with interfaces instances as an arguments to them.
		testh.build;																//Calling the build task to create entire environment infrastucture.
		testh.run_test;															//Calling the task run_test using test handle.
		@(negedge clk[1]);
		$finish;
	end

	`ifdef ECC
	`ifdef ERROR_INJECT
	//This always block is used to identify the write operation at both the ports and whever an write is captured at any one of the port inject error
	//task will get's called by providing an port as an argument.
	always_comb
	begin
		if(intf0.en && intf0.we)	inject_error(PORTA);
		if(intf1.en && intf1.we)	inject_error(PORTB);
	end

	//Inject_Error task is used to call the error inject task in the dut while an write operation is captured, it waits for an WRITE_LATENCY_A-1 clock
	//cycles to inject the error into the write data in case of PORTA, and for PORTB it will injects the error after WRITE_LATENCY_B-1 clock cycles.
	task automatic inject_error(input logic port);
	fork
		begin
			dut.error_inject(port);
		end
	join_none
	endtask
	`endif
	`endif

	//This initial block enusres that if the test bench is stuck with getting an sufficient coverage then after a certain time the simulation will be
	//ended from this block.
	initial begin
		#(200000*CLK_PERIOD[1]);
		$display("Simulation Ended Without Covering the 100%% Coverage");
		$finish;
	end

	//This final block will close the file descriptor once the finish has been called.
	final begin
		testh.envh.sbh.report;
		$fclose(transh.fd);
	end
	
	//This concurrent assertion is used to verify whether the dut is performing the read as like an reference model or not. The assertion will be start
	//whever a read data is monitored at the ports. Since there are two ports, each of the port having the seperate assertion.
	property porta_rd_check;
		@(posedge clk[0]) ((intf0.en && !intf0.we))  /*(intf0.error != 2'b10))*/ |-> ##(R_LAT[0])(intf0.dout === intf0.l_ref_dout);
	endproperty

	property portb_rd_check;
		@(posedge clk[1]) ((intf1.en && !intf1.we))  /*(intf1.error != 2'b10))*/ |-> ##(R_LAT[1])(intf1.dout === intf1.l_ref_dout);
	endproperty
	
	//Asserting the properties porta_rd_check,portb_rd_check to monitor the functionality of the multibank memory controller.
	PORTA_RD_CHECK: assert property(porta_rd_check)
										//$info("RD_CHECK ASSERION FOR PORT A is Success at %0t ns",$time);
									else $error("RD_CHECK ASSERION FOR PORT A is Failed at %0t ns",$time);
	
	PORTB_RD_CHECK: assert property(portb_rd_check)
										//$info("RD_CHECK ASSERION FOR PORT B is Success at %0t ns",$time);
									else $error("RD_CHECK ASSERION FOR PORT B is Success at %0t ns",$time);
	
endmodule :top

`endif	//TOP_TB_SV
