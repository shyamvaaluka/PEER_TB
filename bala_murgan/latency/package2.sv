package pkg_2;
parameter DATA_WIDTH=8;
parameter	MEM_DEPTH=16;
parameter	ADDR_WIDTH=$clog2(MEM_DEPTH);
parameter	MEM_WIDTH=2*ADDR_WIDTH;

parameter WR_LATENCYA=10;
parameter RD_LATENCYA=5;
parameter WR_LATENCYB=7;
parameter RD_LATENCYB=8;


endpackage
