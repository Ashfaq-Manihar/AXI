 ///////////////////////////////
 //
 //   FILE_NAME   : axi_env_pkg.sv
 //   Author Name : Ashfaq Manihar
 //   Type        : Class
 //   Description : 
 //   Version     : 1.0
 //   Date        : 14/07/2025
 //
 ///////////////////////////////////

 `ifndef AXI_ENV_PKG_SV
 `define AXI_ENV_PKG_SV

   package axi_env_pkg;
   import uvm_pkg::*;
  `include "uvm_macros.svh"
   import axi_master_pkg::*;
   import axi_slave_pkg::*;
    `include "axi_ref_model.sv"
  `include "axi_scoreboard.sv"
  `include "axi_coverage_collector.sv"
   `include "axi_master_uvc.sv"
   `include "axi_slave_uvc.sv"
   `include "axi_env_cfg.sv"
  `include "axi_env.sv"
  endpackage

 `endif
