
//interface it carry all the signal from tb to design
import dual_package::*; 

interface inf(input i_clka,int l);
  
  logic[DATA_WIDTH-1:0]i_din;
  logic[$clog2(4*ADDRESS_DEPTH)-1:0]i_addr;
  logic i_en;
  logic i_we;                                //all the signal declaration
  logic [DATA_WIDTH-1:0]o_dout;
  
  logic[DATA_WIDTH-1:0]w_din;
  logic[$clog2(4*ADDRESS_DEPTH)-1:0]w_addr;
  logic w_en;
  logic w_we;                                //all the signal declaration
  logic [DATA_WIDTH-1:0]w_dout;

  logic [DATA_WIDTH-1:0]r_dout;
  clocking idrv @(posedge i_clka);
    default input #1 output #1;
    output i_din, i_addr,i_en,i_we;     
  endclocking

  clocking imon @(posedge i_clka);
    default input #1 output #1;
    input i_din,i_addr,i_en,i_we,o_dout;
  endclocking

  always@(posedge i_clka)
  begin
        w_en<=repeat(WRITE_LATENCY[l]-1)@(posedge i_clka)i_en;
        w_we<=repeat(WRITE_LATENCY[l]-1)@(posedge i_clka)i_we;
        w_addr<=repeat(WRITE_LATENCY[l]-1)@(posedge i_clka)i_addr;    //capturing values from interface for port A
        w_din<=repeat(WRITE_LATENCY[l]-1)@(posedge i_clka)i_din;
        w_dout<=repeat(READ_LATENCY[l]-1)@(posedge i_clka)o_dout;  
  end      
endinterface


