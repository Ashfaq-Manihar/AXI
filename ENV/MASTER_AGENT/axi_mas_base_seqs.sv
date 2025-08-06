///////////////////////////////////
//
//   FILE_NAME   : axi_mas_base_seqs.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////

`ifndef AXI_MASTER_BASE_SEQS_SV
`define AXI_MASTER_BASE_SEQS_SV


class axi_mas_base_seqs #(parameter ADDR_WIDTH = 32, DATA_WIDTH = 32) extends uvm_sequence#(master_seq_item);
  
  `uvm_object_utils(axi_mas_base_seqs)
   
  function new(string name = "axi_mas_base_seqs");
    super.new(name);
  endfunction
  
/*  function void post_randomize();
    req.strobe_calc();
  endfunction */
  
  virtual task body();

   bit [ADDR_WIDTH - 1:0] stored_addr;
   bit [7:0] length;

    repeat(1) begin
      req = master_seq_item#()::type_id::create("req"); 
        start_item(req);
      if(!req.randomize() with {req.kind == WRITE; req.AWBURST == WRITE_WRAP; req.AWADDR == 2; req.AWLEN == 3;})
        `uvm_error(get_type_name(), " WRITE - RANDOMIZATION FAILED")
      else  begin
        //req.print();
          // stored_addr = req.AWADDR;
           //  length      = req.AWLEN;
           `uvm_info(get_type_name(), $sformatf(" WRITE - RANDOMIZATION SUCCESSFUL %s", req.sprint()), UVM_LOW)
       end
    finish_item(req);
    end  

    
    repeat(1) begin
      req = master_seq_item#()::type_id::create("req"); 
        start_item(req);
      if(!req.randomize() with {req.kind == READ; req.ARBURST == READ_WRAP; req.ARADDR == 2; req.ARLEN == 3; })
      //if(!req.randomize() with {req.kind == READ; req.ARBURST == READ_WRAP;})

        `uvm_error(get_type_name(), "READ - RANDOMIZATION FAILED")
      else  begin
        //req.print();
           `uvm_info(get_type_name(), $sformatf("READ - RANDOMIZATION SUCCESSFUL %s", req.sprint()), UVM_LOW)
       end
    finish_item(req);
    end

  endtask
  
endclass

`endif



