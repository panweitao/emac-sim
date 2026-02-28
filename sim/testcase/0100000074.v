// 100M 模式，xoff_cpu/xon_cpu 流控，覆盖 flow_ctrl 与 MAC_tx 相关分支
U_clockGenerator.RESET;

testcase_name = "0100000074" ;
mode=1'b0;
CHOOSE_MODE;
#100;
U_host_sim.CPU_wr(7'd11, 16'h0001);   // tx_pause_en
#100;
U_host_sim.CPU_wr(7'd12, 16'h0001);   // xoff_cpu
#5000;
U_host_sim.CPU_wr(7'd12, 16'h0000);   // xoff_cpu clear
#500;
U_host_sim.CPU_wr(7'd13, 16'h0001);   // xon_cpu
#5000;
U_host_sim.CPU_wr(7'd13, 16'h0000);   // xon_cpu clear
#500;
   i=0;
repeat(40)
begin
   data_cnt= i;
   len = 64 + {$random}%(512 - 64);
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
