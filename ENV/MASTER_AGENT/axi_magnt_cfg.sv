///////////////////////////////////
//
//   FILE_NAME   : axi_scoreboard.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////


`ifndef AXI_MAGNT_CFG_SV
`define AXI_MAGNT_CFG_SV

class axi_magnt_cfg  extends uvm_object;
  `uvm_object_utils(axi_magnt_cfg)

  virtual axi_master_if #(32,32) vif;

  //Active or passive master agent
 uvm_active_passive_enum is_active = UVM_ACTIVE;

  function new(string name = "axi_magnt_cfg");
    super.new(name);
  endfunction
endclass

`endif


