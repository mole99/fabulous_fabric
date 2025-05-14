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

module OPENRAM_256x32_1RW1R_wrapper (
    input                 CSB_A,
    input                 WEB_A,
    input  [(4 - 1)  : 0] WMASK_A,
    input  [(8 - 1)  : 0] ADDR_A,
    input  [(32 - 1) : 0] DIN_A,
    	output [(32 - 1) : 0] DOUT_A,
    	
    input                 CSB_B,
    input  [(8 - 1)  : 0] ADDR_B,
    output [(32 - 1) : 0] DOUT_B,
);

    OPENRAM_256x32_1RW1R i_OPENRAM_256x32_1RW1R (
        .CSB_A  (CSB_A),
        .WEB_A  (WEB_A),
        
        .WMASK_A0   (WMASK_A[0]),
        .WMASK_A1   (WMASK_A[1]),
        .WMASK_A2   (WMASK_A[2]),
        .WMASK_A3   (WMASK_A[3]),
        
        .ADDR_A0    (ADDR_A[0]),
        .ADDR_A1    (ADDR_A[1]),
        .ADDR_A2    (ADDR_A[2]),
        .ADDR_A3    (ADDR_A[3]),
        .ADDR_A4    (ADDR_A[4]),
        .ADDR_A5    (ADDR_A[5]),
        .ADDR_A6    (ADDR_A[6]),
        .ADDR_A7    (ADDR_A[7]),
        
        .DIN_A0     (DIN_A[0]),
        .DIN_A1     (DIN_A[1]),
        .DIN_A2     (DIN_A[2]),
        .DIN_A3     (DIN_A[3]),
        .DIN_A4     (DIN_A[4]),
        .DIN_A5     (DIN_A[5]),
        .DIN_A6     (DIN_A[6]),
        .DIN_A7     (DIN_A[7]),
        .DIN_A8     (DIN_A[8]),
        .DIN_A9     (DIN_A[9]),
        .DIN_A10     (DIN_A[10]),
        .DIN_A11     (DIN_A[11]),
        .DIN_A12     (DIN_A[12]),
        .DIN_A13     (DIN_A[13]),
        .DIN_A14     (DIN_A[14]),
        .DIN_A15     (DIN_A[15]),
        .DIN_A16     (DIN_A[16]),
        .DIN_A17     (DIN_A[17]),
        .DIN_A18     (DIN_A[18]),
        .DIN_A19     (DIN_A[19]),
        .DIN_A20     (DIN_A[20]),
        .DIN_A21     (DIN_A[21]),
        .DIN_A22     (DIN_A[22]),
        .DIN_A23     (DIN_A[23]),
        .DIN_A24     (DIN_A[24]),
        .DIN_A25     (DIN_A[25]),
        .DIN_A26     (DIN_A[26]),
        .DIN_A27     (DIN_A[27]),
        .DIN_A28     (DIN_A[28]),
        .DIN_A29     (DIN_A[29]),
        .DIN_A30     (DIN_A[30]),
        .DIN_A31     (DIN_A[31]),
        
        .DOUT_A0    (DOUT_A[0]),
        .DOUT_A1    (DOUT_A[1]),
        .DOUT_A2    (DOUT_A[2]),
        .DOUT_A3    (DOUT_A[3]),
        .DOUT_A4    (DOUT_A[4]),
        .DOUT_A5    (DOUT_A[5]),
        .DOUT_A6    (DOUT_A[6]),
        .DOUT_A7    (DOUT_A[7]),
        .DOUT_A8    (DOUT_A[8]),
        .DOUT_A9    (DOUT_A[9]),
        .DOUT_A10    (DOUT_A[10]),
        .DOUT_A11    (DOUT_A[11]),
        .DOUT_A12    (DOUT_A[12]),
        .DOUT_A13    (DOUT_A[13]),
        .DOUT_A14    (DOUT_A[14]),
        .DOUT_A15    (DOUT_A[15]),
        .DOUT_A16    (DOUT_A[16]),
        .DOUT_A17    (DOUT_A[17]),
        .DOUT_A18    (DOUT_A[18]),
        .DOUT_A19    (DOUT_A[19]),
        .DOUT_A20    (DOUT_A[20]),
        .DOUT_A21    (DOUT_A[21]),
        .DOUT_A22    (DOUT_A[22]),
        .DOUT_A23    (DOUT_A[23]),
        .DOUT_A24    (DOUT_A[24]),
        .DOUT_A25    (DOUT_A[25]),
        .DOUT_A26    (DOUT_A[26]),
        .DOUT_A27    (DOUT_A[27]),
        .DOUT_A28    (DOUT_A[28]),
        .DOUT_A29    (DOUT_A[29]),
        .DOUT_A30    (DOUT_A[30]),
        .DOUT_A31    (DOUT_A[31]),
        
        .CSB_B  (CSB_B),
        
        .ADDR_B0    (ADDR_B[0]),
        .ADDR_B1    (ADDR_B[1]),
        .ADDR_B2    (ADDR_B[2]),
        .ADDR_B3    (ADDR_B[3]),
        .ADDR_B4    (ADDR_B[4]),
        .ADDR_B5    (ADDR_B[5]),
        .ADDR_B6    (ADDR_B[6]),
        .ADDR_B7    (ADDR_B[7]),
        
        .DOUT_B0    (DOUT_B[0]),
        .DOUT_B1    (DOUT_B[1]),
        .DOUT_B2    (DOUT_B[2]),
        .DOUT_B3    (DOUT_B[3]),
        .DOUT_B4    (DOUT_B[4]),
        .DOUT_B5    (DOUT_B[5]),
        .DOUT_B6    (DOUT_B[6]),
        .DOUT_B7    (DOUT_B[7]),
        .DOUT_B8    (DOUT_B[8]),
        .DOUT_B9    (DOUT_B[9]),
        .DOUT_B10    (DOUT_B[10]),
        .DOUT_B11    (DOUT_B[11]),
        .DOUT_B12    (DOUT_B[12]),
        .DOUT_B13    (DOUT_B[13]),
        .DOUT_B14    (DOUT_B[14]),
        .DOUT_B15    (DOUT_B[15]),
        .DOUT_B16    (DOUT_B[16]),
        .DOUT_B17    (DOUT_B[17]),
        .DOUT_B18    (DOUT_B[18]),
        .DOUT_B19    (DOUT_B[19]),
        .DOUT_B20    (DOUT_B[20]),
        .DOUT_B21    (DOUT_B[21]),
        .DOUT_B22    (DOUT_B[22]),
        .DOUT_B23    (DOUT_B[23]),
        .DOUT_B24    (DOUT_B[24]),
        .DOUT_B25    (DOUT_B[25]),
        .DOUT_B26    (DOUT_B[26]),
        .DOUT_B27    (DOUT_B[27]),
        .DOUT_B28    (DOUT_B[28]),
        .DOUT_B29    (DOUT_B[29]),
        .DOUT_B30    (DOUT_B[30]),
        .DOUT_B31    (DOUT_B[31])
    );

endmodule

module EF_ADC12_wrapper #(
    parameter [3:0] SAMPLE = 4'd0
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
    input  [7:0] VALUE,
    input        ENABLE
);

    EF_DAC8 i_EF_DAC8 (
        .VALUE0     (VALUE[0]),
        .VALUE1     (VALUE[1]),
        .VALUE2     (VALUE[2]),
        .VALUE3     (VALUE[3]),
        .VALUE4     (VALUE[4]),
        .VALUE5     (VALUE[5]),
        .VALUE6     (VALUE[6]),
        .VALUE7     (VALUE[7]),
        .ENABLE     (ENABLE)
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
