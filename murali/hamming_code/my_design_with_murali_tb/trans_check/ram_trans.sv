/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_trans.sv
//	description			:	This class consists the proporties which are used accross the test bench environment and whenever a methods like copy, compare
//										or displaying the data we can use this methods. These class contains the properties which are corresponding to one port of a
//										dual port ram.
//										
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// */

`ifndef RAM_TRANS_SV
`define RAM_TRANS_SV

import param::*;
class ram_trans;
	
	//Variable declarations for the storing the data while communicating between the test bench compononents and while driving and monitoring the
	//stimulus to and from the dut respectively.
	rand 	trans_type 			trans;
	rand 	logic [A_W-1:0] addr;
	rand 	logic [D_W-1:0]	din;
				logic [D_W-1:0] dout;
				bit		[1		:0]	error;
  
  localparam  Q_SIZE  = (W_LAT[PORTA]>W_LAT[PORTB])?(W_LAT[PORTA]):(W_LAT[PORTB]);
  static  bit [D_W-1:0] addr_q[$];
  static  int count; 
  
  constraint ADDR_CONST{solve trans before addr;if(trans == WRITE)  !(addr inside {addr_q});}
  //constraint ADDR{trans == WRITE;}
	
	//This static variable is used to store the file descriptor value generated in the top module. Since it is an static variable only one memory will
	//be there for all the variables across all the objects of type ram_trans. Which will be used to store all the displaying into an external file.
	static int fd;

	//function dispf() declaration.
	extern function void dispf(input string msg = "");

	//function compare() declaration.
	extern function bit compare(ram_trans transaction,output string msg);

	//function copy() declaration.
	extern function ram_trans copy;

	//Function fdisplay() declaration.
	extern function void fdisplay(input string msg);

  //Function post_randomize() declaration.
  extern function void post_randomize();

endclass : ram_trans

//Function : dispf : This task takes the string as an input argument and the it will displays the time, the argument string and the all the
//properties in the task.
function void ram_trans::dispf(input string msg = "");
	$fdisplay(fd,"==============================================");
	$fdisplay(fd,"%s",msg);
	$fdisplay(fd,"at time : %0tns",$time);
	$fdisplay(fd,"trans_type	=	%s",trans.name);
	$fdisplay(fd,"addr				=	%b",addr);
	$fdisplay(fd,"din					=	%h",din);
	$fdisplay(fd,"------------------- output -------------------");
	$fdisplay(fd,"dout				=	%b",dout);
	$fdisplay(fd,"==============================================");
endfunction : dispf
	
//Function : compare : This function contians the comparison logic and whenver any data mismatch happens immediately the function will return value
//0(zero) and an string with info which property gets mismatched. If all the comparison's are success then it will return an value 1 with success
//msg as an string value.
function bit ram_trans::compare(ram_trans transaction,output string msg);
	compare =	1'b1;
	if(transaction.error == TWO)
	begin
		msg	=	"2BIT ERROR SCNEARIO OCCURED";
		this.fdisplay("=============================================");
		transaction.dispf(msg);
		this.dispf(msg);
		this.fdisplay("=============================================");
		return 1'b1;
	end
	if(this.trans != transaction.trans)
	begin
		msg = "trans Mismatch";
		return 1'b0;
	end
	if(this.addr != transaction.addr)
	begin
		msg = "Address Mismatch";
		return 1'b0;
	end
	if(this.din	!= transaction.din)
	begin
		msg = "Data In Mismatch";
		return 1'b0;
	end
	if(this.dout != transaction.dout)
	begin
		msg	=	"Data Out Mismatch";
		return 1'b0;
	end
	msg	=	"Data Comparison Successful...";
endfunction : compare

//Function : copy : This copy method creates the memory for the type ram_trans with a name copy and assigns all the data to this copy object and
//while calling this task we just want to assign that task calling statement to the handle to which we need to copy the data.
function ram_trans ram_trans::copy;
	copy			=	new();
	copy.trans=	this.trans;
	copy.addr	=	this.addr;
	copy.din	=	this.din;
endfunction :  copy

//Function : fdisplay : This function does the simple display task but it intakes an argument add some prefix kind of things, like time info and
//then it does the $fdisplay to get all these display statements into an external file.
function void ram_trans::fdisplay(input string msg);
	$fdisplay(fd,"at time: %0t : %s",$time,msg);
endfunction : fdisplay

//Function  : post_randomize  : 
function void ram_trans::post_randomize();
  count++;
  if(count >= Q_SIZE) void'(addr_q.pop_back());
  if(trans  == WRITE)
  begin
    addr_q.push_front(addr);
  end
endfunction : post_randomize

`endif	//RAM_TRANS_SV
