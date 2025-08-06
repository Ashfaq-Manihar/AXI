///////////////////////////////////
//
//   FILE_NAME   : axi_slave_monitor.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
    
`ifndef AXI_SLAVE_MONITOR_SV
`define AXI_SLAVE_MONITOR_SV



class axi_slave_monitor #(parameter ADDR_WIDTH = 32 , DATA_WIDTH = 32 ) extends uvm_monitor;

  
  parameter ID_WIDTH = 8;
  
  `uvm_component_param_utils(axi_slave_monitor #(ADDR_WIDTH, DATA_WIDTH))
   virtual axi_slave_if #(ADDR_WIDTH, DATA_WIDTH) vif;

    uvm_analysis_port #(slave_seq_item) item_collected_port;
 

///////////////////////////////////////////////
/////       CHANNEL ASSOCI ARRAY   ////////////
///////////////////////////////////////////////

  slave_seq_item trans_id[bit [ID_WIDTH-1:0]];  


  
  function new(string name = "", uvm_component parent);
    super.new(name, parent);
     item_collected_port=new("item_collected_port",this);
      endfunction

  function void build_phase(uvm_phase phase);
   super.build_phase(phase);
  endfunction

   
   function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // Connect sub-components if needed
     endfunction

  
///////////////////////////////////////////////
/////            RUN PHASE         ////////////
///////////////////////////////////////////////
  
  
    task run_phase(uvm_phase phase);
      $display("INSIDE RUN PHASE OF SLAVE MONITOR");
      fork
      monitor_aw_channel();
      monitor_w_channel();
      monitor_w_resp_channel();
      monitor_ar_channel();
      monitor_r_channel();
      join_none
    endtask 
  
  
  
///////////////////////////////////////////////
////   MONITOR WRITE ADDRESS CHANNEL   ////////
///////////////////////////////////////////////
  task monitor_aw_channel();
    bit [ID_WIDTH-1:0] id; 
    forever begin
     @(posedge vif.ACLK);
     if(vif.monitor_cb.AWVALID && vif.monitor_cb.AWREADY) begin
       id = vif.monitor_cb.AWID;
        
        if(!trans_id.exists(id)) begin
          trans_id[id] = slave_seq_item#()::type_id::create($sformatf("trans_id_%0d", id));
          end
        trans_id[id].AWID    = vif.monitor_cb.AWID;                                                   
        trans_id[id].AWADDR.push_back(vif.monitor_cb.AWADDR);
        trans_id[id].AWLEN   = vif.monitor_cb.AWLEN;
        trans_id[id].AWSIZE  = vif.monitor_cb.AWSIZE;
        trans_id[id].AWBURST = vif.monitor_cb.AWBURST;
          if(trans_id[id].AWID == trans_id[id].WID) begin //comparing to ensure that all the 
            if(trans_id[id].WDATA.size() == (trans_id[id].AWLEN +1)) begin     //comparing to ensure that all the 
                  trans_id[id].kind = WRITE;  /////////////////////////////////TODO:Review it         
                  item_collected_port.write(trans_id[id]);
                  //`uvm_info(get_type_name(), $sformatf(" INSIDE - SLAVE MONITOR AW_CHANNEL (SAMPLED DATA FROM INTERFACE) - %s", trans_id[id].sprint()), UVM_LOW)

                end 
          end
    end 
end


  endtask
                                                          
      
