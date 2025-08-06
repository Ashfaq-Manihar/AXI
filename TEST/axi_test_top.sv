///////////////////////////////////
//
//   FILE_NAME   : axi_test_top.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_TEST_TOP_SV
`define AXI_TEST_TOP_SV


class axi_test_top  extends uvm_test;
  `uvm_component_utils(axi_test_top)

  axi_env  env;
  axi_env_cfg  env_cfg;
  axi_sagnt_cfg sagnt_cfg;
  axi_magnt_cfg magnt_cfg;
  axi_mas_base_seqs m_seqs;
  axi_slave_base_seqs s_seqs;

   

  function new(string name="axi_test_top", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
     
     // setting config_db for the number of agents to be created
//     uvm_config_db#(axi_env_cfg)::set(this,"*", "num_masters", env_cfg);

    // Connect VIF from tb top via uvm_config_db
   // if (!uvm_config_db #(virtual axi_master_if)::get(null, "*", "vif", cfg.vif))
     // `uvm_fatal("VIF", "Virtual interface not set in config DB")
     env = axi_env::type_id::create("env", this);
   
     env_cfg = axi_env_cfg::type_id::create("env_cfg", this);
    uvm_config_db#(axi_env_cfg)::set(this, "*", "env_config", env_cfg);



     magnt_cfg = axi_magnt_cfg::type_id::create("magnt_cfg", this);
     magnt_cfg.is_active = UVM_ACTIVE;
     uvm_config_db#(axi_magnt_cfg)::set(this, "*", "master_config", magnt_cfg);



     sagnt_cfg = axi_sagnt_cfg::type_id::create("sagnt_cfg", this);
     sagnt_cfg.is_active = UVM_ACTIVE;
     uvm_config_db#(axi_sagnt_cfg)::set(this, "*", "slave_config", sagnt_cfg);

     
  endfunction

  function void  end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();

       endfunction



  task run_phase(uvm_phase phase);
     
      phase.raise_objection(this);
  `uvm_info(get_type_name(),"RUN PHASE OF AXI_TEST_TOP", UVM_LOW)
      m_seqs = axi_mas_base_seqs#()::type_id::create("m_seqs");
      s_seqs = axi_slave_base_seqs#()::type_id::create("s_seqs");
  fork
  //begin
    m_seqs.start(env.uvc_magnt.magnt[0].m_seqrh);
    s_seqs.start(env.uvc_sagnt.sagnt[0].s_seqrh);
   //end
  join_any
//     `uvm_info(get_type_name(), "Starting AXI Test top", UVM_LOW)
    phase.phase_done.set_drain_time(this,2000ns);
    phase.drop_objection(this);
  endtask
endclass
`endif

