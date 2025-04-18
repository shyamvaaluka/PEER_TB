////////////////////////////////////////////////////////////////////////////////////
//  File name        : top.sv                                                     //
//                                                                                //
//                                                                                //
//  File Description : This is the top module which controls the overall          //
//                     latency and banking features with all the test bench       // 
//                     components and design units instantiated within this       //
//                     module.                                                    //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////

//Importing pkg_2 which consists of all the parameters that are required for
//adjusting data width, address width, latency values of read and write etc.
import pkg_2::*;
//Here we include all the design units and interface that are to be compiled 
//and verified using `include directive.
`include "./rtl/latency.sv"
`include "./rtl/dual_port_ram.sv"
`include "./rtl/address_decode.sv"
`include "./rtl/multi_bank.sv"
`include "interface.sv"
//Imporitng the package class which consists of all the test bench component
//files that are included within the package class using `include directive.
import pkg::*;

//This is the top module which consists of clock generation, design top
//instantiation to the test bench and creating object for test class which
//controls all the other test bench components in hierarchy.
module top;
  //Declaring clock inputs for port-a and port-b.
	bit clka,clkb;

  //Using always block we generate the clock for 5ns and 10ns time periods for
  //port-a and port-b respectively. And this is done till the coverage of read
  //and write for both ports cover 100%. 
	always #5 clka=~clka;
	always #10 clkb=~clkb;	

	//Instantiating the top module of latency and banking feature to the test bench
  //interface using pass by name method.
  multi_bank#( .DATA_WIDTH(DATA_WIDTH),
               .ADDR_WIDTH(ADDR_WIDTH),
               .WRITE_LATENCY_A(WR_LATENCYA),
               .WRITE_LATENCY_B(WR_LATENCYB),
               .READ_LATENCY_A(RD_LATENCYA),
               .READ_LATENCY_B(RD_LATENCYB)
               )DUT(  .i_clka(in0.clka),
			 						    .i_clkb(in0.clkb),
									    .i_ena(in0.i_ena),
									    .i_enb(in0.i_enb),
									    .i_wea(in0.i_wea),
									    .i_web(in0.i_web),
									    .i_dina(in0.i_dina),
									    .i_dinb(in0.i_dinb),
									    .i_addra(in0.i_addra),
									    .i_addrb(in0.i_addrb),
									    .o_douta(in0.o_douta),
									    .o_doutb(in0.o_doutb));


  //Instantiating the clock inputs of the testbench top to the interface clock
  //so that the stimulus is synchronized to the testbench top clock of both
  //the ports. 
  dual_iff in0( .clka(clka),
      				  .clkb(clkb));

  //Here we declare handle for test class. 
  dual_test test_h;

  //In this block we are creating object for test class and passing all the
  //static interfaces from top module to the environment.
  initial
  begin
    //Creating object using new() keyword and passing all the static
    //interfaces to the environment which are later converted to virtual and
    //are used by drivers and monitors of both the ports.
    test_h=new(in0,in0,in0,in0);
    //We call the run method in the test class to initiate all the start
    //methods of all test bench components. 
    test_h.run();
  end
   
endmodule
