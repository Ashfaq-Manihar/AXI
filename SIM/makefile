# File paths
RTL_FILES = ../RTL/axi_dut.sv
PKG_FILES =  ../ENV/MASTER_AGENT/axi_master_pkg.sv ../ENV/SLAVE_AGENT/axi_slave_pkg.sv ../ENV/axi_env_pkg.sv ../TEST/test_pkg.sv 
TB_FILE = ../TOP/top.sv

# Include directories
INCLUDE_DIRS = +incdir+../ENV +incdir+../TEST  +incdir+../ENV/MASTER_AGENT  +incdir+../ENV/SLAVE_AGENT 

# Top module for simulation
TOP_MODULE = top  

# Compile the files
comp:
	vlog $(RTL_FILES) $(PKG_FILES) $(TB_FILE) $(INCLUDE_DIRS)

# Simulate the top module
sim:
	vsim -voptargs=+"acc" $(TOP_MODULE) -c -do "run -all; exit" 
wave:
	vsim -voptargs=+acc $(TOP_MODULE) -do "do axi_wave.do; run -all;"

run: comp sim
	
