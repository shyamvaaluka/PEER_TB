`include "ram_trans.sv"

module top;
  ram_trans t1;
  int i = 0;

  bit clk;
  
  initial begin
    t1.fd = $fopen("out.log","w");
    t1  = new();
    repeat(10)
    begin
      @(posedge clk);
      assert(t1.randomize());
      t1.dispf($sformatf("%0d",i));
      i++;
    end 
    @(posedge clk);
    $finish;
  end

  initial forever #5 clk = ~clk;
endmodule : top
