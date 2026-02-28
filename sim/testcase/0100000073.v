// 1000M 模式，混合多种长度 + 更多帧数，提高 TX 路径与 RMON 覆盖
U_clockGenerator.RESET;

testcase_name = "0100000073" ;
mode=1'b1;
CHOOSE_MODE;
#100;
   i=0;
repeat(40)
begin
   data_cnt=i;
   len = 64;
   U_ephy_hm.send_frame_1000M(len, data_cnt);
   i = i + 1;
end
repeat(40)
begin
   data_cnt=i;
   len = 512;
   U_ephy_hm.send_frame_1000M(len, data_cnt);
   i = i + 1;
end
repeat(40)
begin
   data_cnt=i;
   len = 1518;
   U_ephy_hm.send_frame_1000M(len, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
