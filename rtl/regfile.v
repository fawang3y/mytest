module regfile
(
    input clk,
    input rst_n,
    input cs,
    input wren,
    input[4:0] reg_addr,
    input[31:0] data_in,
    output reg [31:0] data_out
);
    reg  [31:0] reg0;
    reg  [31:0] reg1;
    reg  [31:0] reg2;
    reg  [31:0] reg3;
    reg  [31:0] reg4;
    reg  [31:0] reg5;
    wire  [3:0] byte_cs;

    assign byte_cs = 4'b1111;

always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) reg0<=#1 32'h0000_0000;
    else
	if((cs==1'b1)&& (reg_addr==5'h00) && (wren==1'b1))  
        begin
            if(byte_cs[0]==1'b1)  reg0[7:0]<=#1 data_in[7:0];
            if(byte_cs[1]==1'b1)  reg0[15:8]<=#1 data_in[15:8];
            if(byte_cs[2]==1'b1)  reg0[23:16]<=#1 data_in[23:16];
            if(byte_cs[3]==1'b1)  reg0[31:24]<=#1 data_in[31:24];
	end 
end	 
	
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) reg1<=#1 32'h0000_0000;
    else
	if((cs==1'b1)&& (reg_addr==5'h01) && (wren==1'b1))  
        begin
            if(byte_cs[0]==1'b1)  reg1[7:0]<=#1 data_in[7:0];
            if(byte_cs[1]==1'b1)  reg1[15:8]<=#1 data_in[15:8];
            if(byte_cs[2]==1'b1)  reg1[23:16]<=#1 data_in[23:16];
            if(byte_cs[3]==1'b1)  reg1[31:24]<=#1 data_in[31:24];
	end 
end	 
	
	
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) reg2<=#1 32'h0000_0000;
    else
	if((cs==1'b1)&& (reg_addr==5'h02) && (wren==1'b1))  
        begin
            if(byte_cs[0]==1'b1)  reg2[7:0]<=#1 data_in[7:0];
            if(byte_cs[1]==1'b1)  reg2[15:8]<=#1 data_in[15:8];
            if(byte_cs[2]==1'b1)  reg2[23:16]<=#1 data_in[23:16];
            if(byte_cs[3]==1'b1)  reg2[31:24]<=#1 data_in[31:24];
	end 
end	
	
	
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) reg3<=#1 32'h0000_0000;
    else
	if((cs==1'b1)&& (reg_addr==5'h03) && (wren==1'b1))  
        begin
            if(byte_cs[0]==1'b1)  reg3[7:0]<=#1 data_in[7:0];
            if(byte_cs[1]==1'b1)  reg3[15:8]<=#1 data_in[15:8];
            if(byte_cs[2]==1'b1)  reg3[23:16]<=#1 data_in[23:16];
            if(byte_cs[3]==1'b1)  reg3[31:24]<=#1 data_in[31:24];
	end 
end	

	
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) reg4<=#1 32'h0000_0000;
    else
	if((cs==1'b1)&& (reg_addr==5'h04) && (wren==1'b1))  
        begin
            if(byte_cs[0]==1'b1)  reg4[7:0]<=#1 data_in[7:0];
            if(byte_cs[1]==1'b1)  reg4[15:8]<=#1 data_in[15:8];
            if(byte_cs[2]==1'b1)  reg4[23:16]<=#1 data_in[23:16];
            if(byte_cs[3]==1'b1)  reg4[31:24]<=#1 data_in[31:24];
	end 
end	


	
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) reg5<=#1 32'h0000_0000;
    else
	if((cs==1'b1)&& (reg_addr==5'h05) && (wren==1'b1))  
        begin
            if(byte_cs[0]==1'b1)  reg5[7:0]<=#1 data_in[7:0];
            if(byte_cs[1]==1'b1)  reg5[15:8]<=#1 data_in[15:8];
            if(byte_cs[2]==1'b1)  reg5[23:16]<=#1 data_in[23:16];
            if(byte_cs[3]==1'b1)  reg5[31:24]<=#1 data_in[31:24];
	end 
end	

	
always @(posedge clk or negedge rst_n)
begin
    if(~rst_n) data_out<=#1 32'h0000_0000;
    else
	if((cs==1'b1) && (wren==1'b0))
	begin
            case(reg_addr)
	 	5'h0:	data_out<= #1 reg0;
	 	5'h1:	data_out<= #1 reg1;
	 	5'h2:	data_out<= #1 reg2;
	 	5'h3:	data_out<= #1 reg3;
	 	5'h4:	data_out<= #1 reg4;
	 	5'h5:	data_out<= #1 reg5;
		default:data_out<= #1 32'h0;
	    endcase
	end
end	 


endmodule
