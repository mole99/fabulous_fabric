FABRIC_NUM_IO_WEST = 64
BELS_PER_IO_TILE = ['A', 'B', 'C', 'D']
NUM_SRAM = 8
SRAM_NUM_WMASKS = 4
SRAM_ADDR_WIDTH = 8
SRAM_DATA_WIDTH = 32
NUM_ADC=2
NUM_DAC=2

print(f'------------------ header ------------------\n')

print(f'    // Fabric is configured')
print("""    input                                configured_i,\n""")

# I/Os
print(f'    // I/Os West')
print("""    input  [FABRIC_NUM_IO_WEST-1:0]      io_west_in_i,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_out_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_oe_o,\n""")

print(f'    // I/O West config')
print("""    output [FABRIC_NUM_IO_WEST-1:0]      io_west_config_bit0_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_config_bit1_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_config_bit2_o,
    output [FABRIC_NUM_IO_WEST-1:0]      io_west_config_bit3_o,\n""")

# WARMBOOT
print(f'    // WARMBOOT')
print("""    output        warmboot_boot_o,""")
print("""    output  [3:0] warmboot_slot_o,""")
print("""    input         warmboot_reset_i,\n""")

# ADC
for i in range(NUM_ADC):
    print(f'    // ADC {i}')
    print(f"""    input         adc{i}_cmp_i,
    output        adc{i}_hold_o,
    output        adc{i}_reset_o,
    output [11:0] adc{i}_value_o,\n""")

# DAC
for i in range(NUM_DAC):
    print(f'    // DAC {i}')
    print(f"""    output [7:0] dac{i}_value_o,""")
    print(f"""    output       dac{i}_enable_o,\n""")

print(f'------------------ signals ------------------\n')

# SRAM
for i in range(NUM_SRAM):
    print(f'    // SRAM {i}')
    print(f"""    logic sram{i}_clk0; // clock
    logic sram{i}_csb0; // active low chip select
    logic sram{i}_web0; // active low write control
    logic [{SRAM_NUM_WMASKS}-1:0] sram{i}_wmask0; // write mask
    logic [{SRAM_ADDR_WIDTH}-1:0] sram{i}_addr0;
    logic [{SRAM_DATA_WIDTH}-1:0] sram{i}_din0;
    logic [{SRAM_DATA_WIDTH}-1:0] sram{i}_dout0;
    logic sram{i}_clk1; // clock
    logic sram{i}_csb1; // active low chip select
    logic [{SRAM_ADDR_WIDTH}-1:0] sram{i}_addr1;
    logic [{SRAM_DATA_WIDTH}-1:0] sram{i}_dout1;\n""")

print(f'------------------ body ------------------\n')

