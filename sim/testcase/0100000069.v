// 100M 模式，使能流控暂停帧，覆盖 flow_ctrl 分支
U_clockGenerator.RESET;

testcase_name = "0100000069" ;
mode=1'b0;
CHOOSE_MODE;
#100;
U_host_sim.CPU_wr(7'd2, 16'h0001);    // pause_frame_send_en
U_host_sim.CPU_wr(7'd3, 16'd256);     // pause_quanta_set
U_host_sim.CPU_wr(7'd11, 16'h0001);   // tx_pause_en
#200;
   i=0;
repeat(60)
begin
   data_cnt= i;
   len = 128 + {$random}%(512 - 128);
   U_ephy_hm.send_frame_100M(len, i);
   $display("%d   %d",$realtime, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
