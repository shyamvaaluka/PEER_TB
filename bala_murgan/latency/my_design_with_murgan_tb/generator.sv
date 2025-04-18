      
//generator which going to generate all randomized signal which is present in transaction handle
import dual_package::*; 

class generator;
  
  transaction t1,t3;             //transaction handles
  
  task randd(output transaction t2,input int l = -1);
    if(l==0)
    begin
      t1=new();
      assert(t1.randomize()with{i_addr%2==0;});                      //randomization logic
      t2=new t1;
    end
    if(l==1)
    begin
      t3=new();
      t3.randomize()with{i_addr%2!=0;};                      //randomization logic
      t2=new t3;
    end
  endtask

endclass

