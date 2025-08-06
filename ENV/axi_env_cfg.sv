///////////////////////////////////
//
//   FILE_NAME   : axi_any_cfg.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////


`ifndef AXI_ENV_CONFIG_SV
`define AXI_ENV_CONFIG_SV

class axi_env_cfg extends uvm_object;
  `uvm_object_utils(axi_env_cfg)


//Pin for number of agents creation
   int num_of_magents = 1;
   int num_of_sagents = 1;


  virtual axi_mas_if #(32,32) vif;


  function new(string name = "axi_env_cfg");
    super.new(name);
  endfunction
endclass

`endif 

