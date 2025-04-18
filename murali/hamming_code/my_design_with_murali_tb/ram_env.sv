/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_env.sv
//	description			:	This class consists the environment of the system verilog test bench components and it will devolops that environment and
//										establishes the communication between them. Then, it will intiates all the starts and wait for specific events to trigger.
//										
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_ENV_SV
`define RAM_ENV_SV

class ram_env;
	
	//Virtual Interface declaration for establishing the connection between the dut and the test bench.
	virtual ram_if.drv_mp drv_if[2];
	virtual ram_if.mon_mp mon_if[2];
	
	//Generator class handle declaration.
	ram_gen genh[2];
	
	//Driver class handle declaration.
	ram_drv	drvh[2];

	//Monitor class handle declaration.
	ram_mon monh[2];

	//Reference model class handle declaration.
	ram_ref refh[2];

	//Scoreboard class handle declaration.
	ram_sb	sbh;

	//Mailbox's declaration for establishing communication between the monitor,scoreboard, and reference model.
	mailbox	#(ram_trans)	mon2sb	[2];
	mailbox #(ram_trans)	mon2rm	[2];
	mailbox #(ram_trans)	rm2sb		[2];

	//Function new() declaration.
	extern function new(	virtual ram_if.drv_mp drv_if[2],
												virtual ram_if.mon_mp mon_if[2]);
	
	//task build declaration.
	extern task build;

	//task start declaration.
	extern local task start;

	//task stop declaration.
	extern local task stop;

	//task build_and_run declaration.
	extern task run;

endclass : ram_env

//function : new() : This function will be called whenever an object is created for the environment and it will have arguments that intakes the
//interface info of both the ports for the driver and monitor as well.
function ram_env::new(	virtual ram_if.drv_mp drv_if[2],
												virtual ram_if.mon_mp mon_if[2]);
	foreach(drv_if[i])
	begin
		this.drv_if[i]	=	drv_if[i];
		this.mon_if[i]	=	mon_if[i];
	end
endfunction : new

//Task : build : This will create objects for all the handles and for the mailboxes as well and then the conncection between components will also be
//happened. Same mailbox will be provided to classes which requires a communication, and so one will put the data into it and other will get the data
//from the mailbox. And the created generator and reference model handles are assigned to handles of the same type present in the driver and the
//scoreboard as well.
task ram_env::build;
	foreach(mon2sb[i])
	begin
		mon2sb 		[i] =	new();
		mon2rm 		[i] =	new();
		rm2sb	 		[i] =	new();
		genh	 		[i]	=	new();
		drvh	 		[i]	=	new(drv_if[i]);
		drvh[i].genh	=	genh[i];
		monh			[i]	=	new(mon_if[i],mon2rm[i],mon2sb[i],i);
		refh			[i]	=	new(mon2rm[i],rm2sb[i]);
		monh[i].refh	= refh[i];
	end
	sbh				=	new(mon2sb,rm2sb);
endtask : build

//Task : start : This task will initiates the each of the start task present in every compononent. And since the body of each task is between the
//fork - join_none all task calls will be happened one after the other immediately.
task ram_env::start;
	foreach(drvh[i])
	begin
		drvh[i].start;
		monh[i].start;
		refh[i].start;
	end
	sbh.start;
endtask : start

//Task : stop : This task will be used to trigger the events in the scoreboard and once the done is triggered for both the ports the stop task will be
//finished and the statements after to this stop will be executed.
task ram_env::stop;
	wait(sbh.done.triggered);
endtask : stop

//Task : run : This task will start and stop one after the other.This will be get called from test, once the environment object is created and
//environmnet build task is completed.
task ram_env::run;
	start;
	stop;
  sbh.report();
endtask : run
	
`endif	//RAM_ENV_SV
