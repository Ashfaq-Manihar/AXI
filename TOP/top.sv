
///////////////////////////////////////////////////////////////////////////////
//
//   FILE_NAME   : testbench.sv
//   Author Name : Ashfaq Manihar
//   Type        : Module
//   Description : Top-level TB that instantiates DUT and interface
//   Version     : 1.0
//   Date        : 14/07/2025
//
////////////////////////////////////////////////////////////////////////////////
`include "axi_slave_if.sv"
`include "axi_master_if.sv"
//`include "axi_pkg.sv"
`include "uvm_macros.svh"
import uvm_pkg::*;
import test_pkg::*;
//import axi_pkg::*;

module top;

  parameter ADDR_WIDTH = 32;
  parameter DATA_WIDTH = 32;

  logic ACLK;
  logic ARESETn;

  // Instantiate Interface
  axi_master_if  #(ADDR_WIDTH, DATA_WIDTH)  m_if_inst(.ACLK(ACLK), .ARESETn(ARESETn));
  axi_slave_if  #(ADDR_WIDTH, DATA_WIDTH)  s_if_inst(.ACLK(ACLK), .ARESETn(ARESETn));
  
  
   // Connect Master outputs to Slave inputs and vice-versa
  assign s_if_inst.AWADDR   = m_if_inst.AWADDR;
  assign s_if_inst.AWVALID  = m_if_inst.AWVALID;
  assign m_if_inst.AWREADY  = s_if_inst.AWREADY;
  assign s_if_inst.AWBURST  = m_if_inst.AWBURST;
  assign s_if_inst.AWLEN  = m_if_inst.AWLEN;

  assign s_if_inst.WDATA    = m_if_inst.WDATA;
  assign s_if_inst.WSTRB    = m_if_inst.WSTRB;
  assign s_if_inst.WVALID   = m_if_inst.WVALID;
  assign s_if_inst.WLAST    = m_if_inst.WLAST;
  assign m_if_inst.WREADY   = s_if_inst.WREADY;

  assign m_if_inst.BRESP    = s_if_inst.BRESP;
  assign m_if_inst.BVALID   = s_if_inst.BVALID;
  assign s_if_inst.BREADY   = m_if_inst.BREADY;

  assign s_if_inst.ARADDR   = m_if_inst.ARADDR;

  assign s_if_inst.ARVALID  = m_if_inst.ARVALID;
  assign m_if_inst.ARREADY  = s_if_inst.ARREADY;
  assign s_if_inst.ARBURST    = m_if_inst.ARBURST;
  assign s_if_inst.ARSIZE    = m_if_inst.ARSIZE;
  assign s_if_inst.ARLEN    = m_if_inst.ARLEN;

  assign m_if_inst.RDATA    = s_if_inst.RDATA;
  assign m_if_inst.RRESP    = s_if_inst.RRESP;
  assign m_if_inst.RVALID   = s_if_inst.RVALID;
  assign m_if_inst.RLAST    = s_if_inst.RLAST;
  assign s_if_inst.RREADY   = m_if_inst.RREADY;
  assign  s_if_inst.AWID    = m_if_inst.AWID;
  assign  s_if_inst.WID     = m_if_inst.WID;
  assign  s_if_inst.ARID    = m_if_inst.ARID;
  assign  m_if_inst.RID     = s_if_inst.RID;
  assign  m_if_inst.BID     = s_if_inst.BID;

  // Clock Generator
  initial ACLK = 0;
  always #5 ACLK = ~ACLK;

  // Reset logic
  initial begin
    ARESETn = 0;
    #10;
    ARESETn = 1;
  end

  // Run UVM
  initial begin
    fork
    uvm_config_db#(virtual axi_master_if #(ADDR_WIDTH, DATA_WIDTH))::set(null, "*", "vif", m_if_inst);
    uvm_config_db#(virtual axi_slave_if #(ADDR_WIDTH, DATA_WIDTH))::set(null, "*", "vif", s_if_inst);
      
    run_test("axi_test_top");
    join
  end
  
  
   initial begin
     $dumpfile("dump.vcd");
     $dumpvars;
   end

endmodule
