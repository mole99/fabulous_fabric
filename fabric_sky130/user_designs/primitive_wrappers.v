// Copyright 2025 Leo Moser
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

module EF_SRAM_1024x32_wrapper (
    input  [ 9:0] AD,
    input  [31:0] BEN,
    input  [31:0] DI,
    input         EN,
    input         R_WB,
    output [31:0] DO
);
    EF_SRAM_1024x32 i_EF_SRAM_1024x32 (
        .AD0    (AD[0]),
        .AD1    (AD[1]),
        .AD2    (AD[2]),
        .AD3    (AD[3]),
        .AD4    (AD[4]),
        .AD5    (AD[5]),
        .AD6    (AD[6]),
        .AD7    (AD[7]),
        .AD8    (AD[8]),
        .AD9    (AD[9]),
        
        .BEN0   (BEN[0]),
        .BEN1   (BEN[1]),
        .BEN2   (BEN[2]),
        .BEN3   (BEN[3]),
        .BEN4   (BEN[4]),
        .BEN5   (BEN[5]),
        .BEN6   (BEN[6]),
        .BEN7   (BEN[7]),
        .BEN8   (BEN[8]),
        .BEN9   (BEN[9]),
        .BEN10   (BEN[10]),
        .BEN11   (BEN[11]),
        .BEN12   (BEN[12]),
        .BEN13   (BEN[13]),
        .BEN14   (BEN[14]),
        .BEN15   (BEN[15]),
        .BEN16   (BEN[16]),
        .BEN17   (BEN[17]),
        .BEN18   (BEN[18]),
        .BEN19   (BEN[19]),
        .BEN20   (BEN[20]),
        .BEN21   (BEN[21]),
        .BEN22   (BEN[22]),
        .BEN23   (BEN[23]),
        .BEN24   (BEN[24]),
        .BEN25   (BEN[25]),
        .BEN26   (BEN[26]),
        .BEN27   (BEN[27]),
        .BEN28   (BEN[28]),
        .BEN29   (BEN[29]),
        .BEN30   (BEN[30]),
        .BEN31   (BEN[31]),
        
        .DI0    (DI[0]),
        .DI1    (DI[1]),
        .DI2    (DI[2]),
        .DI3    (DI[3]),
        .DI4    (DI[4]),
        .DI5    (DI[5]),
        .DI6    (DI[6]),
        .DI7    (DI[7]),
        .DI8    (DI[8]),
        .DI9    (DI[9]),
        .DI10    (DI[10]),
        .DI11    (DI[11]),
        .DI12    (DI[12]),
        .DI13    (DI[13]),
        .DI14    (DI[14]),
        .DI15    (DI[15]),
        .DI16    (DI[16]),
        .DI17    (DI[17]),
        .DI18    (DI[18]),
        .DI19    (DI[19]),
        .DI20    (DI[20]),
        .DI21    (DI[21]),
        .DI22    (DI[22]),
        .DI23    (DI[23]),
        .DI24    (DI[24]),
        .DI25    (DI[25]),
        .DI26    (DI[26]),
        .DI27    (DI[27]),
        .DI28    (DI[28]),
        .DI29    (DI[29]),
        .DI30    (DI[30]),
        .DI31    (DI[31]),
        
        .EN     (EN),

        .R_WB   (R_WB),
        
        .DO0    (DO[0]),
        .DO1    (DO[1]),
        .DO2    (DO[2]),
        .DO3    (DO[3]),
        .DO4    (DO[4]),
        .DO5    (DO[5]),
        .DO6    (DO[6]),
        .DO7    (DO[7]),
        .DO8    (DO[8]),
        .DO9    (DO[9]),
        .DO10    (DO[10]),
        .DO11    (DO[11]),
        .DO12    (DO[12]),
        .DO13    (DO[13]),
        .DO14    (DO[14]),
        .DO15    (DO[15]),
        .DO16    (DO[16]),
        .DO17    (DO[17]),
        .DO18    (DO[18]),
        .DO19    (DO[19]),
        .DO20    (DO[20]),
        .DO21    (DO[21]),
        .DO22    (DO[22]),
        .DO23    (DO[23]),
        .DO24    (DO[24]),
        .DO25    (DO[25]),
        .DO26    (DO[26]),
        .DO27    (DO[27]),
        .DO28    (DO[28]),
        .DO29    (DO[29]),
        .DO30    (DO[30]),
        .DO31    (DO[31])
    );

