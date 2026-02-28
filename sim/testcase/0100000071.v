// 100M 模式，使能 CRC 校验，覆盖 CRC_chk 相关路径
U_clockGenerator.RESET;

testcase_name = "0100000071" ;
mode=1'b0;
CHOOSE_MODE;
#100;
U_host_sim.CPU_wr(7'd24, 16'h0001);   // CRC_chk_en
#200;
   i=0;
repeat(50)
begin
   data_cnt= i;
   len = 64 + {$random}%(1024 - 64);
   U_ephy_hm.send_frame_100M(len, i);
   $display("%d   %d",$realtime, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
