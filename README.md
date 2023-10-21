# 1:4 Demultiplexer

## Introduction

A 1:4 demultiplexer, also known as a 1-to-4 demux or simply a 1-to-4 decoder, is a digital logic circuit that takes a single input and directs it to one of four possible outputs based on the input signal. It is the opposite of a multiplexer, which takes multiple inputs and directs one of them to a single output.

A 1:4 demultiplexer has one input line (often labeled as D) and four output lines (often labeled as Y0, Y1, Y2, and Y3). The selection of which output to direct the input to is determined by the binary value applied to the control inputs. Typically, a 2-bit control input is used to select one of the four outputs, as follows:

When the control inputs are 00 (binary), the input is directed to Y0.
When the control inputs are 01 (binary), the input is directed to Y1.
When the control inputs are 10 (binary), the input is directed to Y2.
When the control inputs are 11 (binary), the input is directed to Y3.
This demultiplexer is often used in digital circuits to distribute data or control signals to one of multiple output lines based on the control inputs. It can be implemented using various digital logic gates, such as AND gates and NOT gates.

![1-to-4-Demux](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/5d6bf040-ce7a-48f0-a3e0-6565c84d1e89)


![aat12](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/80f5bc4b-9ca1-4c54-94a0-8a5698f811b0)


## 1:4 Demultiplexer Truth Table
The Truth Table for a 1:4 Demultiplexer is given below (Where S0,S1 are the three select lines and Y0,Y1,Y2,Y3 are the four outputs of 1:4 Demultiplexer):

![aat11](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/eff777d6-2a43-4866-95fa-6e70a95a38f9)


## Verilog Code for 1:4 Demultiplexer

The Verilog code for 1:4 Demultiplexer is given below :
```
module pes_1_4_demux (output o0 , output o1, output o2 , output o3, input [1:0] sel  , input i);
reg [3:0]y_int;
assign {o3,o2,o1,o0} = y_int;
integer k;
always @ (*)
begin
y_int = 4'b0;
	case(sel)
		3'b00 : y_int[0] = i;
		3'b01 : y_int[1] = i;
		3'b10 : y_int[2] = i;
		3'b11 : y_int[3] = i;
	endcase

end
endmodule
```

![aat01](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/8d520f2a-5f99-4706-8d34-ccfbcecf7814)


## Test Bench Code for 1:4 Demultiplexer

```
`timescale 1ns / 1ps
module pes_1_4_demux_tb();
	// Inputs
	reg i;
	reg [1:0] sel;
	
	//TB Signals
	reg clk,reset;

	// Outputs
	wire o3,o2,o1,o0;

        // Instantiate the Unit Under Test (UUT)
	pes_1_4_demux uut (
		.sel(sel),
		.o0(o0),
		.o1(o1),
		.o2(o2),
		.o3(o3),
		.i(i)
	);

	initial begin
	$dumpfile("pes_1_4_demux_tb.vcd");
	$dumpvars(0,pes_1_4_demux_tb);
	// Initialize Inputs
	i = 1'b0;
	clk = 1'b0;
	reset = 1'b0 ;  #1;
	reset = 1'b1 ;  #10;
	reset = 1'b0;

	#3900 $finish;
	end

always #17 i = ~i;
always #300 clk = ~clk;

always @ (posedge clk , posedge reset)
begin
	if(reset)
		sel <= 3'b000;
	else
		sel <= sel + 1;
end



endmodule
```

![aat02](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/a789f35c-dab7-4b29-abad-204d0d6e8fab)


## Simulation
Code for the simulation is given below:
```
iverilog pes_1_4_demux.v pes_1_4_demux_tb.v
```
```
./a.out
```
```
gtkwave pes_1_4_demux_tb.vcd
```

![aat1](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/8f319b7f-d269-448e-b6fc-e5f6ccb991a7)

## Synthesis
Code for the synthesis is given below:
```
yosys> read_liberty -lib /home/atom/VLSI/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
```
yosys> read_verilog pes_1_4_demux.v
```
```
yosys> synth -top pes_1_4_demux
```
![aat21](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/61458170-416f-4252-99b6-fb06b86fac8b)

![aat22](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/f6248763-c54d-4f54-b814-96d420d1fa49)

```
yosys> abc -liberty /home/atom/VLSI/sky130RTLDesignAndSynthesisWorkshop/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
```
![aat24](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/568f02db-cdd6-4d4a-82ea-1718f4031236)

```
yosys> show
```
![aat25](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/9de432da-5e94-41ba-b7f6-7705ba394203)

![aat23](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/32bf5118-d706-4764-bf0c-0bdc2f07c47c)

```
write_verilog -noattr pes_1_4_demux_netlist.v
!gvim pes_1_4_demux_netlist.v
```

![aat33](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/9b20a1fe-440c-437b-8a06-2afac6c7e7fc)


## Gate level simulation (GLS)
Code for gate level simulation is given below:
```
iverilog /home/atom/VLSI/sky130RTLDesignAndSynthesisWorkshop/my_lib/verilog_model/sky130_fd_sc_hd.v pes_1_4_demux.v pes_1_4_demux_tb.v
```
```
./a.out
```
```
gtkwave pes_1_4_demux_tb.vcd
```
![aat3](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/292dfe12-eb14-4765-b22b-c7df6f77d4f1)
