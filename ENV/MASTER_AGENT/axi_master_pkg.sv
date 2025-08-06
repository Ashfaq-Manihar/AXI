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
 `ifndef AXI_MASTER_PKG_SV
 `define AXI_MASTER_PKG_SV

 `include "axi_master_if.sv"


 package axi_master_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"
 `include "master_seq_item.sv"
 `include "axi_magnt_cfg.sv"
 `include "axi_mas_base_seqs.sv"
 `include "axi_master_seqr.sv"
 `include "axi_master_driver.sv"
 `include "axi_master_monitor.sv"
 `include "axi_master_agent.sv"
 endpackage

 `endif

