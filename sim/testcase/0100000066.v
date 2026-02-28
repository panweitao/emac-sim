// 100M 模式，最小长度帧(64字节)覆盖
U_clockGenerator.RESET;

testcase_name = "0100000066" ;
mode=1'b0;
CHOOSE_MODE;
#100;
   i=0;
repeat(50)
begin
   data_cnt= i;
   len = 64;
   U_ephy_hm.send_frame_100M(len, i);
   $display("%d   %d",$realtime, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
