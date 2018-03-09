
#clock
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { CLK }]; #IO_L11P_T1_SRCC_35 Sch=sysclk
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { CLK }];

# disp
#jb
set_property -dict { PACKAGE_PIN Y18   IOSTANDARD LVCMOS33 } [get_ports { DISP[0] }]; #IO_L17P_T2_34 Sch=JB3_P
set_property -dict { PACKAGE_PIN Y19   IOSTANDARD LVCMOS33 } [get_ports { DISP[1] }]; #IO_L17N_T2_34 Sch=JB3_N
set_property -dict { PACKAGE_PIN W18   IOSTANDARD LVCMOS33 } [get_ports { DISP[2] }]; #IO_L22P_T3_34 Sch=JB4_P
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports { DISP[3] }]; #IO_L22N_T3_34 Sch=JB4_N
#jc
set_property -dict { PACKAGE_PIN W14   IOSTANDARD LVCMOS33 } [get_ports { DISP[4] }]; #IO_L8P_T1_34 Sch=JC3_P
set_property -dict { PACKAGE_PIN Y14   IOSTANDARD LVCMOS33 } [get_ports { DISP[5] }]; #IO_L8N_T1_34 Sch=JC3_N
set_property -dict { PACKAGE_PIN T12   IOSTANDARD LVCMOS33 } [get_ports { DISP[6] }]; #IO_L2P_T0_34 Sch=JC4_P
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { DISP[7] }]; #IO_L2N_T0_34 Sch=JC4_N


#keyboard
#je
set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { KEY_ROW[0] }]; #IO_L4P_T0_34 Sch=JE1
set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { KEY_ROW[1] }]; #IO_L18N_T2_34 Sch=JE2
set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { KEY_ROW[2] }]; #IO_25_35 Sch=JE3
set_property -dict { PACKAGE_PIN H15   IOSTANDARD LVCMOS33 } [get_ports { KEY_ROW[3] }]; #IO_L19P_T3_35 Sch=JE4

set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { KEY_COL[0] }]; #IO_L3N_T0_DQS_34 Sch=JE7
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { KEY_COL[1] }]; #IO_L9N_T1_DQS_34 Sch=JE8
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports { KEY_COL[2] }]; #IO_L20P_T3_34 Sch=JE9
set_property -dict { PACKAGE_PIN Y17   IOSTANDARD LVCMOS33 } [get_ports { KEY_COL[3] }]; #IO_L7N_T1_34 Sch=JE10