endmodule

module CPU_IF_wrapper (
    input  [15:0] I,
    output [15:0] O,
);

    CPU_IF i_CPU_IF (
        .I0     (I[0]),
        .I1     (I[1]),
        .I2     (I[2]),
        .I3     (I[3]),
        .I4     (I[4]),
        .I5     (I[5]),
        .I6     (I[6]),
        .I7     (I[7]),
        .I8     (I[8]),
        .I9     (I[9]),
        .I10     (I[10]),
        .I11     (I[11]),
        .I12     (I[12]),
        .I13     (I[13]),
        .I14     (I[14]),
        .I15     (I[15]),

        .O0     (O[0]),
        .O1     (O[1]),
        .O2     (O[2]),
        .O3     (O[3]),
        .O4     (O[4]),
        .O5     (O[5]),
        .O6     (O[6]),
        .O7     (O[7]),
        .O8     (O[8]),
        .O9     (O[9]),
        .O10     (O[10]),
        .O11     (O[11]),
        .O12     (O[12]),
        .O13     (O[13]),
        .O14     (O[14]),
        .O15     (O[15])
    );

endmodule

module EF_ADC12_wrapper #(
    parameter [3:0] SAMPLE = 0
)(
    input         START,
    input         RESET,
    output        VALID,
    output [11:0] VALUE
);

    EF_ADC12 #(
        .SAMPLE_0     (SAMPLE[0]),
        .SAMPLE_1     (SAMPLE[1]),
        .SAMPLE_2     (SAMPLE[2]),
        .SAMPLE_3     (SAMPLE[3])
    ) i_EF_ADC12 (
        .START      (START),
        .RESET      (RESET),
        .VALID      (VALID),
        .VALUE0     (VALUE[0]),
        .VALUE1     (VALUE[1]),
        .VALUE2     (VALUE[2]),
        .VALUE3     (VALUE[3]),
        .VALUE4     (VALUE[4]),
        .VALUE5     (VALUE[5]),
        .VALUE6     (VALUE[6]),
        .VALUE7     (VALUE[7]),
        .VALUE8     (VALUE[8]),
        .VALUE9     (VALUE[9]),
        .VALUE10    (VALUE[10]),
        .VALUE11    (VALUE[11])
    );

endmodule

module EF_DAC8_wrapper (
    input  [7:0] VALUE
);

    EF_DAC8 i_EF_DAC8 (
        .VALUE0     (VALUE[0]),
        .VALUE1     (VALUE[1]),
        .VALUE2     (VALUE[2]),
        .VALUE3     (VALUE[3]),
        .VALUE4     (VALUE[4]),
        .VALUE5     (VALUE[5]),
        .VALUE6     (VALUE[6]),
        .VALUE7     (VALUE[7])
    );

endmodule

module WARMBOOT_wrapper (
    input  [3:0] SLOT,
    input        BOOT,
    output       RESET
);

    WARMBOOT i_WARMBOOT (
        .SLOT0  (SLOT[0]),
        .SLOT1  (SLOT[1]),
        .SLOT2  (SLOT[2]),
        .SLOT3  (SLOT[3]),
        .BOOT   (BOOT),
        .RESET  (RESET)
    );

endmodule

module CPU_IRQ_wrapper (
    input  [3:0] IRQ,
);

    CPU_IRQ i_CPU_IRQ (
        .IRQ0   (IRQ[0]),
        .IRQ1   (IRQ[1]),
        .IRQ2   (IRQ[2]),
        .IRQ3   (IRQ[3])
    );

endmodule

