// 100M 模式，使能广播过滤，覆盖 Broadcast_filter 分支
U_clockGenerator.RESET;

testcase_name = "0100000068" ;
mode=1'b0;
CHOOSE_MODE;
#100;
U_host_sim.CPU_wr(7'd18, 16'h0001);   // broadcast_filter_en
U_host_sim.CPU_wr(7'd19, 16'd100);    // broadcast_bucket_depth
U_host_sim.CPU_wr(7'd20, 16'd10);     // broadcast_bucket_interval
#200;
   i=0;
repeat(60)
begin
   data_cnt= i;
   len = 64 + {$random}%(256 - 64);
   U_ephy_hm.send_frame_100M(len, i);
   $display("%d   %d",$realtime, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
