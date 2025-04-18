import dual_package::*; 

//environment which going to create all the objects and call all the start method

class environment;
  
  mailbox #(transaction)m2ra=new();
  mailbox #(transaction)m2rb=new();       //create object for all the mailox
  mailbox #(transaction)r2sa=new();
  mailbox #(transaction)r2sb=new();
  mailbox #(transaction)m2sa=new();
  mailbox #(transaction)m2sb=new();
  
  driver da;
  driver db;
  generator g1;
  monitor ma;
  monitor mb;            // creating handles for all the components
  reference_model ra;
  reference_model rb;
  scoreboard sa;
  scoreboard sb;
  transaction t1;

  virtual inf in;
  virtual inf in1;
  
  
  function new( virtual inf in,virtual inf in1);     //constructor
    this.in=in; 
    this.in1=in1;               //receiving interface from top
  endfunction

  task build(); 
    g1=new;                   
    da=new();
    db=new();
    ma=new();
    mb=new();
    ra=new();
    rb=new();           // build method going to create object for all components
    sa=new();
    sb=new();
    t1=new();
  endtask
  
  task connect();
    da.in=in;
    da.g1=g1;
    da.l=0;
    
    db.in=in1;
    db.g1=g1;
    db.l=1;
    
    ma.m2s=m2sa;
    ma.m2r=m2ra;
    ma.in=in;
    ma.l=0;
    ma.rf=ra;
    
    mb.m2s=m2sb;
    mb.m2r=m2rb;
    mb.in=in1;
    mb.l=1;
    mb.rf=rb;
    
    ra.m2r=m2ra;
    ra.r2s=r2sa;
    ra.l=0;

    rb.m2r=m2rb;
    rb.r2s=r2sb;
    rb.l=1;

    sa.r2s=r2sa;
    sa.m2s=m2sa;
    sa.l=0;

    sb.r2s=r2sb;
    sb.m2s=m2sb;
    sb.l=1;

  endtask

  task start();
    da.start();
    db.start();
    ma.start();
    mb.start();
    ra.start();
    rb.start();           // build method going to create object for all components
    sa.start();
    sb.start();
  endtask
  
  task stop();
    wait(count==no_trans*2);             // after all transaction completed it stop the simulation
  endtask
  
  task run();
    start();
    stop();                                  // run all the program
    t1.report();
  endtask

endclass