module xif_wrapper (
    output [31:0] RS1,
    output [31:0] RS2,
    input  [31:0] RESULT,
);

    wire [63:0] O, I;
    
    assign RS1 = O[31:0];
    assign RS2 = O[63:32];
    
    assign I[31:0] = RESULT;

    (* keep, BEL="X4Y17.A" *) CPU_IF i_CPU_IF_0 (
        .I0     (I[0]),
        .I1     (I[1]),
        .I2     (I[2]),
        .I3     (I[3]),
        .I4     (I[4]),
        .I5     (I[5]),
        .I6     (I[6]),
        .I7     (I[7]),
        .I8     (I[8]),
        .I9     (I[9]),
        .I10     (I[10]),
        .I11     (I[11]),
        .I12     (I[12]),
        .I13     (I[13]),
        .I14     (I[14]),
        .I15     (I[15]),

        .O0     (O[0]),
        .O1     (O[1]),
        .O2     (O[2]),
        .O3     (O[3]),
        .O4     (O[4]),
        .O5     (O[5]),
        .O6     (O[6]),
        .O7     (O[7]),
        .O8     (O[8]),
        .O9     (O[9]),
        .O10     (O[10]),
        .O11     (O[11]),
        .O12     (O[12]),
        .O13     (O[13]),
        .O14     (O[14]),
        .O15     (O[15])
    );
    
    (* keep, BEL="X5Y17.A" *) CPU_IF i_CPU_IF_1 (
        .I0     (I[16]),
        .I1     (I[17]),
        .I2     (I[18]),
        .I3     (I[19]),
        .I4     (I[20]),
        .I5     (I[21]),
        .I6     (I[22]),
        .I7     (I[23]),
        .I8     (I[24]),
        .I9     (I[25]),
        .I10     (I[26]),
        .I11     (I[27]),
        .I12     (I[28]),
        .I13     (I[29]),
        .I14     (I[30]),
        .I15     (I[31]),

        .O0     (O[16]),
        .O1     (O[17]),
        .O2     (O[18]),
        .O3     (O[19]),
        .O4     (O[20]),
        .O5     (O[21]),
        .O6     (O[22]),
        .O7     (O[23]),
        .O8     (O[24]),
        .O9     (O[25]),
        .O10     (O[26]),
        .O11     (O[27]),
        .O12     (O[28]),
        .O13     (O[29]),
        .O14     (O[30]),
        .O15     (O[31])
    );
    
    (* keep, BEL="X6Y17.A" *) CPU_IF i_CPU_IF_2 (
        .I0     (I[32]),
        .I1     (I[33]),
        .I2     (I[34]),
        .I3     (I[35]),
        .I4     (I[36]),
        .I5     (I[37]),
        .I6     (I[38]),
        .I7     (I[39]),
        .I8     (I[40]),
        .I9     (I[41]),
        .I10     (I[42]),
        .I11     (I[43]),
        .I12     (I[44]),
        .I13     (I[45]),
        .I14     (I[46]),
        .I15     (I[47]),

        .O0     (O[32]),
        .O1     (O[33]),
        .O2     (O[34]),
        .O3     (O[35]),
        .O4     (O[36]),
        .O5     (O[37]),
        .O6     (O[38]),
        .O7     (O[39]),
        .O8     (O[40]),
        .O9     (O[41]),
        .O10     (O[42]),
        .O11     (O[43]),
        .O12     (O[44]),
        .O13     (O[45]),
        .O14     (O[46]),
        .O15     (O[47])
    );
    
    (* keep, BEL="X8Y17.A" *) CPU_IF i_CPU_IF_3 (
        .I0     (I[48]),
        .I1     (I[49]),
        .I2     (I[50]),
        .I3     (I[51]),
        .I4     (I[52]),
        .I5     (I[53]),
        .I6     (I[54]),
        .I7     (I[55]),
        .I8     (I[56]),
        .I9     (I[57]),
        .I10     (I[58]),
        .I11     (I[59]),
        .I12     (I[60]),
        .I13     (I[61]),
        .I14     (I[62]),
        .I15     (I[63]),

        .O0     (O[48]),
        .O1     (O[49]),
        .O2     (O[50]),
        .O3     (O[51]),
        .O4     (O[52]),
        .O5     (O[53]),
        .O6     (O[54]),
        .O7     (O[55]),
        .O8     (O[56]),
        .O9     (O[57]),
        .O10     (O[58]),
        .O11     (O[59]),
        .O12     (O[60]),
        .O13     (O[61]),
        .O14     (O[62]),
        .O15     (O[63])
    );

endmodule

