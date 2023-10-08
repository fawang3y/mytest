//   *******************************************************************************************************
//   * File Name: spi_s2p.v
//   * Author: fanwang
//   * Version: V1.0
//   * Date: 2022-03-23
//   * Brief: spi从机串并转换模块
//   *******************************************************************************************************
//   * Revise History
//   *		1.Author: 
//   *		  Date: 
//   *******************************************************************************************************
module spi_s2p
(
   input                                  spi_clk                   ,
   input                                  spi_ss_n                  , 
   input                                  spi_di                    ,
   output reg                             spi_do                    ,
   output      [4            : 0]         reg_addr                  ,
   input       [31           : 0]         data_in                   ,
   output      [31           : 0]         data_out                  ,
   output reg                             cs                        ,
   output reg                             warning1                  ,
   output reg                             warning2                  , 
   output reg  [3            : 0]         byte_cs                   ,
   output reg                             addr_over                 ,    
   output                                 wren                                   
);
  
   parameter                              WIDTH_DATA    = 'd16      ;
   parameter                              WIDTH_ADDR    = 'd17      ;
   parameter                              IDLE_NUM      = 'd6       ;  
   parameter                              COMMAND_NUM   = 'd1       ;
   parameter                              RST           = 'd1       ; 
   reg          [31           : 0]        spi_sspsr_in              ;
   reg          [31           : 0]        spi_sspsr_out             ;
   reg          [6            : 0]        r_scl_cnt                 ;
   reg          [16           : 0]        address                   ;
   reg                                    command                   ;
   reg          [15           : 0]        wdata                     ;
   reg                                    rd_begin                  ; 
   wire load_rd_rst       = r_scl_cnt   == WIDTH_ADDR + COMMAND_NUM+RST                         ;
   wire load_address1     = r_scl_cnt   == WIDTH_ADDR                                           ;
   wire load_command1     = r_scl_cnt   == WIDTH_ADDR + COMMAND_NUM                             ;
   wire load_wdata1       = r_scl_cnt   == WIDTH_ADDR + COMMAND_NUM + IDLE_NUM + WIDTH_DATA     ;
   wire load_wr_rst       = r_scl_cnt   == 1                                                    ;                                                 
always @(negedge spi_clk or negedge spi_ss_n )
begin
    if (!spi_ss_n) begin
    if (!load_wdata1)
        r_scl_cnt        <= r_scl_cnt + 1'b1                    ;
    else               
        r_scl_cnt        <= 0                                   ;
    end
    else  
    begin
        r_scl_cnt        <= 0                                   ;
    end    
end
always @(posedge spi_clk ) begin
    if( !spi_ss_n) begin
        spi_sspsr_in     <= {spi_sspsr_in[30:0], spi_di}        ; 
    end else 
        warning1         <=  1'b1                               ; 
end
always @(negedge spi_clk ) begin 
    if (load_wr_rst) begin 
        cs               <= 1'b0                                ;
        byte_cs          <= 4'b0000                             ;
        rd_begin         <= 1'b0                                ;
    end 
    else if (load_address1) begin 
        address          <= spi_sspsr_in [16:0]                 ; 
        addr_over        <= 1'b1                                ; 
    end 
    else if (load_command1) begin  
        command          <= spi_sspsr_in [0]                    ;
        cs               <= 1'b1                                ;  
    end 
    else if (load_rd_rst && command) begin 
        spi_sspsr_out    <= {4'b0,data_in[15:0],12'b0}          ;
        rd_begin         <= 1'b1                                ;
        cs               <= 1'b0                                ;
    end 
    else begin 
        spi_sspsr_out    <= {spi_sspsr_out [30:0],1'b0}         ; 
        if (load_wdata1) begin 
        wdata            <= spi_sspsr_in [15:0]                 ; 
        byte_cs          <= 4'b1111                             ;
        end 
        else 
        warning2          <= 1'b1                               ; 
    end 
end
always @(posedge spi_clk ) begin
    if( !spi_ss_n && rd_begin) begin
        spi_do           <= spi_sspsr_out [31]                  ;
    end else
        spi_do           <= 1'b0                                ;
end
assign data_out = {16'b0, wdata};
assign wren     = !command      ;
assign reg_addr = address[4:0]  ;

endmodule
