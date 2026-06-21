
### FPGA SoC with AXI framebuffer-based VGA system

This is the project I made for my internship. This is a graphics system paired with a processor for displaying on a VGA display. This project is capable of driving a 640x480 display at 60Hz.

#### Features:
## Features

- Generates a standard 640×480 VGA output at 60 Hz, including HSYNC, VSYNC, and RGB video signals.
- Implements a 160×120 BRAM-based framebuffer with hardware scaling to a 640×480 display, reducing on-chip memory usage.
- Supports memory-mapped framebuffer read and write operations through an AXI4-Lite slave interface.
- Includes a sprite controller capable of rendering graphical objects on the display.
- Integrates with a MicroBlaze soft processor, demonstrating hardware-software communication in an FPGA-based SoC.
- Modular graphics pipeline consisting of a VGA controller, framebuffer, video engine, sprite controller, and AXI interface.
- Fully verified through Verilog simulation, with framebuffer dump reconstruction using Python for visual output verification.
- Designed with future extensibility in mind, allowing features such as multiple sprites, double buffering, and hardware graphics primitives to be added.

<img width="388" height="517" alt="image" src="https://github.com/user-attachments/assets/80caa610-1581-466c-a48d-445e448e28a7" />


#### Simple descriptions of Modules:

VGA Controller: This module is responsible for generating the actual data responsible for driving the monitor. In a nutshell, this module outputs five main signals:- Hsync, Vsync and individual RGB signals.

A standard VGA runs on a precise 25.175Mhz clock. But most monitors accept 25 Mhz which I have also used, this is done by slowing down a 100Mhz clock via logic. This is a very barebones way of generating a 25Mhz clock signals and there are much better ways of doing it, like using the vivado clock wizard to generate a precise and reliable 25.175Mhz clock.

Framebuffer: A framebuffer is a chunk of memory where the image data is stored. For the sake of efficiency and saving BRAM space, the 640x480 size image is stored as a shrunken 160x120 image in the framebuffer. This module is capable of reads and writes.

Video Engine: This is the graphics processing unit(a very basic version of it) of the system. This module controls how the VGA controller, frame buffer, and sprite controller interact with each other to create the final output in terms of the RGB pixel values that are shown on the VGA monitor

Sprite Controller: A sprite is the an element on the screen which we see, it is an area of the framebuffer. This can be anything, a cursor, text or image etc. I have only implemented functionality for displaying a single sprite for now. The sprite controller calculates the sprite position in the framebuffer and outputs RGB pixel colours based on said position.

AXI4-Lite Interface: For this to be a proper SoC system, it needs a processor and AXI is used for communication between the graphics pipeline and CPU. The CPU sends commands like write_address, write_data and write_enable via the AXI slaves to the framebuffer which also has the corresponding commands and this way the CPU isn't individually drawing each pixel.

CPU: A MicroBlaze CPU is used for this project.
<img width="940" height="428" alt="image" src="https://github.com/user-attachments/assets/345aac1a-7e77-4d03-bef6-9c5166eb2e1f" />



#### Simulation:

There are test benches for each of modules and you can just get all them by running top_tb.v. I haven't used these much in the later stages, but what I have used a lot is the framebuffer dumping, where I write some data and dump the framebuffer and a  use python utility(Check imageViewer) to reconstruct the image and display it. It has worked well.

Example of framebuffer dump:

<img width="552" height="414" alt="image" src="https://github.com/user-attachments/assets/09b09af7-1db8-4772-9eaa-128fb982c931" />


In conclusion, this was a fun project to work on and there were more things I'd liked to include such as support for multiple sprites, double buffering to eliminate screen tearing, higher display resolutions, and hardware-accelerated graphics operations such as line and shape drawing. But oh well that's for a later day, and I have learned plenty with this project including the power of verilog which I can use in the future to design some cool stuff.

The only part missing with this project is that I wasn't able to verify this with actual hardware, but I don't really mind that. But one thing I will do is export this project's bitstream by by-passing some parameters and use vitis to write some C programs for this, which I will also document on GitHub.

For those who want it a bit more detailed:
 https://docs.google.com/document/d/1K7FmxZs1SK4d6Mg_av8xxSFclpn7vHY1/edit?usp=sharing&ouid=108525211905124825523&rtpof=true&sd=true