module peripheral_wrapper (
    output        REQ,
    output        WE,
    output [3: 0] BE,
    output [23:0] ADDR,
    output [31:0] WDATA,
    
    input         GNT,
    input         RVALID,
    input  [31:0] RDATA
);

    wire [63:0] O, I;

    assign WDATA = O[31:0];
    assign ADDR  = O[55:32];
    assign BE    = O[59:56];
    assign WE    = O[60];
    assign REQ   = O[61];
    
    assign I[31:0] = RDATA;
    assign I[32]   = RVALID;
    assign I[33]   = GNT;

    (* keep, BEL="X4Y17.A" *) CPU_IF i_CPU_IF_0 (
        .I0     (I[0]),
        .I1     (I[1]),
        .I2     (I[2]),
        .I3     (I[3]),
        .I4     (I[4]),
        .I5     (I[5]),
        .I6     (I[6]),
        .I7     (I[7]),
        .I8     (I[8]),
        .I9     (I[9]),
        .I10     (I[10]),
        .I11     (I[11]),
        .I12     (I[12]),
        .I13     (I[13]),
        .I14     (I[14]),
        .I15     (I[15]),

        .O0     (O[0]),
        .O1     (O[1]),
        .O2     (O[2]),
        .O3     (O[3]),
        .O4     (O[4]),
        .O5     (O[5]),
        .O6     (O[6]),
        .O7     (O[7]),
        .O8     (O[8]),
        .O9     (O[9]),
        .O10     (O[10]),
        .O11     (O[11]),
        .O12     (O[12]),
        .O13     (O[13]),
        .O14     (O[14]),
        .O15     (O[15])
    );
    
    (* keep, BEL="X5Y17.A" *) CPU_IF i_CPU_IF_1 (
        .I0     (I[16]),
        .I1     (I[17]),
        .I2     (I[18]),
        .I3     (I[19]),
        .I4     (I[20]),
        .I5     (I[21]),
        .I6     (I[22]),
        .I7     (I[23]),
        .I8     (I[24]),
        .I9     (I[25]),
        .I10     (I[26]),
        .I11     (I[27]),
        .I12     (I[28]),
        .I13     (I[29]),
        .I14     (I[30]),
        .I15     (I[31]),

        .O0     (O[16]),
        .O1     (O[17]),
        .O2     (O[18]),
        .O3     (O[19]),
        .O4     (O[20]),
        .O5     (O[21]),
        .O6     (O[22]),
        .O7     (O[23]),
        .O8     (O[24]),
        .O9     (O[25]),
        .O10     (O[26]),
        .O11     (O[27]),
        .O12     (O[28]),
        .O13     (O[29]),
        .O14     (O[30]),
        .O15     (O[31])
    );
    
    (* keep, BEL="X6Y17.A" *) CPU_IF i_CPU_IF_2 (
        .I0     (I[32]),
        .I1     (I[33]),
        .I2     (I[34]),
        .I3     (I[35]),
        .I4     (I[36]),
        .I5     (I[37]),
        .I6     (I[38]),
        .I7     (I[39]),
        .I8     (I[40]),
        .I9     (I[41]),
        .I10     (I[42]),
        .I11     (I[43]),
        .I12     (I[44]),
        .I13     (I[45]),
        .I14     (I[46]),
        .I15     (I[47]),

        .O0     (O[32]),
        .O1     (O[33]),
        .O2     (O[34]),
        .O3     (O[35]),
        .O4     (O[36]),
        .O5     (O[37]),
        .O6     (O[38]),
        .O7     (O[39]),
        .O8     (O[40]),
        .O9     (O[41]),
        .O10     (O[42]),
        .O11     (O[43]),
        .O12     (O[44]),
        .O13     (O[45]),
        .O14     (O[46]),
        .O15     (O[47])
    );
    
    (* keep, BEL="X8Y17.A" *) CPU_IF i_CPU_IF_3 (
        .I0     (I[48]),
        .I1     (I[49]),
        .I2     (I[50]),
        .I3     (I[51]),
        .I4     (I[52]),
        .I5     (I[53]),
        .I6     (I[54]),
        .I7     (I[55]),
        .I8     (I[56]),
        .I9     (I[57]),
        .I10     (I[58]),
        .I11     (I[59]),
        .I12     (I[60]),
        .I13     (I[61]),
        .I14     (I[62]),
        .I15     (I[63]),

        .O0     (O[48]),
        .O1     (O[49]),
        .O2     (O[50]),
        .O3     (O[51]),
        .O4     (O[52]),
        .O5     (O[53]),
        .O6     (O[54]),
        .O7     (O[55]),
        .O8     (O[56]),
        .O9     (O[57]),
        .O10     (O[58]),
        .O11     (O[59]),
        .O12     (O[60]),
        .O13     (O[61]),
        .O14     (O[62]),
        .O15     (O[63])
    );

endmodule
