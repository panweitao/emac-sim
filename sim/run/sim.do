if { $argc != 0 } {
	vlog -work      work   -f   FileList.lst
	restart
	log -r /*
	run -all
} else {

#退出仿真，清空命令行（.main clear 仅 GUI 有效，批处理时跳过）
    quit -sim
    catch { .main clear }

#在根目录下建立库文件
    vlib ./lib/
    vlib ./lib/work

#库文件地址映射
    vmap    work   ./lib/work

vlib work
vlog -f  ../filelist/sim_filelist.v
vlog -f  ../filelist/hdl_filelist.v  -cover bcesxf

vsim -voptargs=+acc -coverage work.testbench

log -r /*
catch { do ./wave.do }

run -all

# 保存覆盖率数据库并生成报告（用于评估 hdl_filelist 设计覆盖率）
coverage save -onexit coverage.ucdb
coverage report -detail -output coverage_report.txt
coverage report -detail -code bces -output coverage_summary.txt
quit -f

}

