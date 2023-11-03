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


## RTL Pre-Simulation
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
### Synthesized Circuit 
![aat25](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/9de432da-5e94-41ba-b7f6-7705ba394203)

![aat23](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/32bf5118-d706-4764-bf0c-0bdc2f07c47c)

```
write_verilog -noattr pes_1_4_demux_netlist.v
!gvim pes_1_4_demux_netlist.v
```

![aat33](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/9b20a1fe-440c-437b-8a06-2afac6c7e7fc)


## Gate level simulation (GLS) Post-Simulation
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

## Physical Design from Netlist to GDSII
## Installation of ngspice magic and OpenLANE

**ngspice**
- Download the tarball from https://sourceforge.net/projects/ngspice/files/ to a local directory
```
cd $HOME
sudo apt-get install libxaw7-dev
tar -zxvf ngspice-41.tar.gz
cd ngspice-41
mkdir release
cd release
../configure  --with-x --with-readline=yes --disable-debug
sudo make
sudo make install
```

**magic**
```
sudo apt-get install m4
sudo apt-get install tcsh
sudo apt-get install csh
sudo apt-get install libx11-dev
sudo apt-get install tcl-dev tk-dev
sudo apt-get install libcairo2-dev
sudo apt-get install mesa-common-dev libglu1-mesa-dev
sudo apt-get install libncurses-dev
git clone https://github.com/RTimothyEdwards/magic
cd magic
./configure
sudo make
sudo make install
```

**OpenLANE**
```
sudo apt-get update
sudo apt-get upgrade
sudo apt install -y build-essential python3 python3-venv python3-pip make git

sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io
sudo docker run hello-world
sudo groupadd docker
sudo usermod -aG docker $USER
sudo reboot 
# After reboot
docker run hello-world (should show you the output under 'Example Output' in https://hub.docker.com/_/hello-world)

- To install the PDKs and Tools
cd $HOME
git clone https://github.com/The-OpenROAD-Project/OpenLane
cd OpenLane
make
make test
```
## OpenLane Flow

![opd0](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/dbdc4c10-0a76-4ebc-bc9d-702176d70564)

OpenLANE flow consists of several stages. By default, all flow steps are run in sequence. Each stage may consist of multiple sub-stages. OpenLANE can also be run interactively as shown here.

  1. Synthesis

  <ul>
      <li>Yosys - Performs RTL synthesis using GTech mapping</li>
      <li>abc - Performs technology mappin to standard cells described in the PDK. We can adjust synthesis techniques using different integrated abc scripts to get desired results</li>
      <li>OpenSTA - Performs static timing analysis on the resulting netlist to generate timing reports</li>
      <li>Fault – Scan-chain insertion used for testing post fabrication. Supports ATPG and test patterns compaction</li>
  </ul>

  2. Floorplan and PDN

  <ul>
      <li>Init_fp - Defines the core area for the macro as well as the rows (used for placement) and the tracks (used for routing)</li>
      <li>Ioplacer - Places the macro input and output ports</li>
      <li>PDN - Generates the power distribution network</li>
      <li>Tapcell - Inserts welltap and decap cells in the floorplan</li>
      <li>Placement – Placement is done in two steps, one with global placement in which we place the designs across the chip, but they will not be legal placement with some standard cells overlapping each other, to fix this we perform a detailed placement which legalizes the design and ensures they fit in the standard cell rows</li>
      <li>RePLace - Performs global placement</li>
      <li>Resizer - Performs optional optimizations on the design</li>
      <li>OpenPhySyn - Performs timing optimizations on the design</li>
      <li>OpenDP - Perfroms detailed placement to legalize the globally placed components</li>
  </ul>
  3. CTS

  <ul>
      <li>TritonCTS - Synthesizes the clock distribution network</li>
  </ul>


4. Routing

  <ul>
      <li>FastRoute - Performs global routing to generate a guide file for the detailed router
      </li>
      <li>TritonRoute - Performs detailed routing from global routing guides</li>
      <li>SPEF-Extractor - Performs SPEF extraction that include parasitic information</li>
  </ul>

5. GDSII Generation

  <ul>
      <li>Magic - Streams out the final GDSII layout file from the routed def</li>
  </ul>

 6. Checks

  <ul>
      <li>Magic - Performs DRC Checks & Antenna Checks</li>
      <li>Netgen - Performs LVS Checks </li>
  </ul>

## OpenLANE Flow

![opd1](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/5c377c01-59b4-465b-a801-4c62218c90ff)
- First we create a folder under the name of our design in the 'designs' folder.
- Do ```cd pes_1_4_demux```.
- Here we create a config.json file.
  ![opd3](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/18b7bddd-de28-4717-9bc1-8db94267bb85)

- We make a new directory called 'src'.
- Do ```cd src```
- We add the following files to this directory.
- All these files are found above in the 'pes_ripple_counter' folder.

