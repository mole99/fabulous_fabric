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

(* blackbox, keep *)
module Config_access #(
    parameter [0:0] C_bit0 = 1'b0,
    parameter [0:0] C_bit1 = 1'b0,
    parameter [0:0] C_bit2 = 1'b0,
    parameter [0:0] C_bit3 = 1'b0,
);

endmodule

(* blackbox *)
module OPENRAM_256x32_1RW1R (
    input CSB_A,
    input WEB_A,
    
    input WMASK_A0,
    input WMASK_A1,
    input WMASK_A2,
    input WMASK_A3,
    
    input ADDR_A0,
    input ADDR_A1,
    input ADDR_A2,
    input ADDR_A3,
    input ADDR_A4,
    input ADDR_A5,
    input ADDR_A6,
    input ADDR_A7,
    input ADDR_A8,
    input ADDR_A9,
    input ADDR_A10,
    input ADDR_A11,
    input ADDR_A12,
    input ADDR_A13,
    input ADDR_A14,
    input ADDR_A15,
    input ADDR_A16,
    input ADDR_A17,
    input ADDR_A18,
    input ADDR_A19,
    input ADDR_A20,
    input ADDR_A21,
    input ADDR_A22,
    input ADDR_A23,
    input ADDR_A24,
    input ADDR_A25,
    input ADDR_A26,
    input ADDR_A27,
    input ADDR_A28,
    input ADDR_A29,
    input ADDR_A30,
    input ADDR_A31,
    
    input DIN_A0,
    input DIN_A1,
    input DIN_A2,
    input DIN_A3,
    input DIN_A4,
    input DIN_A5,
    input DIN_A6,
    input DIN_A7,
    input DIN_A8,
    input DIN_A9,
    input DIN_A10,
    input DIN_A11,
    input DIN_A12,
    input DIN_A13,
    input DIN_A14,
    input DIN_A15,
    input DIN_A16,
    input DIN_A17,
    input DIN_A18,
    input DIN_A19,
    input DIN_A20,
    input DIN_A21,
    input DIN_A22,
    input DIN_A23,
    input DIN_A24,
    input DIN_A25,
    input DIN_A26,
    input DIN_A27,
    input DIN_A28,
    input DIN_A29,
    input DIN_A30,
    input DIN_A31,
    
    output DOUT_A0,
    output DOUT_A1,
    output DOUT_A2,
    output DOUT_A3,
    output DOUT_A4,
    output DOUT_A5,
    output DOUT_A6,
    output DOUT_A7,
    output DOUT_A8,
    output DOUT_A9,
    output DOUT_A10,
    output DOUT_A11,
    output DOUT_A12,
    output DOUT_A13,
    output DOUT_A14,
    output DOUT_A15,
    output DOUT_A16,
    output DOUT_A17,
    output DOUT_A18,
    output DOUT_A19,
    output DOUT_A20,
    output DOUT_A21,
    output DOUT_A22,
    output DOUT_A23,
    output DOUT_A24,
    output DOUT_A25,
    output DOUT_A26,
    output DOUT_A27,
    output DOUT_A28,
    output DOUT_A29,
    output DOUT_A30,
    output DOUT_A31,
    
    input CSB_B,
    
    input ADDR_B0,
    input ADDR_B1,
    input ADDR_B2,
    input ADDR_B3,
    input ADDR_B4,
    input ADDR_B5,
    input ADDR_B6,
    input ADDR_B7,
    input ADDR_B8,
    input ADDR_B9,
    input ADDR_B10,
    input ADDR_B11,
    input ADDR_B12,
    input ADDR_B13,
    input ADDR_B14,
    input ADDR_B15,
    input ADDR_B16,
    input ADDR_B17,
    input ADDR_B18,
    input ADDR_B19,
    input ADDR_B20,
    input ADDR_B21,
    input ADDR_B22,
    input ADDR_B23,
    input ADDR_B24,
    input ADDR_B25,
    input ADDR_B26,
    input ADDR_B27,
    input ADDR_B28,
    input ADDR_B29,
    input ADDR_B30,
    input ADDR_B31,
    
    output DOUT_B0,
    output DOUT_B1,
    output DOUT_B2,
    output DOUT_B3,
    output DOUT_B4,
    output DOUT_B5,
    output DOUT_B6,
    output DOUT_B7,
    output DOUT_B8,
    output DOUT_B9,
    output DOUT_B10,
    output DOUT_B11,
    output DOUT_B12,
    output DOUT_B13,
    output DOUT_B14,
    output DOUT_B15,
    output DOUT_B16,
    output DOUT_B17,
    output DOUT_B18,
    output DOUT_B19,
    output DOUT_B20,
    output DOUT_B21,
    output DOUT_B22,
    output DOUT_B23,
    output DOUT_B24,
    output DOUT_B25,
    output DOUT_B26,
    output DOUT_B27,
    output DOUT_B28,
    output DOUT_B29,
    output DOUT_B30,
    output DOUT_B31
);

endmodule

(* blackbox *)
module EF_ADC12 #(
    parameter [0:0] SAMPLE_0 = 1'b0,
    parameter [0:0] SAMPLE_1 = 1'b0,
    parameter [0:0] SAMPLE_2 = 1'b0,
    parameter [0:0] SAMPLE_3 = 1'b0
)(
    input  START,
    input  RESET,
    output VALID,
    output VALUE0,
    output VALUE1,
    output VALUE2,
    output VALUE3,
    output VALUE4,
    output VALUE5,
    output VALUE6,
    output VALUE7,
    output VALUE8,
    output VALUE9,
    output VALUE10,
    output VALUE11
);

endmodule

(* blackbox, keep *)
module EF_DAC8 (
    input  VALUE0,
    input  VALUE1,
    input  VALUE2,
    input  VALUE3,
    input  VALUE4,
    input  VALUE5,
    input  VALUE6,
    input  VALUE7,
    input  ENABLE,
);

endmodule

(* blackbox, keep *)
module WARMBOOT (
    input  SLOT0,
    input  SLOT1,
    input  SLOT2,
    input  SLOT3,
    input  BOOT,
    output RESET
);

endmodule
