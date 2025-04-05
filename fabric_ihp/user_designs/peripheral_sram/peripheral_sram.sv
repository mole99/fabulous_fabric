module top(
    input  wire        clk,
    input  wire [`NUM_IO-1:0] io_in,
    output wire [`NUM_IO-1:0] io_out,
    output wire [`NUM_IO-1:0] io_oeb
);
    // SRAM
    parameter NUM_SRAM = 7;
    logic [32-1:0] DOUT_SRAMS [NUM_SRAM];
    logic [32-1:0] DOUT, DOUT_D;

    // Peripheral
    logic        REQ;
    logic        WE;
    logic [3: 0] BE;
    logic [23:0] ADDR;
    logic [31:0] WDATA;
    
    logic        GNT;
    logic        RVALID;
    logic [31:0] RDATA;
    
    logic [2:0] select_sram, select_sram_d;
    assign select_sram = ADDR[12+2:10+2];
    
    generate
        for (genvar i=0; i<7; i++) begin : gen
        
            IHP_SRAM_1024x32_wrapper sram (
                .ADDR   (ADDR[9+2:0+2]),
                .BM     ({{8{BE[3]}}, {8{BE[2]}}, {8{BE[1]}}, {8{BE[0]}}}),
                .DIN    (WDATA),
                .WEN    (WE),
                .MEN    (select_sram == i && REQ),
                .REN    (!WE),
                .DOUT   (DOUT_SRAMS[i])
            );
        end
    endgenerate
    
    always_ff @(posedge clk) begin
        RVALID <= REQ;
        select_sram_d <= select_sram;
    end
    
    always_comb begin
        DOUT = 0;
        if (select_sram_d < NUM_SRAM) begin
            DOUT = DOUT_SRAMS[select_sram_d];
        end
    end
    
    assign RDATA = DOUT;
    assign GNT = 1'b1;

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
    
    WARMBOOT_wrapper WARMBOOT_wrapper (
        .SLOT   (4'd0),
        .BOOT   (1'b0),
        .RESET  (    )
    );
    
    assign io_oeb = '0;
    assign io_out = 32'hCAFECAFE;

endmodule
