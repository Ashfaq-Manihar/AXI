 ///////////////////////////////////
 //
 //   FILE_NAME   : axi_slave_pkg.sv
 //   Author Name : Ashfaq Manihar
 //   Type        : Class
 //   Description : 
 //   Version     : 1.0
 //   Date        : 14/07/2025
 //
 ///////////////////////////////////
 `ifndef AXI_SLAVE_AGENT_SV
 `define AXI_SLAVE_AGENT_SV
  `include "axi_slave_if.sv"

 package axi_slave_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
 `include "slave_seq_item.sv"
 `include "axi_sagnt_cfg.sv"
 `include "axi_slave_seqr.sv"
 `include "axi_slave_base_seqs.sv"
 `include "axi_slave_driver.sv"
 `include "axi_slave_monitor.sv"
 `include "axi_slave_agent.sv"

 endpackage

 `endif

