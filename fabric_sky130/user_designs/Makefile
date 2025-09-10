build_all: $(USER_DESIGNS)
	cd all_ones; make
	cd all_zeros; make
	cd counter; make
	cd counter_warmboot; make
	cd passthrough; make
	cd sram; make
	cd adc_dac; make
	cd trigger_slot0; make
	cd trigger_slot1; make
	cd fazyrv; make
	cd serv; make
.PHONY: build_all

clean_all: $(USER_DESIGNS)
	cd all_ones; make clean
	cd all_zeros; make clean
	cd counter; make clean
	cd counter_warmboot; make clean
	cd passthrough; make clean
	cd sram; make clean
	cd adc_dac; make clean
	cd trigger_slot0; make clean
	cd trigger_slot1; make clean
	cd fazyrv; make clean
	cd serv; make clean
.PHONY: clean_all
