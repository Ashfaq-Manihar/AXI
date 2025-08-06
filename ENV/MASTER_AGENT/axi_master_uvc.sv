///////////////////////////////////
//
//   FILE_NAME   : axi_master_uvc.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_MASTER_UVC
`define AXI_MASTER_UVC


class axi_master_uvc extends uvm_agent;

  axi_master_agent#() magnt[];
  int num_of_magnt;

  `uvm_component_utils(axi_master_uvc)

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    magnt = new[num_of_magnt];
    
    for(int i; i< num_of_magnt; i++) begin
      string agent_name;
      $sformat(agent_name,"magnt[%0d]",i);
      magnt[i] = axi_master_agent #()::type_id::create(agent_name, this);
    end

  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
  endfunction : connect_phase

endclass 

`endif 


