/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_sb.sv
//	description			:	This class consists the functionality of getting the packets from the reference model and scoreboard, then comparing the packets
//										whether they are equal or not. Also it does necessary count variables incrementation upon comparison status.
//										
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_SB_SV
`define RAM_SB_SV

class ram_sb;
	
	//Mailbox's declaration for communication between reference model and scoreboard and between the monitor and scoreboard as well.
	mailbox #(ram_trans)	mon2sb[2];
	mailbox #(ram_trans) 	rm2sb	[2];
	
	//These events are used trigger when an 100% functional coverage has been reached, so that the threads that are waiting for the triggering of this
	//will be continued to the next process.
	event done;

	//These events are used to sample the covergroup while an read operation is performed and instead of explicitly calling the sample method we can
	//trigger this event.
	event sample_data	[2];

	//Thse packets are used to store the packets recieved from the monitor and from the reference model as well.
	ram_trans	mon_pkt[2];
	ram_trans	ref_pkt[2];

	//Success and Failure count variables. In order to identify whether all the reads are happening in with out any error or not.
	int success_count[2]	=	'{0,0};
	int failure_count[2]	=	'{0,0};

	//2 Dimenesional array declaration to count the type of errors for each of the port.
	int error_type_count[2][3];

	//PortA Read Coverage : This covergroup will cover all the Scenarios for the Read Operation from PORTA.
	covergroup mutlibank_porta_read_cg@(sample_data[0]);
		ENA		:	coverpoint	ref_pkt[0].trans{
												 							bins READ 	= {READ};}
		ADDRA	: coverpoint	ref_pkt[0].addr;
		DOUTA	:	coverpoint	ref_pkt[0].dout{
																			bins LOW		=	{0};
																			bins LOW1		=	{1};
																			bins MIN1		=	{[2:9]};
																			bins MIN2		=	{[10:100]};
																			bins MID1		=	{[101:155]};
																			bins MID2		=	{[155:200]};
																			bins MAX		=	{[201:253]};
																			bins HIGH1	=	{254};
																			bins HIGH		=	{255};}
		ENA_X_ADDRA_DOUTA	:	cross	ENA,ADDRA,DOUTA;
	endgroup
	
	//PortB Read Coverage : This covergroup will cover all the Scenarios for the Read Operation from PORTB.
	covergroup mutlibank_portb_read_cg@(sample_data[1]);
		ENB		:	coverpoint	ref_pkt[1].trans{
																			bins READ	=	{READ};}
		ADDRB	: coverpoint	ref_pkt[1].addr;
		DOUTB	:	coverpoint	ref_pkt[1].dout{
																			bins LOW		=	{0};
																			bins LOW1		=	{1};
																			bins MIN1		=	{[2:9]};
																			bins MIN2		=	{[10:100]};
																			bins MID1		=	{[101:155]};
																			bins MID2		=	{[155:200]};
																			bins MAX		=	{[201:253]};
																			bins HIGH1	=	{254};
																			bins HIGH		=	{255};}
		ENB_X_ADDRB_DOUTB	:	cross	ENB,ADDRB,DOUTB;
	endgroup

	//Function new() declaration.
	extern function new(	mailbox #(ram_trans) mon2sb	[2],
												mailbox #(ram_trans) rm2sb	[2]);

	//task start() declaration.
	extern task start;
	
	//task start_check declaration.
	extern local task start_check(input logic port);

	//task rd_check declaration
	extern local task rd_check(input logic port);

	//Function report declaration.
	extern function void report(input logic port = PORTA);

endclass : ram_sb

//function : new() : This function will be called while creating the object for the handle for this ram_sb class and during the time the environment
//will be provide the mailbox related information to this scoreboard. And it will also create the memory for the covergroups.
function ram_sb::new(	mailbox #(ram_trans) mon2sb	[2],
											mailbox #(ram_trans) rm2sb	[2]);
	foreach(mon2sb[i])
	begin
		this.mon2sb[i]	=	mon2sb[i];
		this.rm2sb[i]		=	rm2sb[i];
		mutlibank_porta_read_cg	=	new();
		mutlibank_portb_read_cg	=	new();
	end
endfunction : new

//Task : start : This task is used to continuosly waiting for the data from the monitor and reference model as well and the waiting will also be done
//in parallel. Once the packet from the both mailbox's are recived then rd_check task is called to perform the comparison between the two, and then
//wait for an packet to recieve from the both mailbox's.
task ram_sb::start;
	start_check(PORTA);
	start_check(PORTB);
endtask	: start

task ram_sb::start_check(input logic port);
fork
	begin
		forever
		begin
			fork
				begin
					mon2sb[port].get(mon_pkt[port]);
					mon_pkt[port].dispf("Data From DUT");
				end
				begin
					rm2sb[port].get(ref_pkt[port]);
					ref_pkt[port].dispf("Data for REF");
				end
			join
			rd_check(port);
		end
	end	
join_none
endtask : start_check

//Task : rd_check : This does will perform comparison operation by calling task compare in the transaction to does the comparison between both the
//packets and it will an single bit, with producing a 1 for the successful comparison and it will return 0 with a reason for comparison failure.
//Accordingly the success and failure count will be incremented and the sample_data will be get triggered. And after that every successful comparison
//it checks for the coverage and if the coverage meets 100% then event done will be triggered and all the info related to the counts and the
//functional coverage values will be printed..
task ram_sb::rd_check(input logic port);
	string msg;
	if(!ref_pkt[port].compare(mon_pkt[port],msg))
	begin
		ref_pkt[port].fdisplay($sformatf("...Data comparison mismatch...\n%s",msg));
		ref_pkt[port].fdisplay($sformatf("%s\n Simulation ended from %m",msg));
		ref_pkt[port].dispf("Expected Data");
		mon_pkt[port].dispf("Actual Data");
		failure_count[port]++;
		#20;
		$fatal;
	end
	success_count[port]++;
	error_type_count[port][mon_pkt[port].error]++;
	->sample_data[port];
	mon_pkt[port].dispf($sformatf("SCOREBOARD: %s",msg));
	if((mutlibank_porta_read_cg.get_coverage + mutlibank_portb_read_cg.get_coverage) == 200)
	begin
		->done;
	end
endtask : rd_check

//Function : report : This function is used to display all the info about no of success and count failures, no. of zero bit,one bit and 2bit error
//occures in the design and the functional coverage for both the ports.
function void ram_sb::report(input logic port = PORTA);
	ref_pkt[port].fdisplay("=========================================================");
	ref_pkt[port].fdisplay($sformatf("PORTA FUNCTIONAL COVERAGE : %0f",mutlibank_porta_read_cg.get_coverage));
	ref_pkt[port].fdisplay($sformatf("PORTB FUNCTIONAL COVERAGE : %0f",mutlibank_portb_read_cg.get_coverage));
	ref_pkt[port].fdisplay($sformatf("success_count							=	%0d",success_count[0] + success_count[1]));
	ref_pkt[port].fdisplay($sformatf("failure_count							=	%0d",failure_count[0] + failure_count[1]));
	ref_pkt[port].fdisplay($sformatf("Zero bit error Count			=	%0d",error_type_count[0][0]+error_type_count[1][0]));
	ref_pkt[port].fdisplay($sformatf("One bit error Count				=	%0d",error_type_count[0][1]+error_type_count[1][1]));
	ref_pkt[port].fdisplay($sformatf("Two bit error Count				=	%0d",error_type_count[0][2]+error_type_count[1][2]));
	ref_pkt[port].fdisplay("=========================================================");
endfunction : report

`endif	//RAM_SB_SV
