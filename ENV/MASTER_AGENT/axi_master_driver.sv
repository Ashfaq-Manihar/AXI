 ///////////////////////////////////
//
//   FILE_NAME   : axi_master_driver.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.4
//   Date        : 14/07/2025
//
///////////////////////////////////

`ifndef AXI_MASTER_DRIVER_SV
`define AXI_MASTER_DRIVER_SV

class axi_master_driver #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_driver #(master_seq_item);
  
  /////////////////////////////////////////////////
  //            FACTORY REGISTRATION             //
  /////////////////////////////////////////////////
  
  `uvm_component_param_utils(axi_master_driver #(ADDR_WIDTH, DATA_WIDTH))

  /////////////////////////////////////////////////
  //            VIRTUAL INTERFACE                //
  /////////////////////////////////////////////////
  
  trans_kind_e kind;
  
  /////////////////////////////////////////////////
  //            VIRTUAL INTERFACE                //
  /////////////////////////////////////////////////
  
  virtual axi_master_if #(ADDR_WIDTH, DATA_WIDTH)  vif;
  
  
  /////////////////////////////////////////////////
  //           CHANNEL           QUEUE           //
  /////////////////////////////////////////////////
   
  master_seq_item write_addr_que[$];  //TODO ; PARAM
  master_seq_item write_data_que[$];
  master_seq_item write_response_que[$];
  master_seq_item read_addr_que[$];
  master_seq_item read_data_que[$];
  
  
  /////////////////////////////////////////////////
  //            CONSTRUCTOR                      //
  /////////////////////////////////////////////////
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  /////////////////////////////////////////////////
  //            BUILD PHASE                      //
  /////////////////////////////////////////////////
  
  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
     endfunction

  
  
  /////////////////////////////////////////////////
  //            RUN PHASE                        //
  /////////////////////////////////////////////////
  
   task run_phase(uvm_phase phase);
     super.run_phase(phase);
     wait(vif.ARESETn == 1);  
     drive_to_slave();    
     forever begin
       master_seq_item req;
       seq_item_port.get(req);  //This is blocking method earlier we use get_next_item() which was non blocking method
//        req.print();
       if(req.kind == WRITE) begin
       write_addr_que.push_back(req);
       write_data_que.push_back(req);
      // write_response_que.push_back(req);
       end
       else 
         if(req.kind == READ) begin
       read_addr_que.push_back(req);
       read_data_que.push_back(req);
       end
     end
     
  endtask 

  
  
  /////////////////////////////////////////////////
  //        TASK :: drive_to_slave               //
  /////////////////////////////////////////////////  
  
  task drive_to_slave();
   fork 
     write_address_channel();
     write_data_channel();
     write_response_channel();
     read_address_channel();
     read_data_channel();
   join_none
    
  endtask
  
  
  
  /////////////////////////////////////////////////
  //           WRITE ADDRESS PHASE               //
  /////////////////////////////////////////////////  
  
  task write_address_channel();
    master_seq_item trans;  //handle of master seq item
    forever begin
      if(write_addr_que.size() > 0) begin
        trans = write_addr_que.pop_front();  // getting  packet from the queue
        //driving signals on master interface
        vif.driver_cb.AWVALID <= 1;
        vif.driver_cb.AWID <= trans.AWID;
        vif.driver_cb.AWADDR <= trans.AWADDR;
        vif.driver_cb.AWLEN <= trans.AWLEN;
        vif.driver_cb.AWSIZE <= trans.AWSIZE;
        vif.driver_cb.AWBURST <= trans.AWBURST;
         
        do @(posedge vif.ACLK);
        while (!vif.driver_cb.AWREADY); //wait for the WREADY to be deasserted
         vif.driver_cb.AWVALID <= 0;
      end else begin
        @(posedge vif.ACLK);
      end
    end  
  endtask
  
  
    
  /////////////////////////////////////////////////
  //           WRITE DATA  CHANNEL               //
  /////////////////////////////////////////////////  
  
  task write_data_channel();
  master_seq_item trans;
  int beat;
  forever begin
//     $display("inside write data channel");
    if (write_data_que.size() > 0 ) begin  
//       $display("inside if data phase");
      trans = write_data_que.pop_front();       
      beat = 0;
      repeat (trans.AWLEN + 1) begin          
//       $display("inside repeat of AWLEN +1");
        vif.driver_cb.WVALID <= 1;
        vif.driver_cb.WID    <= trans.WID;
        vif.driver_cb.WDATA  <= trans.WDATA[beat];
        vif.driver_cb.WSTRB  <= trans.WSTRB[beat];   
        vif.driver_cb.WLAST  <= (beat == trans.AWLEN);  
        
         
        do @(posedge vif.ACLK); 
         while (!vif.driver_cb.WREADY);        
         beat++;
      end
      vif.driver_cb.WVALID <= 0;  
      vif.driver_cb.WLAST  <= 0;
    end 
    else begin
      @(posedge vif.ACLK);
    end
  end
endtask
  


  /////////////////////////////////////////////////
  //           WRITE RESPONSE  CHANNEL           //
  /////////////////////////////////////////////////  
  
  task write_response_channel();   ///TODO;- Confusion
   master_seq_item #(ADDR_WIDTH, DATA_WIDTH) rsp;
   rsp =  master_seq_item #(ADDR_WIDTH, DATA_WIDTH)::type_id::create("rsp");
   vif.driver_cb.BREADY <= 1;  
    @(posedge vif.ACLK iff (vif.driver_cb.BVALID && vif.driver_cb.BREADY)) begin
        rsp.BID    = vif.driver_cb.BID;
        rsp.BRESP  = vif.driver_cb.BRESP;
      end
  endtask
  
 
  
  /////////////////////////////////////////////////
  //           READ ADDRESS Phase                //
  /////////////////////////////////////////////////   
  task read_address_channel();
  master_seq_item trans;
  forever begin
    if (read_addr_que.size() > 0 ) begin
      trans = read_addr_que.pop_front();
      vif.driver_cb.ARVALID <= 1;
      vif.driver_cb.ARID    <= trans.ARID;
      vif.driver_cb.ARADDR  <= trans.ARADDR;
      vif.driver_cb.ARLEN   <= trans.ARLEN;
      vif.driver_cb.ARSIZE  <= trans.ARSIZE;
      vif.driver_cb.ARBURST <= trans.ARBURST;
      
      do @(posedge vif.ACLK); 
      while (!vif.driver_cb.ARREADY);
    vif.driver_cb.ARVALID <= 0;
    end else begin
      @(posedge vif.ACLK);
    end
  end
endtask
  
  
  /////////////////////////////////////////////////
  //           READ DATA PHASE                   //
  /////////////////////////////////////////////////    
  
  task read_data_channel();
   forever begin
   @(posedge vif.ACLK);     
    vif.driver_cb.RREADY <= 1;
     end
endtask

  

endclass
`endif

