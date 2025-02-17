set_property PACKAGE_PIN N16 [get_ports red]
set_property PACKAGE_PIN R11 [get_ports green]
set_property PACKAGE_PIN G14 [get_ports blue]

set_property IOSTANDARD LVCMOS33 [get_ports red]
set_property IOSTANDARD LVCMOS33 [get_ports green]
set_property IOSTANDARD LVCMOS33 [get_ports blue]

set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { a1 }];
set_property -dict { PACKAGE_PIN L16   IOSTANDARD LVCMOS33 } [get_ports { a2 }];
set_property -dict { PACKAGE_PIN M13   IOSTANDARD LVCMOS33 } [get_ports { b1 }];
set_property -dict { PACKAGE_PIN R15   IOSTANDARD LVCMOS33 } [get_ports { b2 }];