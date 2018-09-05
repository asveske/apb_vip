UVM_DIR = $your_uvm_home
TB_DIR = +incdir+../tb
SRC_DIR = +incdir+../src
MASTER_DIR = +incdir+../src/master
SLAVE_DIR = +incdir+../src/slave
COMMON_DIR = +incdir+../src/common
UVM_TESTNAME=apb_test

TB = ../tb
SRC = ../src
MASTER =../src/master
SLAVE = ../src/slave
COMMON = ../src/common

clean:
	rmdir work /s /q
	del certe_dump.* vsim.* *.log *.tgz *~ *.vstf
	
comp: clean
	vlib work
	vlog -work work -sv $(UVM_DIR) $(COMMON_DIR) $(SLAVE_DIR) $(MASTER_DIR) $(TB_DIR) \
	$(COMMON)/apb_if.sv $(COMMON)/apb_common_pkg.sv $(MASTER)/apb_master_pkg.sv $(SLAVE)/apb_slave_pkg.sv \
	$(TB)/apb_env.svh $(TB)/apb_test.svh $(TB)/testbench.sv
	vopt +acc -debugdb testbench -o testbench_opt
	

sim: comp
	vsim  -voptargs=+acc -do "wave.do" -classdebug -debugdb -msgmode both -uvmcontrol=all  -OVMdebug -assertdebug  +UVM_TESTNAME=$(UVM_TESTNAME) testbench_opt