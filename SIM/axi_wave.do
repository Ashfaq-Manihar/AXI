onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ADDR_WIDTH
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/DATA_WIDTH
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ACLK
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARESETn
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/AWID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/AWADDR
add wave -noupdate -group MASTER_INTERFACE -radix decimal /top/m_if_inst/AWLEN
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/AWSIZE
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/AWBURST
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/AWVALID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/AWREADY
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/WID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/WDATA
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/WSTRB
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/WLAST
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/WVALID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/WREADY
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/BID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/BRESP
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/BVALID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/BREADY
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARADDR
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARLEN
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARSIZE
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARBURST
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARVALID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/ARREADY
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/RID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/RDATA
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/RRESP
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/RLAST
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/RVALID
add wave -noupdate -group MASTER_INTERFACE /top/m_if_inst/RREADY
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ACLK
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARESETn
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWADDR
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWLEN
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWSIZE
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWBURST
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWVALID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/AWREADY
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/WID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/WDATA
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/WSTRB
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/WLAST
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/WVALID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/WREADY
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/BID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/BRESP
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/BVALID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/BREADY
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARADDR
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARLEN
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARSIZE
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARBURST
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARVALID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/ARREADY
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/RID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/RDATA
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/RRESP
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/RLAST
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/RVALID
add wave -noupdate -expand -group SLAVE_INTERFACE /top/s_if_inst/RREADY
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1747 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {1692 ns} {1942 ns}
