# https://github.com/Digilent/digilent-xdc/blob/master/Arty-A7-35-Master.xdc

set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { CLK100MHZ }]; #IO_L12P_T1_MRCC_35 Sch=gclk[100]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { CLK100MHZ }];

## RGB LEDs
set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { led_data[0] }]; #IO_L19P_T3_35 Sch=led0_r
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { led_data[1] }]; #IO_L18N_T2_35 Sch=led0_b
set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { led_data[2] }]; #IO_L20N_T3_35 Sch=led1_r
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { led_data[3] }]; #IO_L20P_T3_35 Sch=led1_b
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { led_data[4] }]; #IO_L22P_T3_35 Sch=led2_r
set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { led_data[5] }]; #IO_L21N_T3_DQS_35 Sch=led2_b
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { led_data[6] }]; #IO_L23N_T3_35 Sch=led3_r
set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { led_data[7] }]; #IO_L23P_T3_35 Sch=led3_b

# LEDs
set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { led_oeb }]; #IO_L24N_T3_35 Sch=led[4]
set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { led_reset_vector }]; #IO_25_35 Sch=led[5]
set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { led_spi }]; #IO_L24P_T3_A01_D17_14 Sch=led[6]
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { led_reset3 }]; #IO_L24N_T3_A00_D16_14 Sch=led[7]

## ChipKit Outer Digital Header
set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[0]  }]; #IO_L16P_T2_CSI_B_14
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[1]  }]; #IO_L18P_T2_A12_D28_14
set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[2]  }]; #IO_L8N_T1_D12_14
set_property -dict { PACKAGE_PIN T11   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[3]  }]; #IO_L19P_T3_A10_D26_14
set_property -dict { PACKAGE_PIN R12   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[4]  }]; #IO_L5P_T0_D06_14
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[5]  }]; #IO_L14P_T2_SRCC_14
set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[6] }]; #IO_L14N_T2_SRCC_14]
set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[7]  }]; #IO_L15N_T2_DQS_DOUT_CSO_B_14
set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[8]  }]; #IO_L11P_T1_SRCC_14
set_property -dict { PACKAGE_PIN M16   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[9]  }]; #IO_L10P_T1_D14_14
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[10] }]; #IO_L18N_T2_A11_D27_14
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[11] }]; #IO_L17N_T2_A13_D29_14
set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[12] }]; #IO_L12N_T1_MRCC_14
set_property -dict { PACKAGE_PIN P17   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[13] }]; #IO_L12P_T1_MRCC_14

## ChipKit Inner Digital Header
#set_property -dict { PACKAGE_PIN U11   IOSTANDARD LVCMOS33 } [get_ports { rom_addr[14] }]; #IO_L19N_T3_A09_D25_VREF_14
set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { oeb }]; #IO_L16N_T2_A15_D31_14
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { rom_data[0] }]; #IO_L6N_T0_D08_VREF_14
set_property -dict { PACKAGE_PIN R10   IOSTANDARD LVCMOS33 } [get_ports { rom_data[1] }]; #IO_25_14
set_property -dict { PACKAGE_PIN R11   IOSTANDARD LVCMOS33 } [get_ports { rom_data[2] }]; #IO_0_14
set_property -dict { PACKAGE_PIN R13   IOSTANDARD LVCMOS33 } [get_ports { rom_data[3] }]; #IO_L5N_T0_D07_14
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { rom_data[4] }]; #IO_L13N_T2_MRCC_14
set_property -dict { PACKAGE_PIN P15   IOSTANDARD LVCMOS33 } [get_ports { rom_data[5] }]; #IO_L13P_T2_MRCC_14
set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { rom_data[6] }]; #IO_L15P_T2_DQS_RDWR_B_14
set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { rom_data[7] }]; #IO_L11N_T1_SRCC_14
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { spi_clk }]; #IO_L8P_T1_D11_14 			Sch=ck_io[36]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { spi_cipo }]; #IO_L17P_T2_A14_D30_14 		Sch=ck_io[37]
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports { spi_copi }]; #IO_L7N_T1_D10_14 			Sch=ck_io[38]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { spi_cs }]; #IO_L7P_T1_D09_14