// 100M 模式，Rx_er 注入帧，覆盖 MAC_rx 错误与 RMON 错误类型路径
U_clockGenerator.RESET;

testcase_name = "0100000076" ;
mode=1'b0;
CHOOSE_MODE;
#100;
   i=0;
repeat(30)
begin
   data_cnt= i;
   len = 64 + {$random}%(256 - 64);
   U_ephy_hm.send_frame_100M_rxerr(len, i);
   $display("%d   %d",$realtime, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