///////////////////////////////////////////////
////   MONITOR WRITE DATA CHANNEL      ////////
///////////////////////////////////////////////
  
  task monitor_w_channel();
    forever begin
      @(posedge vif.ACLK);
      if(vif.monitor_cb.WVALID && vif.monitor_cb.WREADY) begin
        bit [ID_WIDTH-1:0] id = vif.monitor_cb.WID;
        
        if(!trans_id.exists(id)) begin
          trans_id[id] =  slave_seq_item#()::type_id::create($sformatf("trans_id%0d", id));
          end
        
         do begin
 
        if(trans_id[id].WDATA.size() > 0) @(posedge vif.ACLK);
        trans_id[id].WID    = vif.monitor_cb.WID; 
        trans_id[id].WDATA.push_back(vif.monitor_cb.WDATA); 
        trans_id[id].WSTRB.push_back(vif.monitor_cb.WSTRB);         
          end  
         while(!vif.monitor_cb.WLAST);

          if(trans_id[id].AWID == trans_id[id].WID) begin //comparing to ensure that all the 
            if(trans_id[id].WDATA.size() == (trans_id[id].AWLEN +1)) begin     //comparing to ensure that all the 
                  trans_id[id].kind = WRITE;  /////////////////////////////////TODO:Review it    
                 //`uvm_info(get_type_name(), $sformatf(" INSIDE - SLAVE MONITOR W_CHANNEL (SAMPLED DATA FROM INTERFACE) - %s", trans_id[id].sprint()), UVM_LOW)
                  item_collected_port.write(trans_id[id]); 
                 // `uvm_info(get_type_name(), $sformatf(" INSIDE - SLAVE MONITOR W_CHANNEL (SAMPLED DATA FROM INTERFACE) - %s", trans_id[id].sprint()), UVM_LOW)

             end
        end                 
   end  
end
  endtask                                                      
  
                                                          
///////////////////////////////////////////////
////   MONITOR WRITE RESP CHANNEL      ////////
///////////////////////////////////////////////
  
  task monitor_w_resp_channel();
    forever begin
      @(posedge vif.ACLK);
      if(vif.monitor_cb.BVALID && vif.monitor_cb.BREADY) begin
        bit [ID_WIDTH-1:0] id = vif.monitor_cb.BID;

        if(!trans_id.exists(id)) begin
          trans_id[id] =  slave_seq_item#()::type_id::create($sformatf("trans_id%0d", id));
          end

         
        trans_id[id].BID   = vif.monitor_cb.BID;
        trans_id[id].BRESP = vif.monitor_cb.BRESP;
          
      end
    end   
  endtask    
                                                       
                                                          
///////////////////////////////////////////////
////   MONITOR READ  ADDRESS CHANNEL   ////////
///////////////////////////////////////////////
  
  task monitor_ar_channel();
    forever begin
      @(posedge vif.ACLK);
      if(vif.monitor_cb.ARVALID && vif.monitor_cb.ARREADY) begin
        bit [ID_WIDTH-1:0] id = vif.monitor_cb.ARID;
        
        if(!trans_id.exists(id)) begin
          trans_id[id] =  slave_seq_item#()::type_id::create($sformatf("trans_id_%0d", id));
          end
                                                          
        trans_id[id].ARADDR.push_back(vif.monitor_cb.ARADDR);
        trans_id[id].ARLEN   = vif.monitor_cb.ARLEN;
        trans_id[id].ARSIZE  = vif.monitor_cb.ARSIZE;
        trans_id[id].ARBURST = vif.monitor_cb.ARBURST;
        trans_id[id].ARID    = vif.monitor_cb.ARID;
       `uvm_info(get_type_name(),$sformatf("SLAVE MONITOR READ ADDRESS PACKET PRINT -  %s", trans_id[id].sprint()), UVM_LOW)

      end
    end   
  endtask  
  
///////////////////////////////////////////////
////   SLAVE MONITOR READ DATA CHANNEL   //////
///////////////////////////////////////////////  
  
  task monitor_r_channel();
    forever begin
      @(posedge vif.ACLK);
      if(vif.monitor_cb.RVALID && vif.monitor_cb.RREADY) begin
        bit [ID_WIDTH-1:0] id = vif.monitor_cb.RID;
        
       if(!trans_id.exists(id)) begin
        trans_id[id] =  slave_seq_item#()::type_id::create($sformatf("trans_id_%0d", id)); end
                                                      
       trans_id[id].RDATA.push_back(vif.monitor_cb.RDATA);
       trans_id[id].RID = vif.monitor_cb.RID;
         
        if(vif.monitor_cb.RLAST) begin
         //analysis_port.write(trans_di(id));    //send the packet to the scoreboard using write method
        //trans_id.delete(id);                   // to clear up the space from the associa array
       end
    end   
end
   
  endtask  
  
  
  
  

endclass

`endif

