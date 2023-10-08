`timescale 1ns/10ps
module test_top();

wire spi_clk,spi_di,spi_do,spi_ss_n,cs;
wire rst_n,wren;
wire [4:0] reg_addr;
wire [31:0] data_in;
wire [31:0] data_out;
wire [3:0] byte_cs;

spi_master spi_master_inst
(
    .SPI_CLK(spi_clk),
    .spi_ss_n(spi_ss_n),
    .MOSI(spi_di),
    .MISO(spi_do) 
);

regfile regfile_top
(
    .clk(spi_clk),
    .rst_n(1'b1),
    .cs(cs),
    .wren(wren),
    .reg_addr(reg_addr),
    //.addr_over(addr_over),
    .data_in(data_in),
    .data_out(data_out)   
);

spi_s2p  spi_stp
(
    .spi_clk (spi_clk),
    .spi_ss_n(spi_ss_n),
    .spi_di  (spi_di),
    .spi_do  (spi_do),
    .reg_addr(reg_addr),
    //.addr_over(addr_over),
    //.byte_cs (byte_cs),
    .cs      (cs),
    .data_in (data_out ),
    .data_out(data_in),
    .wren    (wren    )
);

// spi_s2p  spi_stp
// (
//     .clk_spi (spi_clk),
//     .spi_ss_n(spi_ss_n),
//     .mosi  (spi_di),
//     .miso  (spi_do),
//     .spi_addr(reg_addr),
//     .spi_para_cs (cs),
//     .para_rdata (data_out ),
//     .spi_wdata (data_in),
//     .spi_para_we    (wren    )
// );

initial 
begin
    $fsdbDumpfile("wave.fsdb");
    $fsdbDumpvars(0,"test_top");  
    $fsdbDumpon;
end


// initial 
// begin
//     $sdf_annotate("spi_s2p.sdf", spi_stp);
// end

endmodule
