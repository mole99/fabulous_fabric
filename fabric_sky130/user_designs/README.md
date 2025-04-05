## User Designs

| Name      | Description |
|-----------|-------------|
| `all_zeros` | all outputs set to zero |
| `all_ones`  | all outputs set to one |
| `counter`   | 32-bit counter |
| `passthrough` | inputs connected to outputs |
| `sram` | all SRAMs muxed together |
| `adc_dac` | ADC connected to DAC |
| `peripheral` | simple peripheral (32x32 r/w registers) |
| `xif` | custom instruction extension (32-bit addition) |
| `fazyrv` | [FazyRV](https://github.com/meiniKi/FazyRV) with 8-bit datapath |

To build individual user designs, go into one of the directories and run the commands:

```
Commands:
 synth           ... Synthesize the user design
 pnr             ... Run Place and Route
 bitstream       ... Generate the bitstream
 clean           ... Delete all generated files
 help            ... Show this help message
```

To build all of them, run:

```
make build_all
```

To delete all generated files, run:

```
make clean_all
```

**Note:** To generate the bitstreams you need to `pip3 install fasm`.