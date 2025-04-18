
//packages which containt all the components

package dual_package;

  int no_trans=950; //no of time randomize
  
  parameter int WRITE_LATENCY[2]={4,5};
  parameter int READ_LATENCY[2]={4,5};
  parameter int DATA_WIDTH=8,ADDRESS_DEPTH=32; 
  parameter int CLK_FREQ[2]={5,5};
  
  int no_read;
  int no_write;
  int no_succ;
  int no_fail;
  int count;
  
   typedef enum{read,write,none}trans;
  
  
  `include "transaction.sv"
  `include "generator.sv"
  `include "driver.sv"
  `include "reference_model.sv" 
  `include "monitor.sv" 
  `include "score_board.sv"
  `include "environment.sv"
  `include "test.sv"
  
endpackage
