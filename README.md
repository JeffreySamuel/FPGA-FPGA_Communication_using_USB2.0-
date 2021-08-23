# FPGA-FPGA_Communication_using_USB2.0-
This project uses a universal serial bus (USB) transceiver with a serial interface engine (SIE) and an asynchronous ﬁrst-in ﬁrst-out (FIFO) queue for packet transformation and data transmission in FPGA to FPGA communication.
We have used Verilog HDL(Hardware Descriptive Language) to code the functionality of the SIE using Xilinx Vivado. The SIE is the frontend of the USB hardware and handles most of the protocol functionalities. IPs(Intellectual Property) like PLLs(Phase Locked Loop), ROM(Read Only Memory) and FIFO(First In First Out) are then incorporated into the block design to design the full project.
Block Diagram of SIE:
