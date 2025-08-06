///////////////////////////////////
//
//   FILE_NAME   : axi_slave_driver.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_COVERAGE_COLLECTOR_SV
`define AXI_COVERAGE_COLLECTOR_SV

class axi_coverage_collector extends uvm_component;
  `uvm_component_utils(axi_coverage_collector)


  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  // Connections to be handled in env
endclass

`endif


