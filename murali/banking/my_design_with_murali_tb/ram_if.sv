/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  version          :  0.1
//  file name        : ram_if.sv
//  description      :  This interface consists the set of signals connects to the single port of a memory controller. So, we will use the two interface
//                    instantiation's since we are having 2 ports for our design. Instead, we are having some additional ports to introduce the
//                    latency functionality into the reference model, such that this interface consists the logic of latency for the reference model.
//                    Apart from above, it contains clocking blocks, modports to define the direction, drive and monitor the data.
//  
//  parametrs used  :  All the paramters are imported from an param.sv package file.  
//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

`ifndef RAM_IF_SV
`define RAM_IF_SV

//The additional argument port is used to get the port number, so that the latency module will be functioned accordingly.
interface ram_if (input bit clk,input logic port);

  //Interface signal declaration for connection with the memory controller design.
  logic           en;
  logic           we;
  logic [A_W-1:0]  addr;
  logic  [D_W-1:0]  din;
  logic [D_W-1:0]  dout;
  logic [D_W-1:0]  ref_dout;
  `ifdef ECC
  logic  [1     :0]  error;
  `endif

  //Interface signal's declaration for latency model design for the reference model.
  logic            l_we;  
  logic            l_en;  
  logic  [A_W-1:0]  l_addr;
  logic  [D_W-1:0]  l_din;
  logic  [D_W-1:0]  l_ref_dout;

  //This clocking block will be used to drive the stimulus to the dut 1ns after the posedge of the clock.
  clocking drv_cb@(posedge clk);
    default input #1 output #1;
    output en;
    output we;
    output addr;
    output din;
  endclocking : drv_cb
  
  //This clocking block will be used to moitor the stimulus from the dut 1ns before to the posedge of the clock.
  clocking mon_cb@(posedge clk);
    default input #1 output #1;
    input en;
    input we;
    input addr;
    input din;
    input dout;
    `ifdef ECC
    input error;
    `endif
  endclocking : mon_cb

  //This clocking block will be used to moitor the stimulus from the dut 1ns before to the posedge of the clock.
  clocking lat_cb@(posedge clk);
    default input #1 output #1;
    input l_en;
    input l_we;
    input l_addr;
    input l_din;
    input l_ref_dout;
  endclocking : lat_cb
  
  //These modort used to access a set of signals at the required time, which also includes clock to this modport as an input.
  modport drv_mp(clocking drv_cb,input clk);
  modport mon_mp(clocking mon_cb,lat_cb,input clk,ref_dout);

  //This logic reprsents the latency functionality for the reference model of the memory controller.
  always_ff@(posedge clk)
  begin
    l_en        <=  repeat(W_LAT[port]-2)  @(posedge clk) (we)?(en):('0);
    l_we        <=  repeat(W_LAT[port]-2)   @(posedge clk)  (we)?(we):('0);  
    l_addr      <=  repeat(W_LAT[port]-2)   @(posedge clk)  (we)?(addr):('0);  
    l_din        <=  repeat(W_LAT[port]-2)   @(posedge clk)  (we)?(din):('0);
    l_ref_dout  <=  repeat(R_LAT[port]-2)   @(posedge clk)  ref_dout;
  end

endinterface : ram_if

`endif  //RAM_IF_SV
