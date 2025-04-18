/*///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  version          :  0.1
//  file name        : ram_mon.sv
//  description      :  This class consists the functionality of monitoring stimulus from the design thorugh the virtual interface. The interface
//                    details for this class will be obtained at environment while creating the monitor object. Also this class, does some additional
//                    task that gets the read data from the reference model's memory using the reference model handle. Also it does the same for the
//                    dut data for an particular read operation in some different way discussed at the each tasks' body. It send the write data to the
//                    reference model using the mail box communication between the two.
//                    
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

`ifndef RAM_MON_SV
`define RAM_MON_SV

class ram_mon;

  //Virtual Interface Instantiation for monitoring the dut data and reference logic data.
  virtual ram_if.mon_mp mon_if;

  //reference model handle declaration which will be used while performing an read operation to have a mailbox less communication between the
  //reference model and the interface.
  ram_ref refh;

  //Mailbox's for communication between the reference model and monitor and between the scoreboard and monitor as well.
  mailbox #(ram_trans) mon2rm;
  mailbox #(ram_trans) mon2sb;

  //This Internal variable is used to get the port related info whether it is PORTA or PORTB.
  logic port;

  //Function new() declaration.
  extern function new(virtual ram_if.mon_mp mon_if,
                              mailbox #(ram_trans) mon2rm,
                              mailbox #(ram_trans) mon2sb,
                              input logic port);
  
  //task start declaration.
  extern task start;

  //task monitor declaration.
  extern local task read_monitor(input logic port);

  //task write_lat_mon declaration
  extern local task write_lat_mon();
  
  //task ref_read_monitor declaration
  extern local task ref_read_monitor(input logic port);

endclass : ram_mon

//This new() function will get the interface info from the environment right at the time while in the environment the object is creating and also it
//gets the mailbox information at the same time.
function ram_mon::new(virtual ram_if.mon_mp mon_if,
                              mailbox #(ram_trans) mon2rm,
                              mailbox #(ram_trans) mon2sb,
                              input logic port);
  this.mon_if  =  mon_if;
  this.mon2rm  =  mon2rm;
  this.mon2sb  =  mon2sb;
  this.port    =  port;
endfunction : new

//This start task will initiates all the data monitoring task's so that at every clock edge of each of the port the data will be monitored forever.
task ram_mon::start;
fork
  forever    read_monitor(port);
  forever    write_lat_mon();
  forever    ref_read_monitor(port);
join_none
endtask : start

//Task: monitor : It monitors the dut data and and it is an read operation then it collects the read data by waiting for an certain latency cycles and
//then the data packet is send to the scoreboard using the mailbox. The monitoring happened for each clock cycle at the postivie edge of the clock.
task ram_mon::read_monitor(input logic port);
  ram_trans  mon_pkt  =  new();
  @(mon_if.mon_cb);
  if((!mon_if.mon_cb.we) && (mon_if.mon_cb.en))
  begin
    mon_pkt.trans  =  READ;
    mon_pkt.addr  =  mon_if.mon_cb.addr;
    mon_pkt.din    =  mon_if.mon_cb.din;
    fork
      begin
        repeat(R_LAT[port]) @(mon_if.mon_cb);
        mon_pkt.dout  =  mon_if.mon_cb.dout;
        `ifdef ECC
        mon_pkt.error  =  mon_if.mon_cb.error;
        `endif
        mon2sb.put(mon_pkt);
        mon_pkt.dispf("MON : DATA_OUT Picked");
      end
      //mon_pkt.dispf("DATA_IN Picked");
    join_none
  end
endtask : read_monitor

//Task : write_lat_mon : It monitors the reference model's latency data and every positive edge of the clock the data will be send to the reference
//model using the mailbox communication between the reference model and the scoreboard.
task ram_mon::write_lat_mon();
  ram_trans  lat_pkt = new();
  @(mon_if.lat_cb);
  if(mon_if.lat_cb.l_en & mon_if.lat_cb.l_we)          lat_pkt.trans  =  WRITE;
  else if(mon_if.lat_cb.l_en & (!mon_if.lat_cb.l_we))  lat_pkt.trans  =  READ;
  else                                                 lat_pkt.trans  =  NONE;
  lat_pkt.addr  =  mon_if.lat_cb.l_addr;
  lat_pkt.din    =  mon_if.lat_cb.l_din;
  mon2rm.put(lat_pkt);
  //lat_pkt.dispf("DATA_IN Picked(Latencied)");
endtask : write_lat_mon

//Task : ref_read_monitor : It collects the read data from the reference model using the reference class hanlde by monitoring the interfce signals. So
//when it detects an read operation is performed then the data from the reference model memory will be collected based on the read address and then it
//sends that data to interface to make it delayed. Then it waits for the certain clock cycles to get the data from the interface and then after it
//recieves the data then it will be sent to the scoreboard as the reference data.
task ram_mon::ref_read_monitor(input logic port);
begin
  ram_trans ref_rd_pkt = new();
  @(mon_if.lat_cb);
  if(mon_if.mon_cb.en && (!mon_if.mon_cb.we))
  begin
    ref_rd_pkt.trans  =  READ;
    ref_rd_pkt.addr    =  mon_if.mon_cb.addr;
    ref_rd_pkt.din    =  mon_if.mon_cb.din;
    mon_if.ref_dout    =  refh.ref_mem[mon_if.mon_cb.addr];
    fork
      begin
        repeat(R_LAT[port])  @(mon_if.lat_cb);  
        ref_rd_pkt.dout    =  mon_if.lat_cb.l_ref_dout;
        refh.rm2sb.put(ref_rd_pkt);
        ref_rd_pkt.dispf("Reference Model Read Data");
      end
    join_none
  end
end
endtask :ref_read_monitor

`endif  //RAM_MON_SV
