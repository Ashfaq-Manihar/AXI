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
`ifndef AXI_SLAVE_AGNT_SV
`define AXI_SLAVE_AGNT_SV

class axi_slave_agent #(ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_agent;
  
   axi_slave_driver s_drvh;
   axi_slave_monitor s_monh;
   axi_slave_seqr s_seqrh;
   axi_sagnt_cfg sagnt_cfg;

  `uvm_component_utils(axi_slave_agent)

  virtual axi_slave_if #(ADDR_WIDTH, DATA_WIDTH)  vif;
  
  function new (string name = "axi_slave_agent", uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual axi_slave_if#(ADDR_WIDTH, DATA_WIDTH))::get(this, "", "vif", vif))
       `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".vif"}); 
    

    if(!uvm_config_db#(axi_sagnt_cfg)::get(this,"", "slave_config", sagnt_cfg))
       `uvm_error(get_type_name(), "ERROR")
      
      //Build sequencer and driver only if active 
      if(sagnt_cfg.is_active == UVM_ACTIVE) begin
        s_drvh = axi_slave_driver#(32,32)::type_id::create("s_drvh", this);
        s_seqrh = axi_slave_seqr#(32,32)::type_id::create("s_seqrh", this);
      end
      //Always build monitor be it active or passive agent  
     s_monh  = axi_slave_monitor#(32,32)::type_id::create("s_monh", this);
        
  endfunction : build_phase
  
  function void connect_phase(uvm_phase phase);
    if(sagnt_cfg.is_active == UVM_ACTIVE) begin
      s_drvh.seq_item_port.connect(s_seqrh.seq_item_export);
      s_drvh.vif = this.vif;
    end 
    s_monh.vif = this.vif;
   s_monh.item_collected_port.connect(s_seqrh.mreq_fifo.analysis_export);  //in analysis fifo analysis_export is built in.
  endfunction : connect_phase

endclass

`endif


