import dual_package::*;
 
//test it run the environment and pass interface from top to environment

class test;
  
  environment e1;  //environment declaration
  
  virtual inf in;
  virtual inf in1;
   
  function new( virtual inf in,virtual inf in1);     //constructor
    this.in=in;
    this.in1=in1;          //receiving interface from top
  endfunction
  
  task build_run();
    e1=new(in,in1);
    e1.build(); 
    e1.connect();          //run the build and run in environment
    e1.run();
  endtask

endclass
