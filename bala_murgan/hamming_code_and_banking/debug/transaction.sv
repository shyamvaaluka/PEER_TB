import dual_package::*; 

 
class transaction;
  rand bit[DATA_WIDTH-1:0]i_din;
  randc bit[$clog2(ADDRESS_DEPTH)-1:0]i_addr;
  rand  trans transactions ;
  bit [DATA_WIDTH-1:0]o_dout;

  function display(int l);
    $display("i_din_port->%d....",l,i_din);
    $display("i_addr_port->%d....",l,i_addr); 
    $display("o_dout_port->%d.....",l,o_dout);
  endfunction
  
  function compare(transaction t1,int l);
    if(this.o_dout==t1.o_dout)
    begin
      $display("test passed port->%d.....",l,this.o_dout,"...",t1.o_dout,$time);
      no_succ++;
      return 1;
    end
    else
    begin
      $display("test failed port->%d.....",l,this.o_dout,".........................",t1.o_dout,$time);
      no_fail++;
      return 0;
    end
  endfunction
  
  function report();
    $display("------------------------------------R E P O R T-------------------------------------------");
    $display("no_of_write_transaction==",no_write);
    $display("no_of_read_transaction==",no_read);
    $display("no_of_succeed_transaction==",no_succ);
    $display("no_of_failed_transaction==",no_fail);
    $display("no_of_total_transaction==",no_trans);
     $display("-----------------------------------------------------------------------------------------");
  endfunction

endclass