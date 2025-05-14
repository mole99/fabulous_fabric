`define NUM_IO 64

module top_wrapper #(
    parameter [`NUM_IO-1:0] CONFIG_PULL_UP=64'b0,
    parameter [`NUM_IO-1:0] CONFIG_PULL_DOWN=64'b0,
    parameter [`NUM_IO-1:0] CONFIG_SLOW=64'b0,
    parameter [`NUM_IO-1:0] CONFIG_OPEN_DRAIN=64'b0,
);

wire [`NUM_IO-1:0] io_in, io_out, io_oeb;

//for i in range(16):
//    for j, bel in enumerate(reversed(['A', 'B', 'C', 'D'])):
//        print(f'(* keep, BEL="X0Y{i+1}.{bel}" *) IO_1_bidirectional_frame_config_pass io{64-1-i*4-j}_i (.O(io_in[{64-1-i*4-j}]), .I(io_out[{64-1-i*4-j}]), .T(io_oeb[{64-1-i*4-j}]));')

// West
(* keep, BEL="X0Y1.D" *) IO_1_bidirectional_frame_config_pass io63_i (.O(io_in[63]), .I(io_out[63]), .T(io_oeb[63]));
(* keep, BEL="X0Y1.C" *) IO_1_bidirectional_frame_config_pass io62_i (.O(io_in[62]), .I(io_out[62]), .T(io_oeb[62]));
(* keep, BEL="X0Y1.B" *) IO_1_bidirectional_frame_config_pass io61_i (.O(io_in[61]), .I(io_out[61]), .T(io_oeb[61]));
(* keep, BEL="X0Y1.A" *) IO_1_bidirectional_frame_config_pass io60_i (.O(io_in[60]), .I(io_out[60]), .T(io_oeb[60]));
(* keep, BEL="X0Y2.D" *) IO_1_bidirectional_frame_config_pass io59_i (.O(io_in[59]), .I(io_out[59]), .T(io_oeb[59]));
(* keep, BEL="X0Y2.C" *) IO_1_bidirectional_frame_config_pass io58_i (.O(io_in[58]), .I(io_out[58]), .T(io_oeb[58]));
(* keep, BEL="X0Y2.B" *) IO_1_bidirectional_frame_config_pass io57_i (.O(io_in[57]), .I(io_out[57]), .T(io_oeb[57]));
(* keep, BEL="X0Y2.A" *) IO_1_bidirectional_frame_config_pass io56_i (.O(io_in[56]), .I(io_out[56]), .T(io_oeb[56]));
(* keep, BEL="X0Y3.D" *) IO_1_bidirectional_frame_config_pass io55_i (.O(io_in[55]), .I(io_out[55]), .T(io_oeb[55]));
(* keep, BEL="X0Y3.C" *) IO_1_bidirectional_frame_config_pass io54_i (.O(io_in[54]), .I(io_out[54]), .T(io_oeb[54]));
(* keep, BEL="X0Y3.B" *) IO_1_bidirectional_frame_config_pass io53_i (.O(io_in[53]), .I(io_out[53]), .T(io_oeb[53]));
(* keep, BEL="X0Y3.A" *) IO_1_bidirectional_frame_config_pass io52_i (.O(io_in[52]), .I(io_out[52]), .T(io_oeb[52]));
(* keep, BEL="X0Y4.D" *) IO_1_bidirectional_frame_config_pass io51_i (.O(io_in[51]), .I(io_out[51]), .T(io_oeb[51]));
(* keep, BEL="X0Y4.C" *) IO_1_bidirectional_frame_config_pass io50_i (.O(io_in[50]), .I(io_out[50]), .T(io_oeb[50]));
(* keep, BEL="X0Y4.B" *) IO_1_bidirectional_frame_config_pass io49_i (.O(io_in[49]), .I(io_out[49]), .T(io_oeb[49]));
(* keep, BEL="X0Y4.A" *) IO_1_bidirectional_frame_config_pass io48_i (.O(io_in[48]), .I(io_out[48]), .T(io_oeb[48]));
(* keep, BEL="X0Y5.D" *) IO_1_bidirectional_frame_config_pass io47_i (.O(io_in[47]), .I(io_out[47]), .T(io_oeb[47]));
(* keep, BEL="X0Y5.C" *) IO_1_bidirectional_frame_config_pass io46_i (.O(io_in[46]), .I(io_out[46]), .T(io_oeb[46]));
(* keep, BEL="X0Y5.B" *) IO_1_bidirectional_frame_config_pass io45_i (.O(io_in[45]), .I(io_out[45]), .T(io_oeb[45]));
(* keep, BEL="X0Y5.A" *) IO_1_bidirectional_frame_config_pass io44_i (.O(io_in[44]), .I(io_out[44]), .T(io_oeb[44]));
(* keep, BEL="X0Y6.D" *) IO_1_bidirectional_frame_config_pass io43_i (.O(io_in[43]), .I(io_out[43]), .T(io_oeb[43]));
(* keep, BEL="X0Y6.C" *) IO_1_bidirectional_frame_config_pass io42_i (.O(io_in[42]), .I(io_out[42]), .T(io_oeb[42]));
(* keep, BEL="X0Y6.B" *) IO_1_bidirectional_frame_config_pass io41_i (.O(io_in[41]), .I(io_out[41]), .T(io_oeb[41]));
(* keep, BEL="X0Y6.A" *) IO_1_bidirectional_frame_config_pass io40_i (.O(io_in[40]), .I(io_out[40]), .T(io_oeb[40]));
(* keep, BEL="X0Y7.D" *) IO_1_bidirectional_frame_config_pass io39_i (.O(io_in[39]), .I(io_out[39]), .T(io_oeb[39]));
(* keep, BEL="X0Y7.C" *) IO_1_bidirectional_frame_config_pass io38_i (.O(io_in[38]), .I(io_out[38]), .T(io_oeb[38]));
(* keep, BEL="X0Y7.B" *) IO_1_bidirectional_frame_config_pass io37_i (.O(io_in[37]), .I(io_out[37]), .T(io_oeb[37]));
(* keep, BEL="X0Y7.A" *) IO_1_bidirectional_frame_config_pass io36_i (.O(io_in[36]), .I(io_out[36]), .T(io_oeb[36]));
(* keep, BEL="X0Y8.D" *) IO_1_bidirectional_frame_config_pass io35_i (.O(io_in[35]), .I(io_out[35]), .T(io_oeb[35]));
(* keep, BEL="X0Y8.C" *) IO_1_bidirectional_frame_config_pass io34_i (.O(io_in[34]), .I(io_out[34]), .T(io_oeb[34]));
(* keep, BEL="X0Y8.B" *) IO_1_bidirectional_frame_config_pass io33_i (.O(io_in[33]), .I(io_out[33]), .T(io_oeb[33]));
(* keep, BEL="X0Y8.A" *) IO_1_bidirectional_frame_config_pass io32_i (.O(io_in[32]), .I(io_out[32]), .T(io_oeb[32]));
(* keep, BEL="X0Y9.D" *) IO_1_bidirectional_frame_config_pass io31_i (.O(io_in[31]), .I(io_out[31]), .T(io_oeb[31]));
(* keep, BEL="X0Y9.C" *) IO_1_bidirectional_frame_config_pass io30_i (.O(io_in[30]), .I(io_out[30]), .T(io_oeb[30]));
(* keep, BEL="X0Y9.B" *) IO_1_bidirectional_frame_config_pass io29_i (.O(io_in[29]), .I(io_out[29]), .T(io_oeb[29]));
(* keep, BEL="X0Y9.A" *) IO_1_bidirectional_frame_config_pass io28_i (.O(io_in[28]), .I(io_out[28]), .T(io_oeb[28]));
(* keep, BEL="X0Y10.D" *) IO_1_bidirectional_frame_config_pass io27_i (.O(io_in[27]), .I(io_out[27]), .T(io_oeb[27]));
(* keep, BEL="X0Y10.C" *) IO_1_bidirectional_frame_config_pass io26_i (.O(io_in[26]), .I(io_out[26]), .T(io_oeb[26]));
(* keep, BEL="X0Y10.B" *) IO_1_bidirectional_frame_config_pass io25_i (.O(io_in[25]), .I(io_out[25]), .T(io_oeb[25]));
(* keep, BEL="X0Y10.A" *) IO_1_bidirectional_frame_config_pass io24_i (.O(io_in[24]), .I(io_out[24]), .T(io_oeb[24]));
(* keep, BEL="X0Y11.D" *) IO_1_bidirectional_frame_config_pass io23_i (.O(io_in[23]), .I(io_out[23]), .T(io_oeb[23]));
(* keep, BEL="X0Y11.C" *) IO_1_bidirectional_frame_config_pass io22_i (.O(io_in[22]), .I(io_out[22]), .T(io_oeb[22]));
(* keep, BEL="X0Y11.B" *) IO_1_bidirectional_frame_config_pass io21_i (.O(io_in[21]), .I(io_out[21]), .T(io_oeb[21]));
(* keep, BEL="X0Y11.A" *) IO_1_bidirectional_frame_config_pass io20_i (.O(io_in[20]), .I(io_out[20]), .T(io_oeb[20]));
(* keep, BEL="X0Y12.D" *) IO_1_bidirectional_frame_config_pass io19_i (.O(io_in[19]), .I(io_out[19]), .T(io_oeb[19]));
(* keep, BEL="X0Y12.C" *) IO_1_bidirectional_frame_config_pass io18_i (.O(io_in[18]), .I(io_out[18]), .T(io_oeb[18]));
(* keep, BEL="X0Y12.B" *) IO_1_bidirectional_frame_config_pass io17_i (.O(io_in[17]), .I(io_out[17]), .T(io_oeb[17]));
(* keep, BEL="X0Y12.A" *) IO_1_bidirectional_frame_config_pass io16_i (.O(io_in[16]), .I(io_out[16]), .T(io_oeb[16]));
(* keep, BEL="X0Y13.D" *) IO_1_bidirectional_frame_config_pass io15_i (.O(io_in[15]), .I(io_out[15]), .T(io_oeb[15]));
(* keep, BEL="X0Y13.C" *) IO_1_bidirectional_frame_config_pass io14_i (.O(io_in[14]), .I(io_out[14]), .T(io_oeb[14]));
(* keep, BEL="X0Y13.B" *) IO_1_bidirectional_frame_config_pass io13_i (.O(io_in[13]), .I(io_out[13]), .T(io_oeb[13]));
(* keep, BEL="X0Y13.A" *) IO_1_bidirectional_frame_config_pass io12_i (.O(io_in[12]), .I(io_out[12]), .T(io_oeb[12]));
(* keep, BEL="X0Y14.D" *) IO_1_bidirectional_frame_config_pass io11_i (.O(io_in[11]), .I(io_out[11]), .T(io_oeb[11]));
(* keep, BEL="X0Y14.C" *) IO_1_bidirectional_frame_config_pass io10_i (.O(io_in[10]), .I(io_out[10]), .T(io_oeb[10]));
(* keep, BEL="X0Y14.B" *) IO_1_bidirectional_frame_config_pass io9_i (.O(io_in[9]), .I(io_out[9]), .T(io_oeb[9]));
(* keep, BEL="X0Y14.A" *) IO_1_bidirectional_frame_config_pass io8_i (.O(io_in[8]), .I(io_out[8]), .T(io_oeb[8]));
(* keep, BEL="X0Y15.D" *) IO_1_bidirectional_frame_config_pass io7_i (.O(io_in[7]), .I(io_out[7]), .T(io_oeb[7]));
(* keep, BEL="X0Y15.C" *) IO_1_bidirectional_frame_config_pass io6_i (.O(io_in[6]), .I(io_out[6]), .T(io_oeb[6]));
(* keep, BEL="X0Y15.B" *) IO_1_bidirectional_frame_config_pass io5_i (.O(io_in[5]), .I(io_out[5]), .T(io_oeb[5]));
(* keep, BEL="X0Y15.A" *) IO_1_bidirectional_frame_config_pass io4_i (.O(io_in[4]), .I(io_out[4]), .T(io_oeb[4]));
(* keep, BEL="X0Y16.D" *) IO_1_bidirectional_frame_config_pass io3_i (.O(io_in[3]), .I(io_out[3]), .T(io_oeb[3]));
(* keep, BEL="X0Y16.C" *) IO_1_bidirectional_frame_config_pass io2_i (.O(io_in[2]), .I(io_out[2]), .T(io_oeb[2]));
(* keep, BEL="X0Y16.B" *) IO_1_bidirectional_frame_config_pass io1_i (.O(io_in[1]), .I(io_out[1]), .T(io_oeb[1]));
(* keep, BEL="X0Y16.A" *) IO_1_bidirectional_frame_config_pass io0_i (.O(io_in[0]), .I(io_out[0]), .T(io_oeb[0]));

