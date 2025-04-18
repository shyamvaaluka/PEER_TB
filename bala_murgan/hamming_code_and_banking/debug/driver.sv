import dual_package::*; 
//write driver which going to drive all the data to the interface///

class driver;
  transaction t1,t2;//handles for the transaction
  
  virtual inf in;  //virtual interface declaration for both ports;
 
  generator g1;
  int l;
 
  task start();           
    fork
      begin
        @(in.idrv);
        for(int i=0;i<no_trans;i++)
        begin
          g1.randd(t1,l);
          drive(t1);             //trigger the event and drive the data for port    
        end
      end
    join_none
  endtask

  task drive(transaction t3);
    if(t3.transactions==write)
    begin
      in.idrv.i_en<=1;
      in.idrv.i_we<=1;
    end
    if(t3.transactions==read)
    begin
      in.idrv.i_en<=1;
      in.idrv.i_we<=0;
    end
    if(t3.transactions==none)
    begin
      in.idrv.i_en<=0;
      in.idrv.i_we<=0;
    end
      in.idrv.i_addr<=t3.i_addr;        // driving all the inputs to the interface
      in.idrv.i_din<=t3.i_din;
    @(in.idrv);
  endtask

endclass
