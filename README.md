# FABulous Fabric

This repository contains [FABulous](https://github.com/FPGA-Research/FABulous) FPGA fabrics for sky130 and ihp-sg13g2 that are hardened using the [FABulous OpenLane 2 plugin](https://github.com/mole99/openlane_plugin_fabulous).

Enable the plugin and harden the fabrics using either `make fabric-sky130` or `make fabric-ihp`. To view the layout in OpenROAD run `make fabric-sky130-view` or `make fabric-ihp-view`.

> [!NOTE]  
> The fabric that was last actively worked on is `fabric_ihp` and should be in a good state. The other fabric, `fabric_sky130`, may need some updates to work with the latest version of the FABulous OpenLane 2 plugin.

## Configuration

In addition to the fabrics, this repository also contains some RTL designs for configuring the fabrics.

The `rtl/` folder contains `fabric_config`, which receives bitstream data and controls the `FrameData` and `FrameStrobe` signals of a fabric.

This module is complemented by `fabric_spi_controller` and `fabric_spi_receiver`. `fabric_spi_controller` receives data from an external SPI controller. `fabric_spi_controller` loads bitstream data from an external SPI flash.

You can find testbenches for `fabric_spi_controller` and `fabric_spi_receiver` under `tb/`.

## User Designs

Both fabrics have a selection of user designs in `fabric_sky130/user_designs/` or `fabric_ihp/user_designs/`.

To build the user designs, have a look at the README in the respective `user_designs/`.

## Simulate the Fabric

Each fabric has a [cocotb](https://github.com/cocotb/cocotb) testbench that loads the user designs into the fabric and checks for correct functionality.

To run the cocotb testbench change your directory to `fabric_sky130/tb/` or `fabric_ihp/tb/` and run `python3 tb_cocotb.py`.

Alternatively, just run `make test-sky130` or `make test-ihp`.

## Compress Files

To compress all files larger than 50MB in `fabric_sky130/macro/`, run `make compress-sky130`.

## License

FABulous Fabric is licensed under the Apache 2.0 license.