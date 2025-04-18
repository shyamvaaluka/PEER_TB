module decoder(
  input [1:0]i_in,
  output reg[3:0]o_out
  );

  always@(*)
  begin
    if(i_in==2'b00)
      o_out=4'b0001;
    else if(i_in==2'b01)
      o_out=4'b0010;
    else if(i_in==2'b10)
      o_out=4'b0100;
    else if(i_in==2'b11)
      o_out=4'b1000;
  end
endmodule