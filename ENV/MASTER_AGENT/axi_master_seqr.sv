///////////////////////////////////
//
//   FILE_NAME   : axi_master_seqr.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////


`ifndef AXI_MASTER_SEQR_SV
`define AXI_MASTER_SEQR_SV

class axi_master_seqr #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_sequencer #(master_seq_item);

  `uvm_component_param_utils(axi_master_seqr #(ADDR_WIDTH, DATA_WIDTH))

 
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
   // super.build_phase(phase);
  endfunction

endclass

`endif

