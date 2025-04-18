/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_ref.sv
//	description			:	This class consists the functionality of dual port ram memory which simply does write and read operation when the data has been
//										recieved monitor and it is also having the same logic for other port as well.
//										
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_REF_SV
`define RAM_REF_SV

class ram_ref;
	
	//Mailbox's declaration for communication between reference model and scoreboard and between the monitor and the reference model.
	mailbox #(ram_trans)	mon2rm;
	mailbox #(ram_trans)	rm2sb;
	
	//Declaring the ram transaction handles for the for collecting the write data and while perfroming an write operation.
	ram_trans	mon_data;
	ram_trans rm_pkt;

	//Virtual Memory Declaration for the Memory Controller.
	static logic [D_W-1:0] ref_mem[2**A_W];

	//Function new() declaration.
	extern function new(	mailbox #(ram_trans)	mon2rm,
												mailbox #(ram_trans)	rm2sb);

	//task start() declaration.
	extern task start;

	//wr_or_rd task task declaration.
	extern local task wr_or_rd();

endclass : ram_ref

//Function new() : This function will be called while creating an object for the handle and during the time virtual interface will be get from the
//environment. Also the mailbox info will alse be obtained during the same time as before.
function ram_ref::new(	mailbox #(ram_trans)	mon2rm,
												mailbox #(ram_trans)	rm2sb);
	this.mon2rm	=	mon2rm;
	this.rm2sb	=	rm2sb;
endfunction : new

//Task : start : This task will initiates the wr_or_rd task for each port and continuosly waits for the data from the monitor and serves the memory
//once a packet is recieved from mailbox.
task ram_ref::start;
fork
	forever wr_or_rd();
join_none
endtask : start

//Task : wr_or_rd : This task will wait for the data to recieved from the monitor and once it recieves the data then according to the recieved data
//write or read will be happened to or from the reference memory.
task ram_ref::wr_or_rd();
	mon2rm.get(mon_data);
	if(mon_data.trans == READ)
	begin
		rm_pkt			=	mon_data.copy();
		rm_pkt.dout	=	ref_mem[rm_pkt.addr];
	end
	else if(mon_data.trans == WRITE)
	begin
		ref_mem[mon_data.addr]	=	mon_data.din;
		mon_data.fdisplay($sformatf("ref_mem	=	%p",ref_mem));
	end
endtask :wr_or_rd

`endif	//RAM_REF_SV
