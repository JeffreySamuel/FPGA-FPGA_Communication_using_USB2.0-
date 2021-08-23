# FPGA-FPGA_Communication_using_USB2.0-
This project uses a universal serial bus (USB) transceiver with a serial interface engine (SIE) and an asynchronous ﬁrst-in ﬁrst-out (FIFO) queue for packet transformation and data transmission in FPGA to FPGA communication.
We have used Verilog HDL(Hardware Descriptive Language) to code the functionality of the SIE using Xilinx Vivado. The SIE is the frontend of the USB hardware and handles most of the protocol functionalities. IPs(Intellectual Property) like PLLs(Phase Locked Loop), ROM(Read Only Memory) and FIFO(First In First Out) are then incorporated into the block design to design the full project.




Block Diagram of SIE:

![SIE block_author](https://user-images.githubusercontent.com/85092975/130498154-3d4c2aa1-3ed3-4845-9ebb-9046b1c2193f.jpg)




System Topology of proposed project:

![Sys_topology](https://user-images.githubusercontent.com/85092975/130498968-0346a8e8-61cf-4d6a-8501-3459f3b7fea0.jpg)
