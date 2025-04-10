
module wb_ram #(parameter DEPTH=128, parameter MEMFILE="")
(
   input  logic                     clk_i,
   input  logic                     cyc_i,
   input  logic                     stb_i,
   input  logic                     we_i,
   output logic                     ack_o,
   input  logic [3:0]               be_i,
   input  logic [$clog2(DEPTH)-1:0] adr_i,
   input  logic [31:0]              dat_i,
   output logic [31:0]              dat_o

);

/*`ifdef GOWIN
logic [31:0] mem_r [0:DEPTH-1];
`else
(* ram_style = "block" *) logic [31:0] mem_r [0:DEPTH-1];
`endif

logic read_enable;
logic write_enable;

assign read_enable   = cyc_i & stb_i & ~we_i;
assign write_enable  = cyc_i & stb_i & we_i;

always @(posedge clk_i) begin
   ack_o <= 'b0;

   if (read_enable) begin
      dat_o <= mem_r[adr_i];
      ack_o <= ~ack_o;
   end else if (write_enable) begin
      if (be_i[0]) mem_r[adr_i][7:0]   <= dat_i[7:0];
      if (be_i[1]) mem_r[adr_i][15:8]  <= dat_i[15:8];
      if (be_i[2]) mem_r[adr_i][23:16] <= dat_i[23:16];
      if (be_i[3]) mem_r[adr_i][31:24] <= dat_i[31:24];
      ack_o <= ~ack_o;
   end
end

initial begin
	if(MEMFILE != "") begin
	   $display("Preloading %m from %s", MEMFILE);
	   $readmemh(MEMFILE, mem_r);
	end
end*/

    EF_SRAM_1024x32_wrapper ram0 (
        .AD    (adr_i[9:0]),
        .BEN   ({{8{be_i[3]}}, {8{be_i[2]}}, {8{be_i[1]}}, {8{be_i[0]}}}),
        .DI    (dat_i),
        .EN    (cyc_i && stb_i),
        .R_WB  (!we_i), // TODO
        .DO    (dat_o)
    );

    always_ff @(posedge clk_i) begin
        ack_o <= cyc_i & stb_i;
    end

endmodule
