// 主机多寄存器读，覆盖 Reg_int/RegCPUData 读路径及 RMON 读
U_clockGenerator.RESET;

testcase_name = "0100000075" ;
mode=1'b0;
CHOOSE_MODE;
#100;
U_host_sim.CPU_rd(7'd0);
U_host_sim.CPU_rd(7'd1);
U_host_sim.CPU_rd(7'd2);
U_host_sim.CPU_rd(7'd3);
U_host_sim.CPU_rd(7'd4);
U_host_sim.CPU_rd(7'd5);
U_host_sim.CPU_rd(7'd6);
U_host_sim.CPU_rd(7'd7);
U_host_sim.CPU_rd(7'd8);
U_host_sim.CPU_rd(7'd9);
U_host_sim.CPU_rd(7'd10);
U_host_sim.CPU_rd(7'd11);
U_host_sim.CPU_rd(7'd12);
U_host_sim.CPU_rd(7'd13);
U_host_sim.CPU_rd(7'd14);
U_host_sim.CPU_rd(7'd15);
U_host_sim.CPU_rd(7'd16);
U_host_sim.CPU_rd(7'd17);
U_host_sim.CPU_rd(7'd18);
U_host_sim.CPU_rd(7'd19);
U_host_sim.CPU_rd(7'd20);
U_host_sim.CPU_rd(7'd21);
U_host_sim.CPU_rd(7'd22);
U_host_sim.CPU_rd(7'd23);
U_host_sim.CPU_rd(7'd24);
U_host_sim.CPU_rd(7'd25);
U_host_sim.CPU_rd(7'd26);
U_host_sim.CPU_rd(7'd27);
U_host_sim.CPU_rd(7'd28);
U_host_sim.CPU_rd(7'd29);
U_host_sim.CPU_rd(7'd33);
U_host_sim.CPU_rd(7'd34);
#200;
   i=0;
repeat(30)
begin
   data_cnt= i;
   len = 64 + {$random}%(1518 - 64);
   U_ephy_hm.send_frame_100M(len, i);
   i = i + 1;
end

$display("\n %d %s is done!!!-----------------------------------------",$realtime, testcase_name);

U_data_cmp.OVER;
