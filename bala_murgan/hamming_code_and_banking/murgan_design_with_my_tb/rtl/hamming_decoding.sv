/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//   Design of Hamming decoding
//
//   Description : its a design module for hamming decoding
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

module hamming_decod(
  input [11:0]i_in,           //input data to decode
  output reg[7:0]o_out        //decoded data output
  );
  
  reg[11:0]in;   //internal register to store data
  reg[3:0]p;     // this register store the parity value
  reg [2:0]j;
  reg [5:0]arr1,arr2;
  reg [4:0]arr3,arr4;    //arrays are used to store data to calculate parity
  
  always@(*)
  begin
    j=0;
    in=i_in;
    arr1={i_in[0],i_in[2],i_in[4],i_in[6],i_in[8],i_in[10]};
    arr2={i_in[1],i_in[2],i_in[5],i_in[6],i_in[9],i_in[10]};   //storing data in respective array to calculate parity
    arr3={i_in[3],i_in[4],i_in[5],i_in[6],i_in[11]};
    arr4={i_in[7],i_in[8],i_in[9],i_in[10],i_in[11]};
    
    if(^arr1==0)
      p[0]=0;
    else
      p[0]=1;
    if(^arr2==0)                //calculating the parity
      p[1]=0;
    else
      p[1]=1;
    if(^arr3==0)
      p[2]=0;
    else
      p[2]=1;
    if(^arr4==0)
      p[3]=0;
    else
      p[3]=1;
    if(p==4'b0)
      $display("no error");
    else
    begin
      $display("error detected");                //checking for an error
      
      $display("%d thbit",p-1);
    end
    in[p-1]=~in[p-1];           // correct the correpted data
   
    for(int i=0;i<=11;i++)
    begin
      if(i!=0&&i!=1&&i!=3&&i!=7)
      begin
        o_out[j]=in[i];             // load the data
	j=j+1;
      end
    end
   
  end
endmodule