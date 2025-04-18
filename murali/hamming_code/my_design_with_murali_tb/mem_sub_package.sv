//      -------- Parameters declared in the Design -------------
//
//       D_W                        =     Indicates the Data width of the one memory location 
//       R_LTY                      =     read latency
//       W_LTY                      =     write latency
//       CLK_A_HALFCYCLE_PERIOD     =     port-a half cycle period
//       CLK_B_HALFCYCLE_PERIOD     =     port-b half cycle period
//
////////////////////////////////////////////////////////////////////////////


package mem_sub_package;

   parameter      D_W                    = 32,
                  A_W                    = 10,
                  RANDOM_TEST_CASES      = 10,
                  R_LTY 	         = 1,
                  W_LTY 	         = 1,
                  CLK_A_HALFCYCLE_PERIOD = 4,
                  CLK_B_HALFCYCLE_PERIOD = 5;



   typedef enum  bit       { PORT_A , PORT_B }        Port_Indicator; // port type indicator
   typedef enum  bit [1:0] { NO_OP , WRITE , READ }   op_type;        // operation type indicator


endpackage