# I/Os
print(f"""        // West I/Os""")
num_bels = len(BELS_PER_IO_TILE)
for i in range(1,(FABRIC_NUM_IO_WEST//num_bels)+1):
    for j, bel in enumerate(BELS_PER_IO_TILE):
        print(f"""        .Tile_X0Y{i}_{bel}_O_top(io_west_in_i[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),
        .Tile_X0Y{i}_{bel}_I_top(io_west_out_o[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),
        .Tile_X0Y{i}_{bel}_T_top(io_west_oe_o[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),\n""")

        print(f"""        .Tile_X0Y{i}_{bel}_config_C_bit0(io_west_config_bit0_o[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),
        .Tile_X0Y{i}_{bel}_config_C_bit1(io_west_config_bit1_o[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),
        .Tile_X0Y{i}_{bel}_config_C_bit2(io_west_config_bit2_o[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),
        .Tile_X0Y{i}_{bel}_config_C_bit3(io_west_config_bit3_o[{FABRIC_NUM_IO_WEST-i*num_bels+j}]),\n""")

# WARMBOOT
warmboot_coords = 'X1Y17'
print('        // WARMBOOT')
print(f"""        .Tile_{warmboot_coords}_RESET_top(warmboot_reset_i),
        .Tile_{warmboot_coords}_BOOT_top(warmboot_boot_o),
        .Tile_{warmboot_coords}_SLOT_top0(warmboot_slot_o[0]),
        .Tile_{warmboot_coords}_SLOT_top1(warmboot_slot_o[1]),
        .Tile_{warmboot_coords}_SLOT_top2(warmboot_slot_o[2]),
        .Tile_{warmboot_coords}_SLOT_top3(warmboot_slot_o[3]),
        .Tile_{warmboot_coords}_CONFIGURED_top(configured_i),\n""")

# ADC
adc_coords = 'Y17'
start_x = 5
for i in range(NUM_ADC):
    print(f"""        // ADC {i}
        .Tile_X{i+start_x}{adc_coords}_CMP_top(adc{i}_cmp_i),
        .Tile_X{i+start_x}{adc_coords}_HOLD_top(adc{i}_hold_o),
        .Tile_X{i+start_x}{adc_coords}_RESET_top(adc{i}_reset_o),""")
    for j in range(12):
        print(f"""        .Tile_X{i+start_x}{adc_coords}_VALUE_top{j}(adc{i}_value_o[{j}]),""")
    print('')

# DAC
start_x = 7
dac_coords = 'Y17'
for i in range(NUM_DAC):
    print(f'        // DAC {i}')
    for j in range(8):
        print(f"""        .Tile_X{i+start_x}{adc_coords}_VALUE_top{j}(dac{i}_value_o[{j}]),""")
    print(f"""        .Tile_X{i+start_x}{adc_coords}_ENABLE_top(dac{i}_enable_o),""")
    print('')

# SRAM
sram_coords = 'X13'
for i in range(NUM_SRAM):
    print(f'        // SRAM {i}')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_CLK_A_SRAM(sram{i}_clk0),')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_CSB_A_SRAM(sram{i}_csb0),')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_WEB_A_SRAM(sram{i}_web0),')
    for j in range(SRAM_NUM_WMASKS):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_WMASK_A_SRAM{j}(sram{i}_wmask0[{j}]),')
    for j in range(SRAM_ADDR_WIDTH):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_ADDR_A_SRAM{j}(sram{i}_addr0[{j}]),')
    for j in range(SRAM_DATA_WIDTH):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_DIN_A_SRAM{j}(sram{i}_din0[{j}]),')
    for j in range(SRAM_DATA_WIDTH):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_DOUT_A_SRAM{j}(sram{i}_dout0[{j}]),')

    print(f'        .Tile_{sram_coords}Y{2+i*2}_CLK_B_SRAM(sram{i}_clk1),')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_CSB_B_SRAM(sram{i}_csb1),')
    for j in range(SRAM_ADDR_WIDTH):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_ADDR_B_SRAM{j}(sram{i}_addr1[{j}]),')
    for j in range(SRAM_DATA_WIDTH):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_DOUT_B_SRAM{j}(sram{i}_dout1[{j}]),')

    print(f'        .Tile_{sram_coords}Y{2+i*2}_CONFIGURED_top(configured_i),')
    print('')

print(f'------------------ modules ------------------\n')

for i in range(NUM_SRAM):

    print(f"""    sky130_sram_1kbyte_1rw1r_32x256_8 bram_{i}(
    `ifdef USE_POWER_PINS
        .vccd1  (VPWR),
        .vssd1  (VGND),
    `endif
        // Port 0: RW
        .clk0    (sram{i}_clk0),
        .csb0    (sram{i}_csb0),
        .web0    (sram{i}_web0),
        .wmask0  (sram{i}_wmask0),
        .addr0   (sram{i}_addr0),
        .din0    (sram{i}_din0),
        .dout0   (sram{i}_dout0),
        // Port 1: R
        .clk1    (sram{i}_clk1),
        .csb1    (sram{i}_csb1),
        .addr1   (sram{i}_addr1),
        .dout1   (sram{i}_dout1)
    );\n""")
