`timescale 1ns/1ps

module testbench;

wire clk128;
wire clk125;
wire miiTxClk;
wire miiRxClk;
wire reset;

clockGenerator U_clockGenerator(
  .clk128(clk128),
  .clk125(clk125),
  .miiTxClk(miiTxClk),
  .miiRxClk(miiRxClk),
  .reset(reset));

wire Rx_clk;
wire Tx_clk;
wire hm_Rx_er;
wire hm_Rx_dv;
wire [7:0] hm_Rxd;
wire hm_Tx_en;
wire [7:0] hm_Txd;

reg mode;
reg [200:1]   testcase_name                 ;

ephy U_ephy_hm(
  .GTx_clk(clk125),
  .Rx_clk(Rx_clk),
  .Tx_clk(Tx_clk),
  .Rx_er(hm_Rx_er),
  .Rx_dv(hm_Rx_dv),
  .Rxd(hm_Rxd),
  .Crs(hm_Crs),
  .Col(hm_Col),
  .mode(mode));
  
wire [2:0] mac_speed;

wire   dpram21_wren;
wire   dpram21_rden;

wire [7:0] dpram21_addr;
wire [15:0] dpram21_data_out;

wire [7:0] mac_ca ;  // = dpram21_addr[7:0];
wire [15:0] mac_cd_in ;   //= dpram21_data_out[15:0];
//assign dpram21_data_in = {16'd0, mac_cd_out};
wire mac_csb ;  //= ~(dpram21_rden | dpram21_wren);
wire mac_wrb ;  //= ~dpram21_wren; 
reg rdy;
reg mode_switch;

task CHOOSE_MODE;
begin
    if(mode==0)//100M
	    U_host_sim.CPU_wr(7'd34,16'h2);
	else//1000M
        U_host_sim.CPU_wr(7'd34,16'h4);	
end
endtask

wire [31:0] ff_rx_data_mac;
wire [1:0]   ff_rx_mod_mac;

// initial 
// begin

// $fdsbDumpfile("test.fsdb");
// $fsdbDumpvars;

// end
wire [5:0] rx_err_mac;
wire [15:0]   mac_cd_out;
  
MAC_top MAC_top_inst
(
  .Reset(reset),
  .Clk_125M(clk125),
  .Clk_user(clk128),
  .Clk_reg(clk128),
  .Speed(mac_speed),
  .ff_rx_rdy(rdy),
  .ff_rx_data(ff_rx_data_mac),
  .ff_rx_mod(ff_rx_mod_mac),
  .ff_rx_sop(ff_rx_sop_mac),
  .ff_rx_eop(ff_rx_eop_mac),
  .ff_rx_dsav(ff_rx_dsav_mac),
  .ff_rx_dval(ff_rx_dval_mac),
  .rx_err(rx_err_mac),
  .ff_tx_data(ff_rx_data_mac),
  .ff_tx_mod(ff_rx_mod_mac),
  .ff_tx_sop(ff_rx_sop_mac),
  .ff_tx_eop(ff_rx_eop_mac),
  .ff_tx_wren(ff_rx_dval_mac),
  .ff_tx_err(ff_tx_err),
  .tx_ff_uflow(tx_ff_uflow),
  .ff_tx_rdy(ff_tx_rdy),
  .ff_tx_septy(ff_tx_septy),  
  .Rx_clk(Rx_clk),
  .Tx_clk(Tx_clk),
  .Tx_er(),
  .Tx_en(hm_Tx_en),
  .Txd(hm_Txd),
  .Rx_er(hm_Rx_er),
  .Rx_dv(hm_Rx_dv),
  .Rxd(hm_Rxd),
  .Crs(1'b0),
  .Col(1'b0),
  // .CSB(mac_csb),
  // .WRB(mac_wrb),
  // .CD_in(mac_cd_in),
  // .CD_out(mac_cd_out),
  // .CA(mac_ca)
  .CSB(mac_csb),
  .WRB(mac_wrb),
  .CD_in(mac_cd_in),
  .CD_out(mac_cd_out),
  .CA(mac_ca)  
  
  );

data_cmp U_data_cmp(
	.Rx_clk(Rx_clk)	, 
	.Tx_clk(Tx_clk)	, 
	.Tx_er ()	, 
	.Tx_en (hm_Tx_en)	, 
	.Txd   (hm_Txd)	,
	.Rx_er (hm_Rx_er)	, 
	.Rx_dv (hm_Rx_dv)	, 
	.Rxd   (hm_Rxd)	,
    .reset (reset),
    .testcase_name(testcase_name),	
	.mode  (mode)	
	);
	
host_sim U_host_sim(
.Reset	               			(reset	                  	),    
.Clk_reg                  		(clk128                 	), 
.CSB                            (mac_csb                        ),
.WRB                            (mac_wrb                        ),
.CD_in                          (mac_cd_in                      ),
.CD_out                         (mac_cd_out                     ),
.CPU_init_end                   (CPU_init_end               ),
.CA                             (mac_ca                         )
 
);	
	
  
integer i = 0;
integer len = 0;
reg [15:0] data_cnt = 16'b1;
initial
begin
	U_host_sim.CPU_init;
	rdy=1'b0;
	mode=1'b0;
	mode_switch=0;
	
	// U_host_sim.CPU_wr(7'd33,16'h1);
	
	#800;
	rdy=1'b1;
	`include "../testcase/0100000064.v"
	`include "../testcase/0100000065.v"
	`include "../testcase/0100000066.v"
	`include "../testcase/0100000067.v"
	`include "../testcase/0100000068.v"
	`include "../testcase/0100000069.v"
	`include "../testcase/0100000070.v"
	`include "../testcase/0100000071.v"
	`include "../testcase/0100000072.v"
	`include "../testcase/0100000073.v"
	`include "../testcase/0100000074.v"
	`include "../testcase/0100000075.v"
	`include "../testcase/0100000076.v"

	#10000;

	$stop;
end

// dump fsdb file for debussy
// initial
// begin
  // $fsdbDumpfile("mac.fsdb");
  // $fsdbDumpvars;
// end


/* initial
begin
//    $dumpfile("mac.vcd");
//    $dumpvars; 
    $vcdpluson;
    #12000000;
    $finish;
end */

endmodule

