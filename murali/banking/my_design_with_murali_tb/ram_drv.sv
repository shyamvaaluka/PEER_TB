/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_drv.sv
//	description			:	This class consists the functionality of driving the stimulus to the design thorugh the virtual interface by generating the data
//										from the generator class. The environment will provide the virtual interface info to this module.
//										
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_DRV_SV
`define RAM_DRV_SV

class ram_drv;
	
	//Virtual Interface Instantiation for driving the generated stimulus to the dut.
	virtual  ram_if.drv_mp drv_if;
	
	//Generator Handle: The object creation will be happened in the environment and it used to access the generate_data task in it to generate the
	//randomized to drive to the dut.
	ram_gen genh;

	//These handles are used to get the generated stimulus packets.
	ram_trans	drv_pkt;

	//Function new() declaration.
	extern function new(virtual  ram_if.drv_mp drv_if);

	//task start() declaration.
	extern task start;

	//drive task declaration.
	extern local task drive();

endclass : ram_drv

//This new() function will get the interface pointers from the environment while an object is created from there, and they will be assigned to
//local interfaces defined in this class.
function ram_drv::new(virtual  ram_if.drv_mp drv_if);
	this.drv_if	=	drv_if;
endfunction : new

//This start will initiates stimulus to driving to both the ports at every positive edge of the clock.
task ram_drv::start;
fork
	forever	drive();
join_none
endtask : start

//This task will drives the data to a specified using the info an agrument names port and driving the data using non blocking assignment.
task ram_drv::drive();
	this.genh.generate_data(drv_pkt);						//calls the generate_data task using the genh and getting the randomized data.
	@(drv_if.drv_cb);
	if(drv_pkt.trans == WRITE )
	begin
		drv_if.drv_cb.en	<=	EN_ASSERT;
		drv_if.drv_cb.we	<=	WR;
	end
	else if(drv_pkt.trans == READ )
	begin
		drv_if.drv_cb.en	<=	EN_ASSERT;
		drv_if.drv_cb.we	<=	RD;
	end
	else 
	begin
		drv_if.drv_cb.en	<=	EN_DEASSERT;
		drv_if.drv_cb.we	<=	EN_DEASSERT;
	end
	drv_if.drv_cb.addr									<=	drv_pkt.addr;
	drv_if.drv_cb.din										<=	drv_pkt.din;
endtask	: drive

`endif	//RAM_DRV_SV
