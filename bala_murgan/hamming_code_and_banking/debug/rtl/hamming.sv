						/*////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//   Design of Hamming encoding
//
//   Description : its a design module for hamming encoding
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////*/

module hamming(
  input [7:0]i_in,  //input data for encoding
  output reg[11:0]o_out  // output encoded data
  );
  
  reg[11:0]in;  // internal register to store value   
  reg[2:0] j;        //j is for iteration
  
  reg[4:0]arr1,arr2;
  reg[3:0]arr3,arr4;  //arrays are used to store data to generate parity
  
  always@(*)
  begin
  j=0;
    for(int i=0;i<=11;i++)  
       
    begin
      if(i!=0&&i!=1&&i!=3&&i!=7)
      begin
        in[i]=i_in[j];
	j=j+1;
      end
    end
   
    arr1={in[2],in[4],in[6],in[8],in[10]};   //load all arrays
    arr2={in[2],in[5],in[6],in[9],in[10]};
    arr3={in[4],in[5],in[6],in[11]};
    arr4={in[8],in[9],in[10],in[11]};
    
    if(^arr1==0)
      in[0]=0;
    else
      in[0]=1;
    if(^arr2==0)
      in[1]=0;                                      //check for parity
    else
      in[1]=1;
    if(^arr3==0)
      in[3]=0;
    else
      in[3]=1;
    if(^arr4==0)
      in[7]=0;
    else
      in[7]=1;
    o_out=in;                          //assign the output
  end
endmodule