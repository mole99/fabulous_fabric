FABRIC_NUM_IO_WEST = 32
FABRIC_NUM_IO_NORTH = 16
NUM_SRAM = 8

print(f'------------------ header ------------------\n')

# I/Os
print(f'    // I/Os West')
print("""    input  [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_in_i,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_out_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_oeb_o,\n""")

print(f'    // I/O West config')
print("""    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config_bit0_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config_bit1_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config_bit2_o,
    output [FABRIC_NUM_IO_WEST-1:0]      fabric_io_west_config_bit3_o,\n""")

print(f'    // I/Os North')
print("""    input  [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_in_i,
    output [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_out_o,
    output [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_oeb_o,\n""")

print(f'    // I/O North config')
print("""    output [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_config_bit0_o,
    output [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_config_bit1_o,
    output [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_config_bit2_o,
    output [FABRIC_NUM_IO_NORTH-1:0]      fabric_io_north_config_bit3_o,\n""")

# ADC
print(f'    // ADC')
print("""    input         fabric_adc0_cmp_i,
    output        fabric_adc0_hold_o,
    output        fabric_adc0_reset_o,
    output [11:0] fabric_adc0_value_o,\n""")

# DAC
print(f'    // DAC')
print("""    output [7:0] fabric_dac0_value_o,\n""")

# SRAM
for i in range(NUM_SRAM):
    print(f'    // SRAM {i}')
    print(f"""    input  [31:0] fabric_sram{i}_do_i,
    output [9 :0] fabric_sram{i}_ad_o,
    output [31:0] fabric_sram{i}_ben_o,
    output [31:0] fabric_sram{i}_di_o,
    output        fabric_sram{i}_en_o,
    output        fabric_sram{i}_rw_no,
    output        fabric_sram{i}_clk_o,\n""")

# WARMBOOT
print(f'    // WARMBOOT')
print("""    output        fabric_warmboot_boot_o,""")
print("""    output  [3:0] fabric_warmboot_slot_o,""")
print("""    input         fabric_warmboot_reset_i,\n""")

# CPU_IRQ
print(f'    // CPU_IRQ')
print("""    output  [3:0] fabric_irq_o,\n""")

# CPU_IF
print(f'    // CPU_IF')
print("""    output  [63:0] fabric_cpu_o,""")
print("""    input   [63:0] fabric_cpu_i,\n""")

print(f'------------------ body ------------------\n')

