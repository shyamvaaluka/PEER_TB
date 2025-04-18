
/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//   Design of Dual Port Ram
//
//   Description : its a design module for dual_port_ram which going to implement a read and write process in memory
//                 through two ports
//
// 
//
//
//      -------- Parameters declared in the Test bench -------------
//
//
//      DATA_WIDTH               =     Indicates the Data width of the one memory location 
//      DEPTH		         =     Number of locations present in the memory
//      A_R_LATENCY              =     Port - A    read latency
//      A_W_LATENCY              =     Port - A    write latency
//      B_R_LATENCY              =     Port - B    read latency
//      B_W_LATENCY              =     Port - B    write latency 

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/


module dual_port_ram #(parameter A_W_LATENCY=1,A_R_LATENCY=1,B_W_LATENCY=1,B_R_LATENCY=1,DATA_WIDTH=8,ADDRESS_DEPTH=8) (i_clka,i_clkb,i_dina,i_dinb,i_addra,i_addrb,i_ena,i_enb,i_wea,i_web,o_douta,o_doutb);

// in dual port ram we can do two different process in same time 
// so i named the two process as a and b
//
////////**********************///////////////////////////////////////*****************************//////////////////
//also there is extra three signal to inject error                                                                //
//if you are verify it without error injection then make sure put the last three terminal as a "0" in test bench  //
//                                                                                                                //
//****************************///////////////////////////*********************////////////////////****************//


  input				     	i_clka, //clk for A process
					i_clkb, //clk for B process		
					i_ena,	//enable for A process
					i_enb,	//enable for B process
					i_wea, 	//write enable for A Process
					i_web;	//write enable for B process
  input   [DATA_WIDTH-1:0]		i_dina;	//data_in for A process
  input   [DATA_WIDTH-1:0]		i_dinb; //data_in for B process
  input	  [$clog2(ADDRESS_DEPTH)-1:0]	i_addra;//address for A process
  input	  [$clog2(ADDRESS_DEPTH)-1:0]	i_addrb;//address for B process
  output  [DATA_WIDTH-1:0]		o_douta;//data out for A process
  output  [DATA_WIDTH-1:0]		o_doutb;//data out for B process
  
  
 
 
	
  wire	  [DATA_WIDTH-1:0] 		latency_wa,latency_wb;   //to pass the input with latency
	
  reg	  [DATA_WIDTH-1:0]		latency_ra,latency_rb;  //collect the output and add latency 
	
  wire	                 		latency_wea,latency_web; //add latency to enable
	
  wire	  [$clog2(ADDRESS_DEPTH)-1:0] 	latency_addra,latency_addrb; // add latency to address
	
  wire 					latency_ena,latency_enb;    //add latency to enable
	
  reg	  [DATA_WIDTH-1:0]              mem    [ADDRESS_DEPTH-1:0];   //memory declaration

  
    

  always@(posedge i_clka)
  begin
    if(latency_ena)				//write and read process for process A..
    begin
      if(latency_wea)
        mem[latency_addra] <= latency_wa;
    end
    if(i_ena)
    begin
      if(i_wea == 1'b0)
        latency_ra <= mem[i_addra];
    end
  end


  always@(posedge i_clkb)
  begin
    if(latency_enb)				//write and read process for process B ..
    begin
      if(latency_web)
	  mem[latency_addrb] <= latency_wb;
      end
    if(i_enb)
    begin
      if(i_web == 1'b0)
        latency_rb <= mem[i_addrb];
    end
    
  end
	
  generate 
   latency #(DATA_WIDTH,A_W_LATENCY)  write_dataA  (i_clka,i_dina,latency_wa);    		//latency for input data 
		
   latency #(DATA_WIDTH,A_R_LATENCY)  read_dataA   (i_clka,latency_ra,o_douta);  		// latency for output data
		
   latency #(DATA_WIDTH,B_W_LATENCY)  write_dataB  (i_clkb,i_dinb,latency_wb);		// latency for input data
		
   latency #(DATA_WIDTH,B_R_LATENCY)  read_dataB   (i_clkb,latency_rb,o_doutb);		// latency for output data
		
   latency #(1'd1,A_W_LATENCY)        w_enableA    (i_clka,i_wea,latency_wea);		// latency for wite enable data
		
   latency #(1'd1,B_W_LATENCY)        w_enableB    (i_clkb,i_web,latency_web);		// latency for write enable data
		
   latency #(DATA_WIDTH,A_W_LATENCY)  addressA     (i_clka,i_addra,latency_addra);		// latency for address data
		
   latency #(DATA_WIDTH,B_W_LATENCY)  addressB     (i_clkb,i_addrb,latency_addrb);		// latency for address data
		
   latency #(1'd1,A_W_LATENCY)        enableA      (i_clka,i_ena,latency_ena);		// latency for enable signal

   latency #(1'd1,B_W_LATENCY)        enableB      (i_clkb,i_enb,latency_enb);		// latency for enable signal
  endgenerate


	
endmodule

// using for shift register we achieve the latency for the signal

module latency #(parameter DATA_WIDTHS = 8,DELAY = 3)(input clk,[DATA_WIDTHS-1:0]in,output [DATA_WIDTHS-1:0]out);      
  reg [DATA_WIDTHS-1:0] s_register[DELAY:0];        //internal register
  				
  
  generate						//we use generate block to avoid of running loop with one latency
    if(DELAY > 1)
    begin
      always@(posedge clk)
      begin
        if(DELAY > 1'd1)
	begin
	  s_register[0] <= in;
	  for(int i=1'd1;i<=DELAY;i=i+1'd1)         //using for loop we give the delay to the respected signals
	  begin
	    s_register[i] <= s_register[i-1];
	  end		
	end
      end
      assign out = s_register[DELAY-2];	//assigning the output
    end
    else
	assign out = in;	//assigs_registerng the output 
  endgenerate
endmodule	
			
