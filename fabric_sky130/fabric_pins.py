
NUM_SRAM = 8
NUM_N_IO = 16//2
NUM_W_IO = 32//2

def main():
    with open('fabric_pins.cfg', 'w') as f:
        f.write('#N\n\n')
        
        f.write(f'$4\n')
        
        for i in [1, 2, 4, 5, 6, 8, 9, 10]:
            f.write(f'Tile_X{i}Y0_A_O_top\n')
            f.write(f'Tile_X{i}Y0_A_I_top\n')
            f.write(f'Tile_X{i}Y0_A_T_top\n')
            f.write(f'Tile_X{i}Y0_B_O_top\n')
            f.write(f'Tile_X{i}Y0_B_I_top\n')
            f.write(f'Tile_X{i}Y0_B_T_top\n')
            
            f.write(f'Tile_X{i}Y0_A_config_C_bit0\n')
            f.write(f'Tile_X{i}Y0_A_config_C_bit1\n')
            f.write(f'Tile_X{i}Y0_A_config_C_bit2\n')
            f.write(f'Tile_X{i}Y0_A_config_C_bit3\n')
            f.write(f'Tile_X{i}Y0_B_config_C_bit0\n')
            f.write(f'Tile_X{i}Y0_B_config_C_bit1\n')
            f.write(f'Tile_X{i}Y0_B_config_C_bit2\n')
            f.write(f'Tile_X{i}Y0_B_config_C_bit3\n')
        
        f.write(f'$4\n')
        
        f.write('#E\n\n')
        
        f.write(f'$32\n')
        
        for i in reversed(range(NUM_SRAM)):
            for bit in range(32):
                f.write(f'Tile_X11Y{2+i*2}_DO_SRAM{bit}\n')
            
            for bit in range(10):
                f.write(f'Tile_X11Y{2+i*2}_AD_SRAM{bit}\n')
            
            for bit in range(32):
                f.write(f'Tile_X11Y{2+i*2}_BEN_SRAM{bit}\n')
            
            f.write(f'Tile_X11Y{2+i*2}_CLOCK_SRAM\n')
            
            for bit in range(32):
                f.write(f'Tile_X11Y{2+i*2}_DI_SRAM{bit}\n')
                
            f.write(f'Tile_X11Y{2+i*2}_EN_SRAM\n')
            f.write(f'Tile_X11Y{2+i*2}_R_WB_SRAM\n')
            
        f.write(f'$32\n')

        f.write('#S\n\n')
        
        f.write(f'UserCLK\n')
        f.write(f'$4\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit}\\]\n')
        
        f.write(f'Tile_X1Y17_IRQ_top0\n')
        f.write(f'Tile_X1Y17_IRQ_top1\n')
        f.write(f'Tile_X1Y17_IRQ_top2\n')
        f.write(f'Tile_X1Y17_IRQ_top3\n')

        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+1*20}\\]\n')
        
        f.write(f'Tile_X2Y17_RESET_top\n')
        f.write(f'Tile_X2Y17_BOOT_top\n')
        f.write(f'Tile_X2Y17_SLOT_top0\n')
        f.write(f'Tile_X2Y17_SLOT_top1\n')
        f.write(f'Tile_X2Y17_SLOT_top2\n')
        f.write(f'Tile_X2Y17_SLOT_top3\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+2*20}\\]\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+3*20}\\]\n')
        
        for bit in range(16):
            f.write(f'Tile_X4Y17_O_top{bit}\n')
        
        for bit in range(16):
            f.write(f'Tile_X4Y17_I_top{bit}\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+4*20}\\]\n')
        
        for bit in range(16):
            f.write(f'Tile_X5Y17_O_top{bit}\n')
        
        for bit in range(16):
            f.write(f'Tile_X5Y17_I_top{bit}\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+5*20}\\]\n')
        
        for bit in range(16):
            f.write(f'Tile_X6Y17_O_top{bit}\n')
        
        for bit in range(16):
            f.write(f'Tile_X6Y17_I_top{bit}\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+6*20}\\]\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+7*20}\\]\n')
        
        for bit in range(16):
            f.write(f'Tile_X8Y17_O_top{bit}\n')
        
        for bit in range(16):
            f.write(f'Tile_X8Y17_I_top{bit}\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+8*20}\\]\n')
        
        f.write(f'Tile_X9Y17_CMP_top\n')
        f.write(f'Tile_X9Y17_HOLD_top\n')
        f.write(f'Tile_X9Y17_RESET_top\n')
        
        for bit in range(12):
            f.write(f'Tile_X9Y17_VALUE_top{bit}\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+9*20}\\]\n')
        
        for bit in range(8):
            f.write(f'Tile_X10Y17_VALUE_top{bit}\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+10*20}\\]\n')
        
        for bit in range(20):
            f.write(f'FrameStrobe\\[{bit+11*20}\\]\n')
        
        f.write('#W\n\n')
        
        for bit in range(32):
            f.write(f'FrameData\\[{bit+17*32}\\]\n')
        
        for i in reversed(range(NUM_W_IO)):
            
            f.write(f'Tile_X0Y{i+1}_A_O_top\n')
            f.write(f'Tile_X0Y{i+1}_A_I_top\n')
            f.write(f'Tile_X0Y{i+1}_A_T_top\n')
            f.write(f'Tile_X0Y{i+1}_B_O_top\n')
            f.write(f'Tile_X0Y{i+1}_B_I_top\n')
            f.write(f'Tile_X0Y{i+1}_B_T_top\n')
            
            f.write(f'Tile_X0Y{i+1}_A_config_C_bit0\n')
            f.write(f'Tile_X0Y{i+1}_A_config_C_bit1\n')
            f.write(f'Tile_X0Y{i+1}_A_config_C_bit2\n')
            f.write(f'Tile_X0Y{i+1}_A_config_C_bit3\n')
            f.write(f'Tile_X0Y{i+1}_B_config_C_bit0\n')
            f.write(f'Tile_X0Y{i+1}_B_config_C_bit1\n')
            f.write(f'Tile_X0Y{i+1}_B_config_C_bit2\n')
            f.write(f'Tile_X0Y{i+1}_B_config_C_bit3\n')
            
            for bit in range(32):
                f.write(f'FrameData\\[{bit+(i+1)*32}\\]\n')
        
        for bit in range(32):
            f.write(f'FrameData\\[{bit}\\]\n')
                
        
        
    
if __name__ == "__main__":
    main()
