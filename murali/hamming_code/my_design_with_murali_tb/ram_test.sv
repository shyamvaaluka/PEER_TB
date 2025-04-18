/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_test.sv
//	description			:	This class consists the environment handle and it gets the interface for the both the port from the top module. This class
//										contains a task that creates an object for the environment class by neccessary interface info and then it calls the
//										build_and_run method present in the environment and waits for the completion of that task.
//										
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_TEST_SV
`define RAM_TEST_SV

class ram_test;
	
	//Virtual Interface declaration for storing the interface info recieved while an object is created for this task, and pass this info to
	//environment's new function as argument while creating an object for it.
	virtual ram_if.drv_mp drv_if[2];
	virtual ram_if.mon_mp mon_if[2];
	
	//Environment Handle Declaration.
	ram_env envh;

	//Function new() declaration.
	extern function new(	virtual ram_if.drv_mp drv_if[2],
												virtual ram_if.mon_mp mon_if[2]);

	//task run_test() declaration.
	extern task run_test;
	
	//task build() declaration.
	extern task build;

endclass : ram_test

//Function : new() : While creating an for this class this function need to be called by providing necessary arguments and this function new() call
//happens for this test class from the top module.
function ram_test::new(	virtual ram_if.drv_mp drv_if[2],
												virtual ram_if.mon_mp mon_if[2]);
	foreach(drv_if[i])
	begin
		this.drv_if[i]	=	drv_if[i];
		this.mon_if[i]	= mon_if[i];
	end
endfunction : new

//Task : build : This task will create the environment with all the connection's between each components.
task ram_test::build;
	envh	=	new(drv_if,mon_if);
	envh.build();
endtask : build

//Task : run_test : This task will create the environment object by providing the interface info info as an argument to the new function. And then
//the task build_and_run present in the environment will gets called using the environment handle.
task ram_test::run_test;
	envh.run();
endtask : run_test

`endif	//RAM_TEST_SV
