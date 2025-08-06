///////////////////////////////////
//
//   FILE_NAME   : axi_slave_uvc.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_SLAVE_UVC
`define AXI_SLAVE_UVC


class axi_slave_uvc extends uvm_component;

  axi_slave_agent#(32,32) sagnt[];
  int num_of_sagnt; 
 
  `uvm_component_utils(axi_slave_uvc)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
   
    sagnt = new[num_of_sagnt];
    
    for(int i; i< num_of_sagnt; i++) begin
      string agent_name;
      $sformat(agent_name,"sagnt[%0d]",i);
      sagnt[i] = axi_slave_agent #()::type_id::create(agent_name, this);
    end
    
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
  endfunction : connect_phase

endclass 

`endif 


