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


`ifndef AXI_SCOREBOARD_SV
`define AXI_SCOREBOARD_SV

class axi_scoreboard extends uvm_component;
  `uvm_component_utils(axi_scoreboard)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction

  // Connections to be handled in env
endclass

`endif


