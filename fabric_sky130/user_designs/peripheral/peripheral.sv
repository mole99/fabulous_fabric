module top(
    input  wire        clk,
    input  wire [47:0] io_in,
    output wire [47:0] io_out,
    output wire [47:0] io_oeb
);

    logic        REQ;
    logic        WE;
    logic [3: 0] BE;
    logic [23:0] ADDR;
    logic [31:0] WDATA;
    
    logic        GNT;
    logic        RVALID;
    logic [31:0] RDATA;

    peripheral_wrapper i_peripheral_wrapper (
        .REQ,
        .WE,
        .BE,
        .ADDR,
        .WDATA,
        
        .GNT,
        .RVALID,
        .RDATA
    );

    logic [31:0] regs [32];

	always_ff @(posedge clk) begin
	    GNT = 1'b0;
        RVALID = 1'b0;
		if (REQ) begin
		    GNT = 1'b1;
            RVALID = 1'b1;
		    if (WE) begin
		        if (BE[0]) regs[ADDR[4:0]][ 7: 0] <= WDATA[7 : 0];
                if (BE[1]) regs[ADDR[4:0]][15: 8] <= WDATA[15: 8];
                if (BE[2]) regs[ADDR[4:0]][23:16] <= WDATA[23:16];
                if (BE[3]) regs[ADDR[4:0]][31:24] <= WDATA[31:24];
		    end else begin
		        RDATA <= regs[ADDR[4:0]];
		    end
		end
    end
    
    //assign GNT = REQ;
    //assign RVALID = REQ;

endmodule
