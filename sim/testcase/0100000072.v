// 100M 模式，混合多种长度(64/128/256/512/1518)，提高 rx/tx ctrl 分支覆盖
U_clockGenerator.RESET;

testcase_name = "0100000072" ;
mode=1'b0;
CHOOSE_MODE;
#100;
   i=0;
repeat(20)
begin
   data_cnt= i;
   len = 64;
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end
repeat(20)
begin
   data_cnt= i;
   len = 128;
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end
repeat(20)
begin
   data_cnt= i;
   len = 256;
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end
repeat(20)
begin
   data_cnt= i;
   len = 512;
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end
repeat(20)
begin
   data_cnt= i;
   len = 1518;
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
