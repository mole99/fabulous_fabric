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

(* blackbox *)
module EF_SRAM_1024x32 (
    input  AD0,
    input  AD1,
    input  AD2,
    input  AD3,
    input  AD4,
    input  AD5,
    input  AD6,
    input  AD7,
    input  AD8,
    input  AD9,

    input  BEN0,
    input  BEN1,
    input  BEN2,
    input  BEN3,
    input  BEN4,
    input  BEN5,
    input  BEN6,
    input  BEN7,
    input  BEN8,
    input  BEN9,
    input  BEN10,
    input  BEN11,
    input  BEN12,
    input  BEN13,
    input  BEN14,
    input  BEN15,
    input  BEN16,
    input  BEN17,
    input  BEN18,
    input  BEN19,
    input  BEN20,
    input  BEN21,
    input  BEN22,
    input  BEN23,
    input  BEN24,
    input  BEN25,
    input  BEN26,
    input  BEN27,
    input  BEN28,
    input  BEN29,
    input  BEN30,
    input  BEN31,

    input  DI0,
    input  DI1,
    input  DI2,
    input  DI3,
    input  DI4,
    input  DI5,
    input  DI6,
    input  DI7,
    input  DI8,
    input  DI9,
    input  DI10,
    input  DI11,
    input  DI12,
    input  DI13,
    input  DI14,
    input  DI15,
    input  DI16,
    input  DI17,
    input  DI18,
    input  DI19,
    input  DI20,
    input  DI21,
    input  DI22,
    input  DI23,
    input  DI24,
    input  DI25,
    input  DI26,
    input  DI27,
    input  DI28,
    input  DI29,
    input  DI30,
    input  DI31,

    input  EN,
    input  R_WB,

    output DO0,
    output DO1,
    output DO2,
    output DO3,
    output DO4,
    output DO5,
    output DO6,
    output DO7,
    output DO8,
    output DO9,
    output DO10,
    output DO11,
    output DO12,
    output DO13,
    output DO14,
    output DO15,
    output DO16,
    output DO17,
    output DO18,
    output DO19,
    output DO20,
    output DO21,
    output DO22,
    output DO23,
    output DO24,
    output DO25,
    output DO26,
    output DO27,
    output DO28,
    output DO29,
    output DO30,
    output DO31
);

endmodule


(* blackbox, keep *)
module CPU_IF (
    input  I0,
    input  I1,
    input  I2,
    input  I3,
    input  I4,
    input  I5,
    input  I6,
    input  I7,
    input  I8,
    input  I9,
    input  I10,
    input  I11,
    input  I12,
    input  I13,
    input  I14,
    input  I15,

    output O0,
    output O1,
    output O2,
    output O3,
    output O4,
    output O5,
    output O6,
    output O7,
    output O8,
    output O9,
    output O10,
    output O11,
    output O12,
    output O13,
    output O14,
    output O15
);

endmodule

(* blackbox *)
module EF_ADC12 #(
    parameter [0:0] SAMPLE_0 = 0,
    parameter [0:0] SAMPLE_1 = 0,
    parameter [0:0] SAMPLE_2 = 0,
    parameter [0:0] SAMPLE_3 = 0
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
    input  VALUE7
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

(* blackbox, keep *)
module CPU_IRQ (
    input  IRQ0,
    input  IRQ1,
    input  IRQ2,
    input  IRQ3
);

endmodule
