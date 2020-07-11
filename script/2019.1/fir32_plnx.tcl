## Script name:   project1
## Script version:  1.0
## Author:  P.Trujillo (pablo@controlpaths.com)
## Date:    Mar20
## Description: Script for create eclypsez7_adc_dac project

set projectDir ../../project
set projectName eclypsez7_fir_plnx_2019.1
set bdName eclypsez7_fir_bd
set srcDir ../../src
set xdcDir ../../xdc

## Create project in ../project
create_project -force $projectDir/$projectName.xpr

## Set verilog as default language
set_property target_language Verilog [current_project]

## Set current board eclypsez7.
set_property BOARD_PART digilentinc.com:eclypse-z7:part0:1.0 [current_project]

## Adding verilog files
add_file [glob $srcDir/cen_generator_v1_0.v]
add_file [glob $srcDir/fir32_14b_v1_0.v]
add_file [glob $srcDir/fir32_14b_v1_0.v]
add_file [glob $srcDir/obufds_inst.v]
add_file [glob $srcDir/signal_bram_reader_v1_0.v]
add_file [glob $srcDir/zmod_dac_driver_v1_1.v]

## Adding memory files
add_file [glob ../memory_content/signal2.mem]

## Adding constraints files
read_xdc $xdcDir/eclypse_z7_dac_a_adc_b.xdc

## Create block design
create_bd_design $bdName

## Add ip repo
set_property ip_repo_paths {../../ip_repo} [current_project]
update_ip_catalog

## Configure block design through external file
source ./bd/eclypsez7_fir_plnx.tcl

## Regenerate block design layout
regenerate_bd_layout

## Validate block design design
validate_bd_design

## Generate and add wrapper file for synthesis
make_wrapper -files [get_files $projectDir/$projectName.srcs/sources_1/bd/$bdName/$bdName.bd] -top

## Open vivado for verify
start_gui
