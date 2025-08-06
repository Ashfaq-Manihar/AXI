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
`ifndef AXI_ENV_SV
`define AXI_ENV_SV


class axi_env extends uvm_env;
 `uvm_component_utils(axi_env)
  
  axi_ref_model ref_model;
  axi_coverage_collector cov_collector;
  axi_scoreboard scb;
  axi_slave_uvc uvc_sagnt; 
  axi_master_uvc uvc_magnt;
  axi_env_cfg env_cfg;

  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    uvc_sagnt    = axi_slave_uvc::type_id::create("uvc_sagnt",this);
    uvc_magnt    = axi_master_uvc::type_id::create("uvc_magnt", this);
    ref_model    = axi_ref_model::type_id::create("ref_model", this);
    cov_collector= axi_coverage_collector::type_id::create("cov_collector", this);
    scb          = axi_scoreboard::type_id::create("scb", this);

    if(!uvm_config_db#(axi_env_cfg)::get(this,"", "env_config", env_cfg))
      `uvm_error(get_type_name(), "ERROR")
  
  //Connection of config pins
   uvc_sagnt.num_of_sagnt = env_cfg.num_of_sagents;
   uvc_magnt.num_of_magnt = env_cfg.num_of_magents;
  
  endfunction
  
  function void connect_phase(uvm_phase phase);
  endfunction : connect_phase

endclass 

`endif 


