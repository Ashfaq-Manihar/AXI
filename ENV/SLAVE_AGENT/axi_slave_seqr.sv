///////////////////////////////////
//
//   FILE_NAME   : axi_slave_seqr.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_SLAVE_SEQR_SV
`define AXI_SLAVE_SEQR_SV

class axi_slave_seqr #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_sequencer #(slave_seq_item#(ADDR_WIDTH, DATA_WIDTH));

  `uvm_component_param_utils(axi_slave_seqr)

///////////////////////////////////////////////
////   ANALYSIS EXPORT                 ////////
///////////////////////////////////////////////


uvm_tlm_analysis_fifo #(slave_seq_item) mreq_fifo;
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
    mreq_fifo = new("mreq_fifo", this);
  endfunction

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
  $display("INSIDE SLAVE SEQR");
  endfunction

endclass

`endif

