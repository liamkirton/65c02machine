# https://github.com/Digilent/digilent-xdc/blob/master/Arty-A7-35-Master.xdc

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { CLK100MHZ }];

## RGB LEDs
set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { out[0] }]; #IO_L19P_T3_35 Sch=led0_r
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { out[1] }]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { out[2] }]; #IO_L20N_T3_35 Sch=led1_r
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { out[3] }]; #IO_L20P_T3_35 Sch=led1_b
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { out[4] }]; #IO_L22P_T3_35 Sch=led2_r
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { out[5] }]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { out[6] }]; #IO_L23N_T3_35 Sch=led3_r
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { out[7] }]; #IO_L23P_T3_35 Sch=led3_b

# LEDs
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { led_oeb }]; #IO_L24N_T3_35 Sch=led[4]

## ChipKit Outer Digital Header
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { addr[0]  }]; #IO_L16P_T2_CSI_B_14
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { addr[1]  }]; #IO_L18P_T2_A12_D28_14
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { addr[2]  }]; #IO_L8N_T1_D12_14
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { addr[3]  }]; #IO_L19P_T3_A10_D26_14
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { addr[4]  }]; #IO_L5P_T0_D06_14
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { addr[5]  }]; #IO_L14P_T2_SRCC_14
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { addr[6] }]; #IO_L14N_T2_SRCC_14]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { addr[7]  }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { addr[8]  }]; #IO_L11P_T1_SRCC_14
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { addr[9]  }]; #IO_L10P_T1_D14_14
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { addr[10] }]; #IO_L18N_T2_A11_D27_14
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { addr[11] }]; #IO_L17N_T2_A13_D29_14
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { addr[12] }]; #IO_L12N_T1_MRCC_14
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { addr[13] }]; #IO_L12P_T1_MRCC_14

## ChipKit Inner Digital Header
#set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { addr[14] }]; #IO_L19N_T3_A09_D25_VREF_14
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { oeb }]; #IO_L16N_T2_A15_D31_14
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { data[0] }]; #IO_L6N_T0_D08_VREF_14
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { data[1] }]; #IO_25_14
set_property -dict { PACKAGE_PIN R11   IOSTANDARD LVCMOS33 } [get_ports { data[2] }]; #IO_0_14
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { data[3] }]; #IO_L5N_T0_D07_14
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { data[4] }]; #IO_L13N_T2_MRCC_14
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { data[5] }]; #IO_L13P_T2_MRCC_14
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { data[6] }]; #IO_L15P_T2_DQS_RDWR_B_14
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { data[7] }]; #IO_L11N_T1_SRCC_14