//for i in range(16):
//    for j, bel in enumerate(reversed(['E', 'F', 'G', 'H'])):
//        print(f'(* keep, BEL="X0Y{i+1}.{bel}" *) Config_access #(.C_bit0(CONFIG_PULL_UP[{64-1-i*4-j}]), .C_bit1(CONFIG_PULL_DOWN[{64-1-i*4-j}]), .C_bit2(CONFIG_SLOW[{64-1-i*4-j}]), .C_bit3(CONFIG_OPEN_DRAIN[{64-1-i*4-j}])) io{64-1-i*4-j}_access_i ();')

(* keep, BEL="X0Y1.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[63]), .C_bit1(CONFIG_PULL_DOWN[63]), .C_bit2(CONFIG_SLOW[63]), .C_bit3(CONFIG_OPEN_DRAIN[63])) io63_access_i ();
(* keep, BEL="X0Y1.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[62]), .C_bit1(CONFIG_PULL_DOWN[62]), .C_bit2(CONFIG_SLOW[62]), .C_bit3(CONFIG_OPEN_DRAIN[62])) io62_access_i ();
(* keep, BEL="X0Y1.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[61]), .C_bit1(CONFIG_PULL_DOWN[61]), .C_bit2(CONFIG_SLOW[61]), .C_bit3(CONFIG_OPEN_DRAIN[61])) io61_access_i ();
(* keep, BEL="X0Y1.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[60]), .C_bit1(CONFIG_PULL_DOWN[60]), .C_bit2(CONFIG_SLOW[60]), .C_bit3(CONFIG_OPEN_DRAIN[60])) io60_access_i ();
(* keep, BEL="X0Y2.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[59]), .C_bit1(CONFIG_PULL_DOWN[59]), .C_bit2(CONFIG_SLOW[59]), .C_bit3(CONFIG_OPEN_DRAIN[59])) io59_access_i ();
(* keep, BEL="X0Y2.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[58]), .C_bit1(CONFIG_PULL_DOWN[58]), .C_bit2(CONFIG_SLOW[58]), .C_bit3(CONFIG_OPEN_DRAIN[58])) io58_access_i ();
(* keep, BEL="X0Y2.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[57]), .C_bit1(CONFIG_PULL_DOWN[57]), .C_bit2(CONFIG_SLOW[57]), .C_bit3(CONFIG_OPEN_DRAIN[57])) io57_access_i ();
(* keep, BEL="X0Y2.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[56]), .C_bit1(CONFIG_PULL_DOWN[56]), .C_bit2(CONFIG_SLOW[56]), .C_bit3(CONFIG_OPEN_DRAIN[56])) io56_access_i ();
(* keep, BEL="X0Y3.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[55]), .C_bit1(CONFIG_PULL_DOWN[55]), .C_bit2(CONFIG_SLOW[55]), .C_bit3(CONFIG_OPEN_DRAIN[55])) io55_access_i ();
(* keep, BEL="X0Y3.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[54]), .C_bit1(CONFIG_PULL_DOWN[54]), .C_bit2(CONFIG_SLOW[54]), .C_bit3(CONFIG_OPEN_DRAIN[54])) io54_access_i ();
(* keep, BEL="X0Y3.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[53]), .C_bit1(CONFIG_PULL_DOWN[53]), .C_bit2(CONFIG_SLOW[53]), .C_bit3(CONFIG_OPEN_DRAIN[53])) io53_access_i ();
(* keep, BEL="X0Y3.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[52]), .C_bit1(CONFIG_PULL_DOWN[52]), .C_bit2(CONFIG_SLOW[52]), .C_bit3(CONFIG_OPEN_DRAIN[52])) io52_access_i ();
(* keep, BEL="X0Y4.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[51]), .C_bit1(CONFIG_PULL_DOWN[51]), .C_bit2(CONFIG_SLOW[51]), .C_bit3(CONFIG_OPEN_DRAIN[51])) io51_access_i ();
(* keep, BEL="X0Y4.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[50]), .C_bit1(CONFIG_PULL_DOWN[50]), .C_bit2(CONFIG_SLOW[50]), .C_bit3(CONFIG_OPEN_DRAIN[50])) io50_access_i ();
(* keep, BEL="X0Y4.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[49]), .C_bit1(CONFIG_PULL_DOWN[49]), .C_bit2(CONFIG_SLOW[49]), .C_bit3(CONFIG_OPEN_DRAIN[49])) io49_access_i ();
(* keep, BEL="X0Y4.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[48]), .C_bit1(CONFIG_PULL_DOWN[48]), .C_bit2(CONFIG_SLOW[48]), .C_bit3(CONFIG_OPEN_DRAIN[48])) io48_access_i ();
(* keep, BEL="X0Y5.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[47]), .C_bit1(CONFIG_PULL_DOWN[47]), .C_bit2(CONFIG_SLOW[47]), .C_bit3(CONFIG_OPEN_DRAIN[47])) io47_access_i ();
(* keep, BEL="X0Y5.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[46]), .C_bit1(CONFIG_PULL_DOWN[46]), .C_bit2(CONFIG_SLOW[46]), .C_bit3(CONFIG_OPEN_DRAIN[46])) io46_access_i ();
(* keep, BEL="X0Y5.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[45]), .C_bit1(CONFIG_PULL_DOWN[45]), .C_bit2(CONFIG_SLOW[45]), .C_bit3(CONFIG_OPEN_DRAIN[45])) io45_access_i ();
(* keep, BEL="X0Y5.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[44]), .C_bit1(CONFIG_PULL_DOWN[44]), .C_bit2(CONFIG_SLOW[44]), .C_bit3(CONFIG_OPEN_DRAIN[44])) io44_access_i ();
(* keep, BEL="X0Y6.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[43]), .C_bit1(CONFIG_PULL_DOWN[43]), .C_bit2(CONFIG_SLOW[43]), .C_bit3(CONFIG_OPEN_DRAIN[43])) io43_access_i ();
(* keep, BEL="X0Y6.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[42]), .C_bit1(CONFIG_PULL_DOWN[42]), .C_bit2(CONFIG_SLOW[42]), .C_bit3(CONFIG_OPEN_DRAIN[42])) io42_access_i ();
(* keep, BEL="X0Y6.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[41]), .C_bit1(CONFIG_PULL_DOWN[41]), .C_bit2(CONFIG_SLOW[41]), .C_bit3(CONFIG_OPEN_DRAIN[41])) io41_access_i ();
(* keep, BEL="X0Y6.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[40]), .C_bit1(CONFIG_PULL_DOWN[40]), .C_bit2(CONFIG_SLOW[40]), .C_bit3(CONFIG_OPEN_DRAIN[40])) io40_access_i ();
(* keep, BEL="X0Y7.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[39]), .C_bit1(CONFIG_PULL_DOWN[39]), .C_bit2(CONFIG_SLOW[39]), .C_bit3(CONFIG_OPEN_DRAIN[39])) io39_access_i ();
(* keep, BEL="X0Y7.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[38]), .C_bit1(CONFIG_PULL_DOWN[38]), .C_bit2(CONFIG_SLOW[38]), .C_bit3(CONFIG_OPEN_DRAIN[38])) io38_access_i ();
(* keep, BEL="X0Y7.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[37]), .C_bit1(CONFIG_PULL_DOWN[37]), .C_bit2(CONFIG_SLOW[37]), .C_bit3(CONFIG_OPEN_DRAIN[37])) io37_access_i ();
(* keep, BEL="X0Y7.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[36]), .C_bit1(CONFIG_PULL_DOWN[36]), .C_bit2(CONFIG_SLOW[36]), .C_bit3(CONFIG_OPEN_DRAIN[36])) io36_access_i ();
(* keep, BEL="X0Y8.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[35]), .C_bit1(CONFIG_PULL_DOWN[35]), .C_bit2(CONFIG_SLOW[35]), .C_bit3(CONFIG_OPEN_DRAIN[35])) io35_access_i ();
(* keep, BEL="X0Y8.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[34]), .C_bit1(CONFIG_PULL_DOWN[34]), .C_bit2(CONFIG_SLOW[34]), .C_bit3(CONFIG_OPEN_DRAIN[34])) io34_access_i ();
(* keep, BEL="X0Y8.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[33]), .C_bit1(CONFIG_PULL_DOWN[33]), .C_bit2(CONFIG_SLOW[33]), .C_bit3(CONFIG_OPEN_DRAIN[33])) io33_access_i ();
(* keep, BEL="X0Y8.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[32]), .C_bit1(CONFIG_PULL_DOWN[32]), .C_bit2(CONFIG_SLOW[32]), .C_bit3(CONFIG_OPEN_DRAIN[32])) io32_access_i ();
(* keep, BEL="X0Y9.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[31]), .C_bit1(CONFIG_PULL_DOWN[31]), .C_bit2(CONFIG_SLOW[31]), .C_bit3(CONFIG_OPEN_DRAIN[31])) io31_access_i ();
(* keep, BEL="X0Y9.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[30]), .C_bit1(CONFIG_PULL_DOWN[30]), .C_bit2(CONFIG_SLOW[30]), .C_bit3(CONFIG_OPEN_DRAIN[30])) io30_access_i ();
(* keep, BEL="X0Y9.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[29]), .C_bit1(CONFIG_PULL_DOWN[29]), .C_bit2(CONFIG_SLOW[29]), .C_bit3(CONFIG_OPEN_DRAIN[29])) io29_access_i ();
(* keep, BEL="X0Y9.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[28]), .C_bit1(CONFIG_PULL_DOWN[28]), .C_bit2(CONFIG_SLOW[28]), .C_bit3(CONFIG_OPEN_DRAIN[28])) io28_access_i ();
(* keep, BEL="X0Y10.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[27]), .C_bit1(CONFIG_PULL_DOWN[27]), .C_bit2(CONFIG_SLOW[27]), .C_bit3(CONFIG_OPEN_DRAIN[27])) io27_access_i ();
(* keep, BEL="X0Y10.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[26]), .C_bit1(CONFIG_PULL_DOWN[26]), .C_bit2(CONFIG_SLOW[26]), .C_bit3(CONFIG_OPEN_DRAIN[26])) io26_access_i ();
(* keep, BEL="X0Y10.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[25]), .C_bit1(CONFIG_PULL_DOWN[25]), .C_bit2(CONFIG_SLOW[25]), .C_bit3(CONFIG_OPEN_DRAIN[25])) io25_access_i ();
(* keep, BEL="X0Y10.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[24]), .C_bit1(CONFIG_PULL_DOWN[24]), .C_bit2(CONFIG_SLOW[24]), .C_bit3(CONFIG_OPEN_DRAIN[24])) io24_access_i ();
(* keep, BEL="X0Y11.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[23]), .C_bit1(CONFIG_PULL_DOWN[23]), .C_bit2(CONFIG_SLOW[23]), .C_bit3(CONFIG_OPEN_DRAIN[23])) io23_access_i ();
(* keep, BEL="X0Y11.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[22]), .C_bit1(CONFIG_PULL_DOWN[22]), .C_bit2(CONFIG_SLOW[22]), .C_bit3(CONFIG_OPEN_DRAIN[22])) io22_access_i ();
(* keep, BEL="X0Y11.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[21]), .C_bit1(CONFIG_PULL_DOWN[21]), .C_bit2(CONFIG_SLOW[21]), .C_bit3(CONFIG_OPEN_DRAIN[21])) io21_access_i ();
(* keep, BEL="X0Y11.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[20]), .C_bit1(CONFIG_PULL_DOWN[20]), .C_bit2(CONFIG_SLOW[20]), .C_bit3(CONFIG_OPEN_DRAIN[20])) io20_access_i ();
(* keep, BEL="X0Y12.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[19]), .C_bit1(CONFIG_PULL_DOWN[19]), .C_bit2(CONFIG_SLOW[19]), .C_bit3(CONFIG_OPEN_DRAIN[19])) io19_access_i ();
(* keep, BEL="X0Y12.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[18]), .C_bit1(CONFIG_PULL_DOWN[18]), .C_bit2(CONFIG_SLOW[18]), .C_bit3(CONFIG_OPEN_DRAIN[18])) io18_access_i ();
(* keep, BEL="X0Y12.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[17]), .C_bit1(CONFIG_PULL_DOWN[17]), .C_bit2(CONFIG_SLOW[17]), .C_bit3(CONFIG_OPEN_DRAIN[17])) io17_access_i ();
(* keep, BEL="X0Y12.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[16]), .C_bit1(CONFIG_PULL_DOWN[16]), .C_bit2(CONFIG_SLOW[16]), .C_bit3(CONFIG_OPEN_DRAIN[16])) io16_access_i ();
(* keep, BEL="X0Y13.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[15]), .C_bit1(CONFIG_PULL_DOWN[15]), .C_bit2(CONFIG_SLOW[15]), .C_bit3(CONFIG_OPEN_DRAIN[15])) io15_access_i ();
(* keep, BEL="X0Y13.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[14]), .C_bit1(CONFIG_PULL_DOWN[14]), .C_bit2(CONFIG_SLOW[14]), .C_bit3(CONFIG_OPEN_DRAIN[14])) io14_access_i ();
(* keep, BEL="X0Y13.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[13]), .C_bit1(CONFIG_PULL_DOWN[13]), .C_bit2(CONFIG_SLOW[13]), .C_bit3(CONFIG_OPEN_DRAIN[13])) io13_access_i ();
(* keep, BEL="X0Y13.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[12]), .C_bit1(CONFIG_PULL_DOWN[12]), .C_bit2(CONFIG_SLOW[12]), .C_bit3(CONFIG_OPEN_DRAIN[12])) io12_access_i ();
(* keep, BEL="X0Y14.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[11]), .C_bit1(CONFIG_PULL_DOWN[11]), .C_bit2(CONFIG_SLOW[11]), .C_bit3(CONFIG_OPEN_DRAIN[11])) io11_access_i ();
(* keep, BEL="X0Y14.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[10]), .C_bit1(CONFIG_PULL_DOWN[10]), .C_bit2(CONFIG_SLOW[10]), .C_bit3(CONFIG_OPEN_DRAIN[10])) io10_access_i ();
(* keep, BEL="X0Y14.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[9]), .C_bit1(CONFIG_PULL_DOWN[9]), .C_bit2(CONFIG_SLOW[9]), .C_bit3(CONFIG_OPEN_DRAIN[9])) io9_access_i ();
(* keep, BEL="X0Y14.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[8]), .C_bit1(CONFIG_PULL_DOWN[8]), .C_bit2(CONFIG_SLOW[8]), .C_bit3(CONFIG_OPEN_DRAIN[8])) io8_access_i ();
(* keep, BEL="X0Y15.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[7]), .C_bit1(CONFIG_PULL_DOWN[7]), .C_bit2(CONFIG_SLOW[7]), .C_bit3(CONFIG_OPEN_DRAIN[7])) io7_access_i ();
(* keep, BEL="X0Y15.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[6]), .C_bit1(CONFIG_PULL_DOWN[6]), .C_bit2(CONFIG_SLOW[6]), .C_bit3(CONFIG_OPEN_DRAIN[6])) io6_access_i ();
(* keep, BEL="X0Y15.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[5]), .C_bit1(CONFIG_PULL_DOWN[5]), .C_bit2(CONFIG_SLOW[5]), .C_bit3(CONFIG_OPEN_DRAIN[5])) io5_access_i ();
(* keep, BEL="X0Y15.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[4]), .C_bit1(CONFIG_PULL_DOWN[4]), .C_bit2(CONFIG_SLOW[4]), .C_bit3(CONFIG_OPEN_DRAIN[4])) io4_access_i ();
(* keep, BEL="X0Y16.H" *) Config_access #(.C_bit0(CONFIG_PULL_UP[3]), .C_bit1(CONFIG_PULL_DOWN[3]), .C_bit2(CONFIG_SLOW[3]), .C_bit3(CONFIG_OPEN_DRAIN[3])) io3_access_i ();
(* keep, BEL="X0Y16.G" *) Config_access #(.C_bit0(CONFIG_PULL_UP[2]), .C_bit1(CONFIG_PULL_DOWN[2]), .C_bit2(CONFIG_SLOW[2]), .C_bit3(CONFIG_OPEN_DRAIN[2])) io2_access_i ();
(* keep, BEL="X0Y16.F" *) Config_access #(.C_bit0(CONFIG_PULL_UP[1]), .C_bit1(CONFIG_PULL_DOWN[1]), .C_bit2(CONFIG_SLOW[1]), .C_bit3(CONFIG_OPEN_DRAIN[1])) io1_access_i ();
(* keep, BEL="X0Y16.E" *) Config_access #(.C_bit0(CONFIG_PULL_UP[0]), .C_bit1(CONFIG_PULL_DOWN[0]), .C_bit2(CONFIG_SLOW[0]), .C_bit3(CONFIG_OPEN_DRAIN[0])) io0_access_i ();

wire clk;
(* keep *) Global_Clock clk_i (.CLK(clk));

top top_i(.clk(clk), .io_in(io_in), .io_out(io_out), .io_oeb(io_oeb));

endmodule

