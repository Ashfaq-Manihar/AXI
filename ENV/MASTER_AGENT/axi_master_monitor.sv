///////////////////////////////////
//
//   FILE_NAME   : axi_master_monitor.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_MASTER_MONITOR_SV
`define AXI_MASTER_MONITOR_SV



class axi_master_monitor #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_monitor;

  `uvm_component_param_utils(axi_master_monitor #(ADDR_WIDTH, DATA_WIDTH))
  virtual axi_master_if #(ADDR_WIDTH, DATA_WIDTH)  vif;

    uvm_analysis_port #(master_seq_item) item_collected_port;
     master_seq_item trans_collected;
   
  function new(string name = "axi_master_monitor", uvm_component parent);
    super.new(name, parent);
     trans_collected = new("item_collected_port");
  endfunction

    function void build_phase(uvm_phase phase);
       super.build_phase(phase);
 
      trans_collected= master_seq_item#()::type_id::create("trans_collected", this);
    endfunction: build_phase


    task run_phase(uvm_phase phase);
   
    endtask : run_phase

   
endclass

`endif

