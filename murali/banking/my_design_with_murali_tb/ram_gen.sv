/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	version					:	0.1
//	file name				: ram_gen.sv
//	description			:	This class consists the functionality of creating an object and randomizing the data whenver the method define in this class and
//										this generator class handle will also there in the driver and so whenever the driver requires the data. Simply it calls the
//										generate_data task using the handle(by providing the necessary arguments when calling an task.)
//										
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_GEN_SV
`define RAM_GEN_SV

class ram_gen;

	//task generate_data declaration.
	extern task generate_data(ref ram_trans gen_data);

endclass : ram_gen

//Task : generate_data : This task is used to generate the randomized data when task call happens, it check whether a memory is allocated or not, if
//not it will creates an object and calls the predefined randomize.
task ram_gen::generate_data(ref ram_trans gen_data);
begin
	if(gen_data == null) gen_data	=	new();
	if(!gen_data.randomize())	$display("Randomization Failed");
end
endtask : generate_data


`endif	//RAM_GEN_SV
