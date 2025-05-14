build_all: $(USER_DESIGNS)
	cd all_ones; make
	cd all_zeros; make
	cd counter; make
	cd passthrough; make
	cd sram; make
	cd adc_dac; make
	cd fazyrv; make
	cd serv; make
.PHONY: build_all

clean_all: $(USER_DESIGNS)
	cd all_ones; make clean
	cd all_zeros; make clean
	cd counter; make clean
	cd passthrough; make clean
	cd sram; make clean
	cd adc_dac; make clean
	cd fazyrv; make clean
	cd serv; make clean
.PHONY: clean_all
