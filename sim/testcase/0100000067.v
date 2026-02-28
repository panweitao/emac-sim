// 1000M 模式，最大长度帧(1518字节)覆盖
U_clockGenerator.RESET;

testcase_name = "0100000067" ;
mode=1'b1;
CHOOSE_MODE;
#100;
   i=0;
repeat(50)
begin
   data_cnt=i;
   len = 1518;
   U_ephy_hm.send_frame_1000M(len, data_cnt);
   $display("%d   %d",$realtime, i);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
