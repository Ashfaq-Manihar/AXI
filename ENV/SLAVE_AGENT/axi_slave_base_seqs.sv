///////////////////////////////////
//
//   FILE_NAME   : axi_slave_base_seqs.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////


`ifndef AXI_SLV_BASE_SEQS_SV
`define AXI_SLV_BASE_SEQS_SV

class axi_slave_base_seqs#(ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_sequence #(slave_seq_item#(ADDR_WIDTH, DATA_WIDTH));

  `uvm_object_utils(axi_slave_base_seqs)

///////////////////////////////////////////////
////           P_sequencer             ////////
///////////////////////////////////////////////

//collect data from the tlm_fifo (slave sequencer)
`uvm_declare_p_sequencer(axi_slave_seqr);



  function new(string name = "axi_slave_base_seqs");
    super.new(name);
  endfunction



///////////////////////////////////////////////
////           SLAVE MEMORY            ////////
///////////////////////////////////////////////

    bit [31:0] slave_memory [int];

    slave_seq_item trans_h;
   
    bit [DATA_WIDTH-1:0] rd_data;

///////////////////////////////////////////////
////           WRITE FUNCTION          ////////
///////////////////////////////////////////////

 function void mem_write(slave_seq_item trans);   
     foreach(trans.AWADDR[i]) begin
        slave_memory[trans.AWADDR[i]] = trans.WDATA[i];
           end
     $display("MEMORY -%p",slave_memory);
    // trans.BID = trans.AWID;     //asigning the same AWID  to the BID (Hence AWID=WID=BID)
 endfunction


///////////////////////////////////////////////
////           READ  FUNCTION          ////////
///////////////////////////////////////////////

 function bit [DATA_WIDTH-1:0] mem_read(slave_seq_item trans);
   foreach(trans.AWADDR[i])begin
       return slave_memory[trans.AWADDR[i]]; end
 endfunction


///////////////////////////////////////////////
////           BODY                    ////////
///////////////////////////////////////////////
 

  task body();
  $display("INSIDE BODY OF SLAVE BASE SEQS");
   forever begin
  // repeate(5) begin
    p_sequencer.mreq_fifo.get(trans_h);
  // `uvm_info(get_type_name(), $sformatf(" PACKET - INSIDE SLAVE BASE SEQS - %s", trans_h.sprint()), UVM_LOW)
     burst_addr_calculation(trans_h.AWLEN, trans_h.AWSIZE, trans_h.AWADDR[0], trans_h.AWBURST, trans_h.AWADDR);    //Burst - Write address calculation
     burst_addr_calculation(trans_h.ARLEN, trans_h.ARSIZE, trans_h.ARADDR[0], trans_h.ARBURST, trans_h.ARADDR);    //Burst - Read address calculation

    `uvm_info(get_type_name(), $sformatf(" WRITE AND READ == CALCULATED ADDRESS - %s", trans_h.sprint()), UVM_LOW)

   if(trans_h.kind == WRITE) begin
      mem_write(trans_h);
      `uvm_send(trans_h)
      `uvm_info(get_type_name(), $sformatf(" FINAL WRITE PACKET SENT TO SLAVE DRIVER - %s", trans_h.sprint()), UVM_LOW)
      end
   
   else begin
     //rd_data = mem_read(trans_h);
      trans_h.RDATA.push_back(mem_read(trans_h));
      `uvm_send(trans_h)
      `uvm_info(get_type_name(), $sformatf(" FINAL DATA SENT TO SLAVE DRIVER - %s", trans_h.sprint()), UVM_LOW)

      end 
   end  
  endtask




///////////////////////////////////////////////
//// BURST ADDRESS CALCULATION FUNCTION   /////
/////////////////////////////////////////////// 

function void burst_addr_calculation(bit [7:0]LEN,bit [7:0]SIZE,bit [ADDR_WIDTH-1:0]addr, bit [1:0]BURST, ref bit [ADDR_WIDTH-1:0] temp_addr[$]);

int unsigned no_of_beats;
int unsigned start_addr;
int unsigned total_no_of_bytes;
int unsigned size_of_beat;
int unsigned lower_boundary_addr;

no_of_beats   = LEN + 1;
   start_addr = addr;
size_of_beat = 1 << SIZE;

temp_addr.delete();             //Cleaning the address queu
temp_addr.push_back(start_addr);      //Pushing the start address to the queue


case (BURST)

2'b00: begin   //FIXED
   for(int i = 1; i < no_of_beats; i++) begin
     temp_addr.push_back(start_addr);
     end
  end

2'b01: begin   //INCR
   for(int i = 1; i < no_of_beats; i++) begin
      temp_addr.push_back(temp_addr[i - 1] + size_of_beat); end
  end

2'b10: begin   //WRAP 

    total_no_of_bytes = no_of_beats * size_of_beat;
    lower_boundary_addr = (start_addr / total_no_of_bytes) * total_no_of_bytes;
   
    for(int i = 1; i < no_of_beats; i++) begin     
      bit [ADDR_WIDTH-1:0] next_addr = (temp_addr[i - 1] + size_of_beat);
      if(next_addr >= lower_boundary_addr + total_no_of_bytes)
          next_addr = lower_boundary_addr;
      temp_addr.push_back(next_addr); 
      end
    end
default: $error("Burst type not Supported %d", BURST);

  endcase

  endfunction





endclass

`endif 
