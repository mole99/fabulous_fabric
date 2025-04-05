# Default sky130

fabric-sky130:
	cd fabric_sky130/; openlane config.yaml
.PHONY: fabric-sky130

fabric-sky130-view:
	cd fabric_sky130/; openlane --last-run --flow OpenInOpenROAD config.yaml
.PHONY: fabric-sky130-view

test-sky130:
	cd fabric_sky130/tb/; python3 tb_cocotb.py
.PHONY: test-sky130

compress-sky130:
	find fabric_sky130/macro/ -maxdepth 3 -type f -size +50M -exec gzip {} \;
.PHONY: compress-sky130


# ihp-sg13g2

PDK ?= ihp-sg13g2
PDK_ROOT ?= ~/.volare

fabric-ihp:
	cd fabric_ihp/; openlane --manual-pdk --pdk ${PDK} --pdk-root ${PDK_ROOT} config.yaml
.PHONY: fabric-ihp

fabric-ihp-view:
	cd fabric_ihp/; openlane --manual-pdk --pdk ${PDK} --pdk-root ${PDK_ROOT} --last-run --flow OpenInOpenROAD config.yaml
.PHONY: fabric-ihp-view

test-ihp:
	cd fabric_ihp/tb/; python3 tb_cocotb.py
.PHONY: test-ihp
