// 主机寄存器读 + RMON 读触发，覆盖 Reg_int/CPU_rd、RMON 路径
U_clockGenerator.RESET;

testcase_name = "0100000070" ;
mode=1'b0;
CHOOSE_MODE;
#100;
U_host_sim.CPU_rd(7'd34);   // read Speed
#50;
U_host_sim.CPU_rd(7'd33);   // read Line_loop_en
#50;
U_host_sim.CPU_wr(7'd28, 16'h0000);   // CPU_rd_addr
U_host_sim.CPU_wr(7'd29, 16'h0001);   // CPU_rd_apply
#100;
U_host_sim.CPU_wr(7'd29, 16'h0000);   // clear CPU_rd_apply
#100;
   i=0;
repeat(50)
begin
   data_cnt= i;
   len = 64 + {$random}%(1518 - 64);
   U_ephy_hm.send_frame_100M(len, i);
   $display("%d   %d",$realtime, data_cnt);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