![opd2](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/d7667e28-4f00-4b2c-b3e5-e1fdaabf1345)

- Now in the main 'Openlane' directory type ```mkdir pdks```.
- Copy paste the above file in it. Found in the verilog_model folder above.

![opd4](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/fd50867a-06b6-41bf-b716-c9c445220f26)
```
make mount
./flow.tcl -interactive
package require openlane 0.9
prep -design pes_1_4_demux
```

Merging LEF FILE
![opd5](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/68314637-5443-4192-a1f9-9c1af7328f3c)
```
set lefs [glob $::env(DESIGN_DIR)/src/*.lef]
add_lefs -src $lefs
```



### Synthesis
![opd6](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/17eb430a-2702-4890-a72a-3bb5e64149b6)
```
run_synthesis
```

**Physical Cells**

![opd7](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/4590bf65-30ac-4be0-b460-4032b273d6ef)

### Floorplan
![opd8](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/c7b2be25-993e-459d-959a-aba949253861)

```
run_floorplan
```


- To view the design,
- Open a new terminal with the path leading to the floorplan in results in the runs folder
- 
![opd9](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/c1a1c7be-8903-4785-9544-4add079bd42f)


```
magic -T /home/atom/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_1_4_demux.def &
```

![opd14](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/69622793-99c5-47aa-8ade-4cec3fc37666)

![opd13](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/7292f1e4-a8b7-4436-a2c4-cf701ac75b59)

![opd11](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/80ca2b77-1ae1-4c42-97c3-241438a0a449)

![opd12](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/07fa3826-1d9d-47f4-8244-2380d821ab69)


### Placement
- Now to run the placement we type
```
run_placement
```

![opd15](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/5be5ab10-48e9-40c0-92fb-1c958fa806a1)


- To view the design we type
```
magic -T /home/atom/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_1_4_demux.def &
```

![opd16](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/b3c09e6a-f48a-4bdd-8eba-be9b5d21b36c)

![opd17](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/1f509d0b-1b54-4dca-a631-bd818806f666)


### CTS(Clock Tree Synthesis)
- Now to run cts we type
```
run_cts
```
![opd18](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/a28fbbfc-688a-4692-a9f5-ba93ee08702f)

- The reports generated are given below

![opd19](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/de59c2f8-e595-463d-8a8e-d7ca759953d8)

![opd20](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/f24fbd84-4941-4956-a5aa-6a335f10eab5)

![opd21](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/29fac895-b88f-41bd-88f3-18abe138259a)

![opd22](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/bd468ab0-942d-46fc-8752-03c9b77e6207)



**Power Report**

![opd25](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/03dd3788-a445-42f2-9f9f-f98519e1acab)

**Skew Report**

![opd26](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/24f90b80-e618-4ae7-83fa-2e208820cd57)

**Area Report**

![opd27](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/e0ac7e01-6998-495a-98ef-6499d30e0a4f)

### Routing

- Now to run routing we type
```
run_routing
```
![opd28](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/daa5b21e-9457-47f6-9653-88289687a0be)

- To view the design we type
```
magic -T /home/atom/OpenLane/pdks/sky130A/libs.tech/magic/sky130A.tech lef read ../../tmp/merged.nom.lef def pes_1_4_demux.def &
```
![opd29](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/bda9d541-3eb7-4bfd-ae36-bc252947f7e5)

![opd30](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/4103b4d9-c567-4dd6-8e0f-0a84493057fc)

![opd31](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/759f2c3c-6750-499c-80e2-336c3d975cec)

![opd32](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/0b23c42b-c03f-4de4-9874-d8d002a638b0)


**Congestion Report**

![opd33](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/26b5356b-0897-4292-9b68-f11459c30555)

**Power and Clock Skew Report**

![opd36](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/1b44db75-b8bf-4ec4-9181-b91986852185)

![opd40](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/cc7ec654-4bab-4fa4-8e98-08d5570b14c3)


**Summary Report and Area Report**

![opd37](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/0c999a07-a5f1-4b92-b431-80b055b57ef1)

![opd35](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/ae918eaf-6543-4961-ad1e-30b975f14143)

**Placement and Design Analysis**

![opd34](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/d7a7bd43-a50a-4354-939d-50ec4b08ca11)

![opd38](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/d31111ff-3888-4cfc-98b8-e27d7e12c1ba)

![opd39](https://github.com/Aatish-Om/pes_1_4_demux/assets/125562864/8ecb7102-60a5-4f34-ae06-236a42b83720)





**Statistics**
- Area = 96 u^2 12% utilization
- Internal Power = 1.49e-06 W 
- Switching Power = 2.51e-06 W
- Leakage Power =  1.11e-10 W
- Total Power = 4.00e-06 W
