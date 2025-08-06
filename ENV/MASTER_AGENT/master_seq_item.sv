///////////////////////////////////
//
//   FILE_NAME   : master_seq_item.sv
//   Author Name : Ashfaq Manihar
//   Type        : Class
//   Description : 
//   Version     : 1.0
//   Date        : 14/07/2025
//
///////////////////////////////////



`ifndef MASTER_SEQ_ITEM_SV
`define MASTER_SEQ_ITEM_SV



///////////////////////////////////////////////
/////       WRITE BURST ENUM       ////////////
///////////////////////////////////////////////
  
  typedef enum bit[1:0] {
    WRITE_FIXED     = 2'b00,
    WRITE_INCR      = 2'b01,
    WRITE_WRAP      = 2'b10,
    WRITE_RESERVED  = 2'b11 } wburst_en;

///////////////////////////////////////////////
/////       READ BURST ENUM        ////////////
///////////////////////////////////////////////

  typedef enum bit[1:0] {
    READ_FIXED     = 2'b00,
    READ_INCR      = 2'b01,
    READ_WRAP      = 2'b10,
    READ_RESERVED  = 2'b11 } rburst_en;

///////////////////////////////////////////////
/////       WRITE SIZE ENUM        ////////////
///////////////////////////////////////////////

typedef enum bit[2:0] {
    WRITE_1_BYTE     = 3'b000,
    WRITE_2_BYTE     = 3'b001,
    WRITE_4_BYTE     = 3'b010,
    WRITE_8_BYTE     = 3'b011,  
    WRITE_16_BYTE      = 3'b100,
    WRITE_32_BYTE      = 3'b101,
    WRITE_64_BYTE      = 3'b110,
    WRITE_128_BYTE     = 3'b111 } wsize_en;


///////////////////////////////////////////////
/////       READ SIZE ENUM         ////////////
///////////////////////////////////////////////

typedef enum bit[2:0] {
    READ_1_BYTE     = 3'b000,
    READ_2_BYTE     = 3'b001,
    READ_4_BYTE     = 3'b010,
    READ_8_BYTE     = 3'b011,  
    READ_16_BYTE    = 3'b100,
    READ_32_BYTE    = 3'b101,
    READ_64_BYTE    = 3'b110,
    READ_128_BYTE   = 3'b111 } rsize_en;



typedef enum bit {READ, WRITE} trans_kind_e;


class master_seq_item #(parameter ADDR_WIDTH = 32,DATA_WIDTH = 32) extends uvm_sequence_item;

  // parameter LENGTH = 8;

  
  //tRANS KIND enum HANDLE
  rand trans_kind_e kind;
  
  // Write Address Channel
  rand bit [7:0]              AWID;
  rand bit [ADDR_WIDTH-1:0]   AWADDR;
  rand bit [7:0]              AWLEN;
  rand wsize_en               AWSIZE;
  rand wburst_en              AWBURST;


  // Write Data Channel
  rand bit [7:0]              WID;
  rand bit [DATA_WIDTH-1:0]   WDATA[$];   //WDATA que
  bit [DATA_WIDTH/8-1:0]      WSTRB[$];  //queue

  //rand bit [DATA_WIDTH-1:0]   WDATA[$:2**(LENGTH)];   //WDATA que
  //bit [DATA_WIDTH/8-1:0]      WSTRB[$:2**(LENGTH)];  //queue



  //we can also take WDATA a dynamic array and have constraint that after randomize its length will get AWLEN +1 (but since AWLEN is also rand type we may have to use solve AWLEN before WDATA)
  
  
  // Write Response Channel
  bit [7:0]              BID;   //TODO:-
  bit [1:0]              BRESP;  //TODO:-


  // Read Address Channel
  rand bit [7:0]              ARID;
  rand bit [ADDR_WIDTH-1:0]   ARADDR;
  rand bit [7:0]              ARLEN;
  rand rsize_en               ARSIZE;
  rand rburst_en              ARBURST;


  // Read Data Channel
  bit [7:0]              RID;
  bit [DATA_WIDTH-1:0]   RDATA;
  bit [1:0]              RRESP;
  
  
  function new(string name = "master_seq_item");
    super.new(name);
  endfunction

      
    `uvm_object_param_utils_begin(master_seq_item #(ADDR_WIDTH, DATA_WIDTH))    
    `uvm_field_int(AWID,      UVM_ALL_ON)
    `uvm_field_int(AWADDR,    UVM_ALL_ON)
    `uvm_field_enum(wsize_en, AWSIZE, UVM_ALL_ON)
    `uvm_field_int(AWLEN,     UVM_ALL_ON)
    `uvm_field_enum(wburst_en, AWBURST , UVM_ALL_ON)
    `uvm_field_enum(trans_kind_e, kind, UVM_ALL_ON)
    `uvm_field_int(WID,      UVM_ALL_ON)
    `uvm_field_queue_int(WDATA, UVM_ALL_ON)
    `uvm_field_queue_int(WSTRB, UVM_ALL_ON)
    `uvm_field_int(BID,       UVM_ALL_ON)
    `uvm_field_enum(rsize_en, ARSIZE, UVM_ALL_ON)

    `uvm_field_int(ARID,      UVM_ALL_ON)
    `uvm_field_int(ARADDR,    UVM_ALL_ON)
    `uvm_field_int(ARLEN,     UVM_ALL_ON)
    `uvm_field_int(ARSIZE,    UVM_ALL_ON)
    `uvm_field_enum(rburst_en, ARBURST , UVM_ALL_ON)

    `uvm_field_int(RID,       UVM_ALL_ON)
    `uvm_field_int(RDATA,     UVM_ALL_ON)
    `uvm_object_utils_end


  
  
//    constraint valid_burst_type {                                   //AxBURST
//     AWBURST != RESERVED;
//     ARBURST != RESERVED;
// //   }

//   constraint size_limit {                                         //AxSIZE
//     AWSIZE inside {[0:$clog2(DATA_WIDTH/8)]};
//     ARSIZE inside {[0:$clog2(DATA_WIDTH/8)]};
//   }

//   // Align addresses and length for only WRAP burst types         //AxBURST & AxLEN
// constraint addr_alignment {
//   if (AWBURST == 2'b10)  begin
//     AWADDR % ( (AWLEN + 1) * (1 << AWSIZE) ) == 0;
//     (AWLEN + 1)inside {2,4,8,16};
//   end

//   if (ARBURST == 2'b10) begin  
//     ARADDR % ( (ARLEN + 1) * (1 << ARSIZE) ) == 0;
//     (ARLEN + 1) inside {2,4,8,16};
//   end
  
  
  
///////////////////////////////////////////////
/////            CONSTRAINTS       ////////////
///////////////////////////////////////////////
  
///////////////////////////////////////////////
/////   WRITE ADDRESS CONSTRAINTS  ////////////
///////////////////////////////////////////////
  
 
constraint addr_constr {
  soft AWADDR == (AWADDR % (2**AWSIZE)) == 0;
}

//to select only FIXED, INCR and WRAP types
constraint burst_const_1 {
  AWBURST != WRITE_RESERVED;
}

//for restricting write trasnfers
constraint length_constr_1 {
  if (AWBURST == WRITE_FIXED || AWBURST == WRITE_WRAP)
    AWLEN inside {[0:15]};
  else if (AWBURST == WRITE_INCR)
    AWLEN inside {[0:255]};
}

// get power of 2 in wrap burst
constraint burst_constr_for_wrap {
  if (AWBURST == WRITE_WRAP)
    (AWLEN + 1) inside {2, 4, 8, 16};
}
  
  
//constraint for AWID and WID same 
  constraint id_set{
    AWID==WID;
  }
  
  
// determine the burst type
constraint burst_for_incr {
  AWBURST inside {WRITE_WRAP,WRITE_INCR, WRITE_FIXED};
}

// determine the awsize
constraint size_constr {
  soft AWSIZE inside {[0:2]};
}

/////////////////////////////////////////
//      WRITE DATA CONSTRAINTS         //
/////////////////////////////////////////

// to restrict the write data based on awlength
constraint awdata_que_size {
  WDATA.size() == AWLEN + 1;     
}

//to restrict the write strobe based on awlength
// constraint awstrb_que_size {
//   WSTRB.size() == AWLEN + 1;
// }

//wstrb shouldn't be zero  // data wont store if zero strb
constraint awstrb_constr {
  foreach (WSTRB[i]) WSTRB[i] != 0;
}

//based on size setting the strobe values
constraint awstrb_active_lanes_based_on_size {
  foreach (WSTRB[i]) $countones(WSTRB[i]) == 2**AWSIZE;
}

/////////////////////////////////////////
//      READ ADDRESS CONSTRAINTS       //
/////////////////////////////////////////

//alligned address with respect to size
constraint araddr_constr {
  soft ARADDR == (ARADDR % (2**ARSIZE)) == 0;
}

//to select only FIXED, INCR and WRAP types
constraint arburst_const_1 {
  ARBURST != READ_RESERVED;
}

//for restricting read trasnfers
constraint read_length_constr_1 {
  if (ARBURST == READ_FIXED || ARBURST == READ_WRAP)
    ARLEN inside {[0:15]};
  else if (ARBURST == READ_INCR)
    ARLEN inside {[0:255]};
}

//restricting to get multiples of 2 in wrap burst
constraint read_burst_constr_for_wrap {
  if (ARBURST == READ_WRAP)
    (ARLEN + 1) inside {2, 4, 8, 16};
}

//to detrmine the burst type
constraint read_burst_for_incr {
  soft ARBURST == READ_INCR;
}

//to detrmine the arsize
constraint read_size_constr {
  soft ARSIZE inside {[0:2]};
}
  
  
 
/////////////////////////////////////////
//   STROBE CALCULATION FUNCTION       //
/////////////////////////////////////////
  
  
//  //Strobe calculation logic==========================================================
//   function bit[DATA_WIDTH/8-1:0] strobe_calc(bit [2:0]AWSIZE,  bit [ADDR_WIDTH-1:0] AWADDR);
//     bit [DATA_WIDTH/8-1:0] strobe = '0;
//     int data_bytes = 2**AWSIZE;   //No of data bytes to write
//     int no_of_lanes = DATA_WIDTH/8;
//     int offset = AWADDR % no_of_lanes;   //offset (Remainder) within the data
//     //setting the bits in strobe
//     for(int i=0; i<data_bytes; i++) begin
//       if((offset + i ) < no_of_lanes)
//         strobe[offset + i] = 1'b1;
//     end
//     return strobe;    
//   endfunction
  
 
function automatic bit[DATA_WIDTH/8-1:0] strobe_calc(
    input bit [2:0] AWSIZE,
    input bit [ADDR_WIDTH-1:0] AWADDR
);
    bit [DATA_WIDTH/8-1:0] strobe = '0;
    int data_bytes   = 2 ** AWSIZE;               // Transfer size in bytes
    int no_of_lanes  = DATA_WIDTH / 8;            // Total number of byte lanes
    int offset       = AWADDR % no_of_lanes;      // Byte offset within the word

    for (int i = 0; i < data_bytes; i++) begin
        if ((offset + i) < no_of_lanes) begin
            strobe[offset + i] = 1'b1;
        end
    end

    $display("AWADDR=0x%08h AWSIZE=%0d -> offset=%0d, data_bytes=%0d, WSTRB=%b", 
              AWADDR, AWSIZE, offset, data_bytes, strobe);

    return strobe;
endfunction


  
  
endclass
`endif

