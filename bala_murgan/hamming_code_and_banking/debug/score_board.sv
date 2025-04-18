

//scorebord which going to compare the output from design and output from our reference model..
import dual_package::*;

class scoreboard;
  transaction t1,t3;   //transaction handles
  
  mailbox #(transaction)r2s;
  mailbox #(transaction)m2s;  //mailbox from reference model to score board for both ports
  int l;                            //mailbox from read monitor  to score board for both ports
  
 
  task start();
    fork
      begin
        forever
        begin
          m2s.get(t3);
          r2s.get(t1);      
          t3.compare(t1,l);
        end
      end
    join_none
  endtask
  
endclass