# I/Os
print(f"""        // West I/Os""")
for i in range(1,(FABRIC_NUM_IO_WEST//2)+1):
    print(f"""        .Tile_X0Y{i}_A_O_top(fabric_io_west_in_i[{FABRIC_NUM_IO_WEST-i*2+1}]),
        .Tile_X0Y{i}_A_I_top(fabric_io_west_out_o[{FABRIC_NUM_IO_WEST-i*2+1}]),
        .Tile_X0Y{i}_A_T_top(fabric_io_west_oeb_o[{FABRIC_NUM_IO_WEST-i*2+1}]),\n""")

    print(f"""        .Tile_X0Y{i}_B_O_top(fabric_io_west_in_i[{FABRIC_NUM_IO_WEST-i*2}]),
        .Tile_X0Y{i}_B_I_top(fabric_io_west_out_o[{FABRIC_NUM_IO_WEST-i*2}]),
        .Tile_X0Y{i}_B_T_top(fabric_io_west_oeb_o[{FABRIC_NUM_IO_WEST-i*2}]),\n""")

    print(f"""        .Tile_X0Y{i}_A_config_C_bit0(fabric_io_west_config_bit0_o[{FABRIC_NUM_IO_WEST-i*2+1}]),
        .Tile_X0Y{i}_A_config_C_bit1(fabric_io_west_config_bit1_o[{FABRIC_NUM_IO_WEST-i*2+1}]),
        .Tile_X0Y{i}_A_config_C_bit2(fabric_io_west_config_bit2_o[{FABRIC_NUM_IO_WEST-i*2+1}]),
        .Tile_X0Y{i}_A_config_C_bit3(fabric_io_west_config_bit3_o[{FABRIC_NUM_IO_WEST-i*2+1}]),\n""")
        
    print(f"""        .Tile_X0Y{i}_B_config_C_bit0(fabric_io_west_config_bit0_o[{FABRIC_NUM_IO_WEST-i*2}]),
        .Tile_X0Y{i}_B_config_C_bit1(fabric_io_west_config_bit1_o[{FABRIC_NUM_IO_WEST-i*2}]),
        .Tile_X0Y{i}_B_config_C_bit2(fabric_io_west_config_bit2_o[{FABRIC_NUM_IO_WEST-i*2}]),
        .Tile_X0Y{i}_B_config_C_bit3(fabric_io_west_config_bit3_o[{FABRIC_NUM_IO_WEST-i*2}]),\n""")

print(f"""        // North I/Os""")
for index, i in enumerate([1, 2, 4, 5, 6, 8, 9, 10]):
    print(f"""        .Tile_X{i}Y0_A_O_top(fabric_io_north_in_i[{index*2+1}]),
        .Tile_X{i}Y0_A_I_top(fabric_io_north_out_o[{index*2+1}]),
        .Tile_X{i}Y0_A_T_top(fabric_io_north_oeb_o[{index*2+1}]),\n""")

    print(f"""        .Tile_X{i}Y0_B_O_top(fabric_io_north_in_i[{index*2}]),
        .Tile_X{i}Y0_B_I_top(fabric_io_north_out_o[{index*2}]),
        .Tile_X{i}Y0_B_T_top(fabric_io_north_oeb_o[{index*2}]),\n""")

    print(f"""        .Tile_X{i}Y0_A_config_C_bit0(fabric_io_north_config_bit0_o[{index*2+1}]),
        .Tile_X{i}Y0_A_config_C_bit1(fabric_io_north_config_bit1_o[{index*2+1}]),
        .Tile_X{i}Y0_A_config_C_bit2(fabric_io_north_config_bit2_o[{index*2+1}]),
        .Tile_X{i}Y0_A_config_C_bit3(fabric_io_north_config_bit3_o[{index*2+1}]),\n""")
        
    print(f"""        .Tile_X{i}Y0_B_config_C_bit0(fabric_io_north_config_bit0_o[{index*2}]),
        .Tile_X{i}Y0_B_config_C_bit1(fabric_io_north_config_bit1_o[{index*2}]),
        .Tile_X{i}Y0_B_config_C_bit2(fabric_io_north_config_bit2_o[{index*2}]),
        .Tile_X{i}Y0_B_config_C_bit3(fabric_io_north_config_bit3_o[{index*2}]),\n""")

# ADC
adc_coords = 'X9Y17'
print(f"""        // ADC
        .Tile_{adc_coords}_CMP_top(fabric_adc0_cmp_i),
        .Tile_{adc_coords}_HOLD_top(fabric_adc0_hold_o),
        .Tile_{adc_coords}_RESET_top(fabric_adc0_reset_o),""")
for i in range(12):
    print(f"""        .Tile_{adc_coords}_VALUE_top{i}(fabric_adc0_value_o[{i}]),""")
print('')

# DAC
dac_coords = 'X10Y17'
print('        // DAC')
for i in range(8):
    print(f"""        .Tile_{dac_coords}_VALUE_top{i}(fabric_dac0_value_o[{i}]),""")
print('')

# SRAM
sram_coords = 'X11'
for i in range(NUM_SRAM):
    print(f'        // SRAM {i}')
    for j in range(32):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_DO_SRAM{j}(fabric_sram{i}_do_i[{j}]),')
    for j in range(10):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_AD_SRAM{j}(fabric_sram{i}_ad_o[{j}]),')
    for j in range(32):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_BEN_SRAM{j}(fabric_sram{i}_ben_o[{j}]),')
    for j in range(32):
        print(f'        .Tile_{sram_coords}Y{2+i*2}_DI_SRAM{j}(fabric_sram{i}_di_o[{j}]),')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_EN_SRAM(fabric_sram{i}_en),')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_R_WB_SRAM(fabric_sram{i}_rw_no),')
    print(f'        .Tile_{sram_coords}Y{2+i*2}_CLOCK_SRAM(fabric_sram{i}_clk_o),')
    print('')

# WARMBOOT
warmboot_coords = 'X2Y17'
print('        // WARMBOOT')
print(f"""        .Tile_{warmboot_coords}_RESET_top(fabric_warmboot_reset_i),
        .Tile_{warmboot_coords}_BOOT_top(fabric_warmboot_boot),
        .Tile_{warmboot_coords}_SLOT_top0(fabric_warmboot_slot_o[0]),
        .Tile_{warmboot_coords}_SLOT_top1(fabric_warmboot_slot_o[1]),
        .Tile_{warmboot_coords}_SLOT_top2(fabric_warmboot_slot_o[2]),
        .Tile_{warmboot_coords}_SLOT_top3(fabric_warmboot_slot_o[3]),\n""")

# IRQ
irq_coords = 'X1Y17'
print('        // IRQ')
print(f"""        .Tile_{irq_coords}_IRQ_top0(fabric_irq[0]),
        .Tile_{irq_coords}_IRQ_top1(fabric_irq[1]),
        .Tile_{irq_coords}_IRQ_top2(fabric_irq[2]),
        .Tile_{irq_coords}_IRQ_top3(fabric_irq[3]),\n""")

for index, i in enumerate([4, 5, 6, 8]):
    print(f'        // CPU_IF {index}')
    for j in range(16):
        print(f'        .Tile_X{i}Y17_I_top{j}(fabric_cpu_o[{16*index+j}]),')
    for j in range(16):
        print(f'        .Tile_X{i}Y17_O_top{j}(fabric_cpu_i[{16*index+j}]),')
    print('')
