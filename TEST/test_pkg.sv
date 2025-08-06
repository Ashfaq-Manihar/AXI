// ///////////////////////////////
// //
// //   FILE_NAME   : test_pkg.sv
// //   Author Name : Ashfaq Manihar
// //   Type        : Class
// //   Description : 
// //   Version     : 1.0
// //   Date        : 14/07/2025
// //
// ///////////////////////////////////

 package test_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

    import axi_slave_pkg::*;
    import axi_master_pkg::*;
   import axi_env_pkg::*;
   `include "axi_test_top.sv"
 endpackage
