///////////////////////////////////
//
//   FILE_NAME   : axi_slave_driver.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////
`ifndef AXI_SLAVE_DRIVER_SV
`define AXI_SLAVE_DRIVER_SV

class axi_slave_driver #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_driver #(slave_seq_item);
  `uvm_component_param_utils(axi_slave_driver #(ADDR_WIDTH, DATA_WIDTH))

     virtual axi_slave_if #(ADDR_WIDTH, DATA_WIDTH) vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
   // super.build_phase(phase);

     endfunction
   
     function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
     endfunction



///////////////////////////////////////////////
/////             RUN PHASE        ////////////
///////////////////////////////////////////////


      task run_phase(uvm_phase phase);
       /* fork
         forever begin
             @(posedge vif.ACLK);         
              seq_item_port.get_next_item(req);
              send_to_interface();
             `uvm_info(get_type_name(), $sformatf(" PACKET RECEIVED IN SLAVE DRIVER - %s", req.sprint()), UVM_LOW)                     
              seq_item_port.item_done(); 
        end
        join_none */
        drive_ready();
     endtask 

///////////////////////////////////////////////
/////          READY TASK          ////////////
///////////////////////////////////////////////
      task drive_ready();
       forever begin
        @(posedge vif.ACLK);
        drive_write_addr_channel();
        drive_write_data_channel();
        drive_read_addr_channel();

      end
     endtask


///////////////////////////////////////////////
/////       SEND TO INTERFACE      ////////////
///////////////////////////////////////////////


     task send_to_interface();
      fork
     //drive_write_addr_channel();
    // drive_write_data_channel();
     drive_write_resp_channel();
    // drive_read_addr_channel();
     drive_read_data_channel();
      join
     endtask
 


///////////////////////////////////////////////
/////       WRITE ADDR CHANNEL     ////////////
///////////////////////////////////////////////



     task drive_write_addr_channel();
     // if(req.kind == WRITE)
         vif.driver_cb.AWREADY <= 1;
     endtask


///////////////////////////////////////////////
/////       WRITE DATA CHANNEL     ////////////
///////////////////////////////////////////////


     task drive_write_data_channel();
      //if(req.kind == WRITE)
         vif.driver_cb.WREADY <= 1;

     endtask

///////////////////////////////////////////////
/////       WRITE RESP CHANNEL     ////////////
///////////////////////////////////////////////


     task drive_write_resp_channel();
      if(req.kind == WRITE) begin
         //if(req.AWVALID && req.WVALID)
            vif.driver_cb.BRESP <= 2'b00;  //OKAY
      end
     endtask


///////////////////////////////////////////////
/////       READ ADDR CHANNEL      ////////////
///////////////////////////////////////////////


     task drive_read_addr_channel();
       //if(req.kind == READ)
         vif.driver_cb.ARREADY <= 1;

     endtask

///////////////////////////////////////////////
/////       READ DATA CHANNEL      ////////////
///////////////////////////////////////////////


     task drive_read_data_channel();
       if(req.kind == READ) begin
         foreach(req.RDATA[i]) begin
          vif.driver_cb.RDATA  <= req.RDATA[i];
          vif.driver_cb.RID    <= req.AWID;          //Assigning RID with AWID
          vif.driver_cb.RRESP  <= 2'B00;             //OKAY
          vif.driver_cb.RLAST  <= (i == req.RDATA.size() - 1);  //ARLEN
          vif.driver_cb.RVALID <= 1;
          wait(vif.driver_cb.RREADY);
          vif.driver_cb.RVALID <= 0;
       end
    end    
     endtask




endclass

`endif


