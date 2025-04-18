/// write monitor which going to capture all the values from the interface and feed the reference model as a input
import dual_package::*; 

class monitor;
  
  transaction t3,t4,t5,t6;    //transaction handle 
  mailbox #(transaction)m2s;  //mailbox from write monitor to reference model
  mailbox #(transaction)m2r;
  
  virtual inf in;                //declaration of virtual interface for both ports  
 
  bit tempwen;
  bit[$clog2(ADDRESS_DEPTH)-1:0]addr;  
  bit[DATA_WIDTH-1:0]din;
  bit[DATA_WIDTH-1:0]d_out;
  int l;
 

  reference_model rf;
   
  covergroup ram_gr;
    coverpoint t6.i_din{
      bins a0_a49={[0:49]};
      bins a50_a100={[50:100]};
      bins a101_150={[101:150]};
      bins a151_a200={[151:200]};          // coverage for port A input
      bins a200_a255={[201:255]};}
    
    
    coverpoint t6.i_addr{
      bins adda0_10={[0:10]};
      bins adda11_20={[11:20]};               //coverage for port A address
      bins adda21_31={[21:31]};}

    crossing: cross t6.i_din,t6.i_addr; 
  endgroup
  
 
  task start(); 
    fork
      begin
        @(in.imon);
        forever                  //monitoring logic for port A
        begin
          t3=new();
	  t4=new();
          t5=new();
          t6=new();
          monitoring();
          count++;
        end
      end      
    join_none
  endtask
  
  function new();
    ram_gr=new();
  endfunction

  task monitoring();
    @(in.imon); 
    if(in.imon.i_en&&!in.imon.i_we)
    begin
      #1;
      check(rf.mem[in.imon.i_addr]);  
      no_read++;  
    end 
    t6.i_addr=in.w_addr;
    t6.i_din=in.w_din;
    t6.o_dout=in.r_dout;
    ram_gr.sample();
    
    if(in.w_en&&in.w_we)
    begin
      t3.transactions=dual_package::write;
      t3.i_addr=in.w_addr;  //capturing values from interface for port A
      t3.i_din=in.w_din;
      //t3.display(l);
      //$display($time);
      m2r.put(t3);
      no_write++;
        
    end
    
       
  endtask

  task check(input bit[DATA_WIDTH-1:0] k);
    fork
      begin
        $display("captured",k);
        repeat(READ_LATENCY[l])begin
          @(in.imon);
        end
        t4.o_dout=in.imon.o_dout;
        m2s.put(t4);
        t5.transactions=read;
        t5.o_dout=k;
        m2r.put(t5);
      end
    join_none
  endtask
  
endclass
