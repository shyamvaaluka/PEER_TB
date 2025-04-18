
//reference model is a miniature of DUT which produce output to verify a design
import dual_package::*; 

class reference_model;
  
  transaction t1,t2;              //transaction handles
  
  mailbox #(transaction) m2r;
  mailbox #(transaction) r2s;      //mailbox from reference model to scoreboard
                    // declaration virtual interface
  int l;
  
  static reg [DATA_WIDTH-1:0]mem[ADDRESS_DEPTH-1:0];            //memory element for referene model

  
  task start();
    fork
      begin
        forever
        begin
          m2r.get(t1);
          refs(t1);                          //call task to create a output 
        end
      end
    join_none
  endtask
  
  task refs(transaction t1);
    if(t1.transactions==write) 
    begin
      mem[t1.i_addr]<=t1.i_din;
     // $display(t1.i_addr,"==",t1.i_din,$time);
    end
    else 
    begin
      r2s.put(t1);
    end
  endtask

  
endclass
