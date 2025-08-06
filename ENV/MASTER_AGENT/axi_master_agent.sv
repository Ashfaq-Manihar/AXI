///////////////////////////////////////////////////////////////////////////////
//
//   FILE_NAME   : axi_scoreboard.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
//////////////////////////////////////////////////////////////////////////////


`ifndef AXI_MASTER_AGENT_SV
`define AXI_MASTER_AGENT_SV

class axi_master_agent #(ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_agent;

  axi_master_driver  m_drvh;
  axi_master_seqr m_seqrh;
  axi_master_monitor m_monh;
  axi_magnt_cfg magnt_cfg;

  `uvm_component_utils(axi_master_agent)

  virtual axi_master_if #(ADDR_WIDTH, DATA_WIDTH)  vif;
  
  function new (string name = "agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi_master_if#(32,32))::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
    
    
    if(!uvm_config_db#(axi_magnt_cfg)::get(this,  "", "master_config", magnt_cfg))
       `uvm_error(get_type_name(), "ERROR")
        
        //Build sequencer and driver only if active 
    if(magnt_cfg.is_active == UVM_ACTIVE) begin
        m_drvh = axi_master_driver#(32,32)::type_id::create("m_drvh", this);
        m_seqrh = axi_master_seqr#(32,32)::type_id::create("m_seqrh", this);
         end
      //Always build monitor be it active or passive agent  
     m_monh  = axi_master_monitor#(32,32)::type_id::create("m_monh", this);
   
    
    

  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    if(magnt_cfg.is_active)
      m_drvh.seq_item_port.connect(m_seqrh.seq_item_export);
      m_drvh.vif = vif;
      m_monh.vif = vif;
  endfunction : connect_phase

endclass

`endif


