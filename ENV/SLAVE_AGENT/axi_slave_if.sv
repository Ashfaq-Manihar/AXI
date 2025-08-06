    
    
`ifndef AXI_SLAVE_IF_SV
`define AXI_SLAVE_IF_SV



//LOOK UP FOR BIT DEFINITION 


interface axi_slave_if #(ADDR_WIDTH = 32, DATA_WIDTH = 32)(input ACLK, ARESETn);

// Write Address Channel
  logic [7:0]              AWID;
  logic [ADDR_WIDTH-1:0]   AWADDR;
  logic [7:0]              AWLEN;
  logic [2:0]              AWSIZE;
  logic [1:0]              AWBURST;
  logic                    AWVALID;
  logic                    AWREADY;

  // Write Data Channel
  logic [7:0]              WID;
  logic [DATA_WIDTH-1:0]   WDATA;
  logic [DATA_WIDTH/8-1:0] WSTRB;
  logic                    WLAST;
  logic                    WVALID;
  logic                    WREADY;

  // Write Response Channel
  logic [7:0]              BID;
  logic [1:0]              BRESP;
  logic                    BVALID;
  logic                    BREADY;

  // Read Address Channel
  logic [7:0]              ARID;
  logic [ADDR_WIDTH-1:0]   ARADDR;
  logic [7:0]              ARLEN;
  logic [2:0]              ARSIZE;
  logic [1:0]              ARBURST;
  logic                    ARVALID;
  logic                    ARREADY;

  // Read Data Channel
  logic [7:0]              RID;
  logic [DATA_WIDTH-1:0]   RDATA;
  logic [1:0]              RRESP;
  logic                    RLAST;
  logic                    RVALID;
  logic                    RREADY;


   clocking driver_cb @(posedge ACLK);
    default input #1 output #1;
     
    
    // WRITE ADDRESS SIGNALS //
    
    input  AWID,AWLEN,AWSIZE,AWADDR,AWBURST,AWVALID;
    output AWREADY; 
    
    // WRITE DATA SIGNALS //
    
    input   WID,WDATA,WSTRB,WLAST,WVALID;
    output  WREADY;
    
    // WRITE REPSONSE SIGNALS //
    
    output  BID,BRESP,BVALID;
    input BREADY;
    
    // READ ADDRESS SIGNALS //
    
    output ARID,ARLEN,ARSIZE,ARADDR,ARBURST,ARVALID;
    output  ARREADY;
    
    // READ DATA SIGNALS //
    
    output  RLAST,RVALID,RID,RRESP,RDATA;
    input   RREADY;
     
  endclocking

   clocking monitor_cb @(posedge ACLK);
    default input #1 output #1;
     
    input AWID,AWLEN,AWSIZE,AWADDR,AWBURST,AWVALID;
    input  AWREADY; 
  
    // WRITE DATA SIGNALS //
    
    input WID,WDATA,WSTRB,WLAST,WVALID;
    input  WREADY;
    
    // WRITE REPSONSE SIGNALS //
    
    input  BID,BRESP,BVALID;
    input BREADY;
    
    // READ ADDRESS SIGNALS //
    
    input ARID,ARLEN,ARSIZE,ARADDR,ARBURST,ARVALID;
    input  ARREADY;
    
    // READ DATA SIGNALS //
    
    input  RLAST,RVALID,RID,RRESP,RDATA;
    input RREADY;
     
    endclocking

   modport DRIVER  (clocking driver_cb);   //TO THINK:- what if we dont take modport ?
   modport MONITOR (clocking monitor_cb);

endinterface

`endif

