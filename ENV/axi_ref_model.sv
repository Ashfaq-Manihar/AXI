///////////////////////////////////
//
//   FILE_NAME   : axi_ref_model.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_REF_MODEL_SV
`define AXI_REF_MODEL_SV


class axi_ref_model extends uvm_component;
  `uvm_component_utils(axi_ref_model)

 // uvm_analysis_export #(axi_sequence_item #(ADDR_WIDTH, DATA_WIDTH)) input_export;
//`  uvm_analysis_port  #(axi_sequence_item #(ADDR_WIDTH, DATA_WIDTH)) output_port;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  // Connections and prediction logic to be added later
endclass

`endif

