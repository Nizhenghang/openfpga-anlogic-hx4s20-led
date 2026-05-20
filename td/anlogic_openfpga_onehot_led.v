`default_nettype wire

// ===== BEGIN SRC\fabric_netlists_local.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Fabric Netlist Summary
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ------ Include defines: preproc flags -----

// ===== BEGIN SRC\fpga_defines.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Preprocessing flags to enable/disable features in FPGA Verilog modules
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// `define ENABLE_TIMING 1


// ===== END fpga_defines.v =====

// ------ Include user-defined netlists -----

// ===== BEGIN SRC\cell_library\dff.v =====
//-----------------------------------------------------
// Design Name : D-type Flip-flops
// File Name   : ff.v
// Coder       : Xifan TANG
//-----------------------------------------------------

//-----------------------------------------------------
// Function    : A native D-type flip-flop with single output
//-----------------------------------------------------
module DFFQ (
  input CK, // Clock Input
  input D, // Data Input
  output Q // Q output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ (posedge CK) begin 
  q_reg <= D;
end

assign Q = q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : A native D-type flip-flop
//-----------------------------------------------------
module DFF (
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  output QN // QB output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ (posedge CK) begin 
  q_reg <= D;
end

assign Q = q_reg;
assign QN = ~q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - single output
//               - asynchronous active high reset
//-----------------------------------------------------
module DFFRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q // Q output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else begin
  q_reg <= D;
end

assign Q = q_reg;

endmodule //End Of Module


//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//-----------------------------------------------------
module DFFR (
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  output QN // QB output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else begin
  q_reg <= D;
end

assign Q = q_reg;
assign QN = ~q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active low reset
//-----------------------------------------------------
module DFFRN (
  input RSTN, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  output QN // QB output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or negedge RSTN)
if (~RSTN) begin
  q_reg <= 1'b0;
end else begin
  q_reg <= D;
end

assign Q = q_reg;
assign QN = ~q_reg;

endmodule //End Of Module


//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high set
//-----------------------------------------------------
module DFFS (
  input SET, // Set input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  output QN // QB output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge SET)
if (SET) begin
  q_reg <= 1'b1;
end else begin
  q_reg <= D;
end

assign Q = q_reg;
assign QN = ~q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active low set
//-----------------------------------------------------
module DFFSN (
  input SETN, // Set input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  output QN // QB output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or negedge SETN)
if (~SETN) begin
  q_reg <= 1'b1;
end else begin
  q_reg <= D;
end

assign Q = q_reg;
assign QN = ~q_reg;

endmodule //End Of Module


//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - asynchronous active high set
//-----------------------------------------------------
module DFFSR (
  input SET, // set input
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  output QN // QB output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST or posedge SET)
if (RST) begin
  q_reg <= 1'b0;
end else if (SET) begin
  q_reg <= 1'b1;
end else begin
  q_reg <= D;
end

assign Q = q_reg;
assign QN = ~q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - asynchronous active high set
//-----------------------------------------------------
module DFFSRQ (
  input SET, // set input
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q // Q output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST or posedge SET)
if (RST) begin
  q_reg <= 1'b0;
end else if (SET) begin
  q_reg <= 1'b1;
end else begin
  q_reg <= D;
end

assign Q = q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function : A multi-functional D-type flip-flop with 
//           - asynchronous reset 
//             which can be switched between active-low and active high
//           - asynchronous set 
//             which can be switched between active-low and active high
//-----------------------------------------------------
module MULTI_MODE_DFFSRQ (
  input SET, // Set input
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  input [0:1] mode // mode-selection bits: bit0 for reset polarity; bit1 for set polarity
);

wire post_set = mode[1] ? ~SET : SET;
wire post_rst = mode[0] ? ~RST : RST;

DFFSRQ FF_CORE (.SET(post_set),
                .RST(post_rst),
                .CK(CK),
                .D(D),
                .Q(Q)
               );

endmodule //End Of Module

//-----------------------------------------------------
// Function : A multi-functional D-type flip-flop with 
//           - asynchronous reset 
//             which can be switched between active-low and active high
//-----------------------------------------------------
module MULTI_MODE_DFFRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  input mode // mode-selection bits: bit0 for reset polarity; bit1 for set polarity
);

wire post_rst = mode ? ~RST : RST;

DFFRQ FF_CORE (.RST(post_rst),
               .CK(CK),
               .D(D),
               .Q(Q)
               );

endmodule //End Of Module

//-----------------------------------------------------
// Function : A multi-functional D-type flip-flop with 
//           - asynchronous reset 
//             which can be switched between active-low and active high
//           - clock
//             which can be switched between positive edge triggered and negative edge triggered
//-----------------------------------------------------
module MULTI_MODE_DFFNRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input D, // Data Input
  output Q, // Q output
  input [0:1] mode // mode-selection bits: bit0 for reset polarity; bit1 for set polarity
);

wire post_rst = mode[0] ? ~RST : RST;
wire post_clk = mode[1] ? ~CK : CK;

DFFRQ FF_CORE (.RST(post_rst),
               .CK(post_clk),
               .D(D),
               .Q(Q)
               );

endmodule //End Of Module


//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - asynchronous active high set
//               - scan-chain input
//               - a scan-chain enable 
//-----------------------------------------------------
module SDFFSR (
  input SET, // Set input
  input RST, // Reset input
  input CK, // Clock Input
  input SE, // Scan-chain Enable
  input D, // Data Input
  input SI, // Scan-chain input
  output Q, // Q output
  output QN // Q negative output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST or posedge SET)
if (RST) begin
  q_reg <= 1'b0;
end else if (SET) begin
  q_reg <= 1'b1;
end else if (SE) begin
  q_reg <= SI;
end else begin
  q_reg <= D;
end

assign Q = q_reg;
assign QN = !Q;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - scan-chain input
//               - a scan-chain enable 
//-----------------------------------------------------
module SDFFRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input SE, // Scan-chain Enable
  input D, // Data Input
  input SI, // Scan-chain input
  output Q // Q output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else if (SE) begin
  q_reg <= SI;
end else begin
  q_reg <= D;
end

assign Q = q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - asynchronous active high set
//               - scan-chain input
//               - a scan-chain enable 
//-----------------------------------------------------
module SDFFSRQ (
  input SET, // Set input
  input RST, // Reset input
  input CK, // Clock Input
  input SE, // Scan-chain Enable
  input D, // Data Input
  input SI, // Scan-chain input
  output Q // Q output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST or posedge SET)
if (RST) begin
  q_reg <= 1'b0;
end else if (SET) begin
  q_reg <= 1'b1;
end else if (SE) begin
  q_reg <= SI;
end else begin
  q_reg <= D;
end

assign Q = q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - scan-chain input
//               - a scan-chain enable 
//               - a configure enable, when enabled the registered output will
//               be released to the Q
//-----------------------------------------------------
module CFGSDFFR (
  input RST, // Reset input
  input CK, // Clock Input
  input SE, // Scan-chain Enable
  input D, // Data Input
  input SI, // Scan-chain input
  input CFGE, // Configure enable
  output Q, // Regular Q output
  output CFGQ, // Data Q output which is released when configure enable is activated
  output CFGQN // Data Qb output which is released when configure enable is activated
);
//------------Internal Variables--------
reg q_reg;
wire QN;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else if (SE) begin
  q_reg <= SI;
end else begin
  q_reg <= D;
end

assign CFGQ = CFGE ? Q : 1'b0;
assign CFGQN = CFGE ? QN : 1'b1;

assign Q = q_reg;
assign QN = !Q;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - scan-chain input
//               - a scan-chain enable 
//               - a configure enable, when enabled the registered output will
//               be released to the CFGQ
//               - a configure done, when enable, the regsitered output will be released to the Q
//-----------------------------------------------------
module CFGDSDFFR (
  input RST, // Reset input
  input CK, // Clock Input
  input SE, // Scan-chain Enable
  input D, // Data Input
  input SI, // Scan-chain input
  input CFGE, // Configure enable
  input CFG_DONE, // Configure done
  output Q, // Regular Q output
  output CFGQ, // Data Q output which is released when configure enable is activated
  output CFGQN // Data Qb output which is released when configure enable is activated
);
//------------Internal Variables--------
reg q_reg;
wire QN;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else if (SE) begin
  q_reg <= SI;
end else begin
  q_reg <= D;
end

assign CFGQ = CFGE ? Q : 1'b0;
assign CFGQN = CFGE ? QN : 1'b1;

assign Q = CFG_DONE ? q_reg : 1'b0;
assign QN = CFG_DONE ? !Q : 1'b1;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
//               - scan-chain input
//               - a scan-chain enable 
//               - a configure enable, when enabled the registered output will
//               be released to the CFGQ
//               - a configure done, when enable, the regsitered output will be released to the Q
//-----------------------------------------------------
module CFGDSDFFR_FB (
  input RST, // Reset input
  input CK, // Clock Input (can be used with a free running programming clock)
  input SE, // Scan-chain Enable (used to load the data)
//input D, // Data Input
  input SI, // Scan-chain input
  input CFGE, // Configure enable
  input CFG_DONE, // Configure done
  output Q, // Regular Q output
  output CFGQ, // Data Q output which is released when configure enable is activated
  output CFGQN // Data Qb output which is released when configure enable is activated
);
//------------Internal Variables--------
reg q_reg;
wire QN;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else if (SE) begin
  q_reg <= SI;
end else begin
    // Ignore D when SE=0 and RST=0 --> Hold previous value
    q_reg <= q_reg;
//  q_reg <= D;
end

assign CFGQ = CFGE ? Q : 1'b0;
assign CFGQN = CFGE ? QN : 1'b1;

assign Q = CFG_DONE ? q_reg : 1'b0;
assign QN = CFG_DONE ? !Q : 1'b1;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
// @note This DFF is designed to drive BLs when shift registers are used
//-----------------------------------------------------
module BL_DFFRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input SIN, // Data Input
  output SOUT, // Q output
  output BL // BL output
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else begin
  q_reg <= SIN;
end

assign SOUT = q_reg;
assign BL = q_reg;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
// @note This DFF is designed to drive WLs when shift registers are used
//-----------------------------------------------------
module WL_DFFRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input SIN, // Data Input
  input WEN, // Write-enable
  output SOUT, // Q output
  output WLW // Drive WL write signals
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else begin
  q_reg <= SIN;
end

assign SOUT = q_reg;
assign WLW = WEN ? q_reg : 1'b0;

endmodule //End Of Module

//-----------------------------------------------------
// Function    : D-type flip-flop with 
//               - asynchronous active high reset
// @note This DFF is designed to drive WLs and WLRs when shift registers are used
//-----------------------------------------------------
module WLR_DFFRQ (
  input RST, // Reset input
  input CK, // Clock Input
  input SIN, // Data Input
  input WEN, // Write-enable
  output SOUT, // Q output
  output WLW, // Drive WL write signals
  output WLR // Drive WL read signals
);
//------------Internal Variables--------
reg q_reg;

//-------------Code Starts Here---------
always @ ( posedge CK or posedge RST)
if (RST) begin
  q_reg <= 1'b0;
end else begin
  q_reg <= SIN;
end

assign SOUT = q_reg;
assign WLW = WEN ? q_reg : 1'b0;
assign WLR = 1'b0; // Use a constant output just for simple testing

endmodule //End Of Module

// ===== END dff.v =====

// ===== BEGIN SRC\cell_library\gpio.v =====
//-----------------------------------------------------
// Design Name : General Purpose I/Os
// File Name   : gpio.v
// Coder       : Xifan TANG
//-----------------------------------------------------

//-----------------------------------------------------
// Function    : A minimum general purpose I/O
//-----------------------------------------------------
module GPIO (
  input A, // Data output
  output Y, // Data input
  inout PAD, // bi-directional pad
  input DIR // direction control
);
  //----- when direction enabled, the signal is propagated from PAD to data input
  assign Y = PAD;
  //----- when direction is disabled, the signal is propagated from data out to pad
  // PAD drive removed for TD synthesis; board outputs are tapped internally.
endmodule

//-----------------------------------------------------
// Function    : A minimum general purpose I/O with config_done signal
//               which can block signals during configuration phase
//-----------------------------------------------------
module GPIO_CFGD (
  input CONFIG_DONE, // Control signal to block signals
  input A, // Data output
  output Y, // Data input
  inout PAD, // bi-directional pad
  input DIR // direction control
);
  //----- when direction enabled, the signal is propagated from PAD to data input
  assign Y = CONFIG_DONE ? PAD : 1'b0;
  //----- when direction is disabled, the signal is propagated from data out to pad
  // PAD drive removed for TD synthesis; board outputs are tapped internally.
endmodule


//-----------------------------------------------------
// Function    : A minimum input pad
//-----------------------------------------------------
module GPIN (
  inout A, // External PAD signal
  output Y // Data input
);
  assign Y = A;
endmodule

//-----------------------------------------------------
// Function    : A minimum output pad
//-----------------------------------------------------
module GPOUT (
  inout Y, // External PAD signal
  input A // Data output
);
  assign Y = A;
endmodule


//-----------------------------------------------------
// Function    : A minimum input pad with a programmable delay chain inside
// Notes       : This is a RTL model which may not be synthesizable
//               but sufficient to validate EDA features
//               You may implement a synthesizable one in your own needs
//-----------------------------------------------------
module GPIN_PDL (
  input A, // External PAD signal
  output reg Y, // Data input
  input [0:2] MODE_PDL // Control bits for programmable delay chain
);
// A 8-step programmable delay chain. Each step is 0.1ns 
always @(A, MODE_PDL) begin
  case (MODE_PDL)
    3'b000: Y = A; 
    3'b001: Y = #0.1 A; 
    3'b010: Y = #0.2 A; 
    3'b011: Y = #0.3 A; 
    3'b100: Y = #0.4 A; 
    3'b101: Y = #0.5 A; 
    3'b110: Y = #0.6 A; 
    3'b111: Y = #0.7 A; 
    default: Y = A;
  endcase
end
endmodule

//-----------------------------------------------------
// Function    : A minimum output pad with extra mode bits
//-----------------------------------------------------
module GPOUT_EMODE (
  output Y, // External PAD signal
  input A, // Data output
  input [0:3] MODE_I, // Extra mode bits from bitstream
  output [0:3] MODE_O // Extra mode bits to drive external cells
);
  assign Y = A;
  assign MODE_O = MODE_I;
endmodule

//-----------------------------------------------------
// Function    : A minimum embedded I/O
//               just an overlay to interface other components
//-----------------------------------------------------
module EMBEDDED_IO (
  input SOC_IN, // Input to drive the inpad signal
  output SOC_OUT, // Output the outpad signal
  output SOC_DIR, // Output the directionality
  output FPGA_IN, // Input data to FPGA
  input FPGA_OUT, // Output data from FPGA
  input FPGA_DIR // direction control 
);

  assign FPGA_IN = SOC_IN;
  assign SOC_OUT = FPGA_OUT;
  assign SOC_DIR = FPGA_DIR;
endmodule

//-----------------------------------------------------
// Function    : A minimum embedded I/O
//               just an overlay to interface other components
//-----------------------------------------------------
module EMBEDDED_IO_GATED (
  input IN_ENB, // active-low enable for the inputs to be propagated
  input OUT_ENB, // active-low enable for the outputs to be propagated
  input SOC_IN, // Input to drive the inpad signal
  output SOC_OUT, // Output the outpad signal
  output SOC_DIR, // Output the directionality
  output FPGA_IN, // Input data to FPGA
  input FPGA_OUT, // Output data from FPGA
  input FPGA_DIR // direction control 
);

  assign FPGA_IN = IN_ENB ? 1'b0 : SOC_IN;
  assign SOC_OUT = OUT_ENB ? 1'b0 : FPGA_OUT;
  assign SOC_DIR = FPGA_DIR;
endmodule

//-----------------------------------------------------
// Function    : An embedded I/O with an protection circuit
//               which can force the I/O in input mode
//               The enable signal IO_ISOL_N is active-low 
//-----------------------------------------------------
module EMBEDDED_IO_ISOLN (
  input SOC_IN, // Input to drive the inpad signal
  output SOC_OUT, // Output the outpad signal
  output SOC_DIR, // Output the directionality
  output FPGA_IN, // Input data to FPGA
  input FPGA_OUT, // Output data from FPGA
  input FPGA_DIR, // direction control 
  input IO_ISOL_N // Active-low signal to set the I/O in input mode
);

  assign FPGA_IN = IO_ISOL_N ? SOC_IN : 1'b0;
  assign SOC_OUT = IO_ISOL_N ? FPGA_OUT : 1'b0;
  // Direction signal is set to logic '0' when in input mode 
  assign SOC_DIR = IO_ISOL_N ? FPGA_DIR : 1'b0;
endmodule

// ===== END gpio.v =====
// ------ Include primitive module netlists -----

// ===== BEGIN SRC\sub_module\inv_buf_passgate.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Essential gates
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for const0 -----
module const0(const0);
//----- OUTPUT PORTS -----
output [0:0] const0;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

	assign const0[0] = 1'b0;
endmodule
// ----- END Verilog module for const0 -----

//----- Default net type -----
`default_nettype wire

//----- Default net type -----
`default_nettype wire

// ----- Verilog module for const1 -----
module const1(const1);
//----- OUTPUT PORTS -----
output [0:0] const1;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

	assign const1[0] = 1'b1;
endmodule
// ----- END Verilog module for const1 -----

//----- Default net type -----
`default_nettype wire

//----- Default net type -----
`default_nettype wire

// ----- Verilog module for INVTX1 -----
module INVTX1(in,
              out);
//----- INPUT PORTS -----
input [0:0] in;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

// ----- Verilog codes of a regular inverter -----
	assign out = ~in;

`ifdef ENABLE_TIMING
// ------ BEGIN Pin-to-pin Timing constraints -----
	specify
		(in => out) = (0.01, 0.01);
	endspecify
// ------ END Pin-to-pin Timing constraints -----
`endif
endmodule
// ----- END Verilog module for INVTX1 -----

//----- Default net type -----
`default_nettype wire

//----- Default net type -----
`default_nettype wire

// ----- Verilog module for buf4 -----
module buf4(in,
            out);
//----- INPUT PORTS -----
input [0:0] in;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

// ----- Verilog codes of a regular inverter -----
	assign out = in;

`ifdef ENABLE_TIMING
// ------ BEGIN Pin-to-pin Timing constraints -----
	specify
		(in => out) = (0.01, 0.01);
	endspecify
// ------ END Pin-to-pin Timing constraints -----
`endif
endmodule
// ----- END Verilog module for buf4 -----

//----- Default net type -----
`default_nettype wire

//----- Default net type -----
`default_nettype wire

// ----- Verilog module for tap_buf4 -----
module tap_buf4(in,
                out);
//----- INPUT PORTS -----
input [0:0] in;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

// ----- Verilog codes of a regular inverter -----
	assign out = ~in;

`ifdef ENABLE_TIMING
// ------ BEGIN Pin-to-pin Timing constraints -----
	specify
		(in => out) = (0.01, 0.01);
	endspecify
// ------ END Pin-to-pin Timing constraints -----
`endif
endmodule
// ----- END Verilog module for tap_buf4 -----

//----- Default net type -----
`default_nettype wire

//----- Default net type -----
`default_nettype wire

// ----- Verilog module for OR2 -----
module OR2(a,
           b,
           out);
//----- INPUT PORTS -----
input [0:0] a;
//----- INPUT PORTS -----
input [0:0] b;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

// ----- Verilog codes of a 2-input 1-output AND gate -----
	assign out[0] = a[0] | b[0];

`ifdef ENABLE_TIMING
// ------ BEGIN Pin-to-pin Timing constraints -----
	specify
		(a => out) = (0.01, 0.01);
		(b => out) = (0.005, 0.005);
	endspecify
// ------ END Pin-to-pin Timing constraints -----
`endif
endmodule
// ----- END Verilog module for OR2 -----

//----- Default net type -----
`default_nettype wire

//----- Default net type -----
`default_nettype wire

// ----- Verilog module for TGATE -----
module TGATE(A,
             S,
             SI,
             Y);
//----- INPUT PORTS -----
input [0:0] A;
//----- INPUT PORTS -----
input [0:0] S;
//----- INPUT PORTS -----
input [0:0] SI;
//----- OUTPUT PORTS -----
output [0:0] Y;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

	assign Y = S ? A : 1'b0;

`ifdef ENABLE_TIMING
// ------ BEGIN Pin-to-pin Timing constraints -----
	specify
		(A => Y) = (0.01, 0.01);
		(S => Y) = (0.005, 0.005);
		(SI => Y) = (0.005, 0.005);
	endspecify
// ------ END Pin-to-pin Timing constraints -----
`endif
endmodule
// ----- END Verilog module for TGATE -----

//----- Default net type -----
`default_nettype wire


// ===== END inv_buf_passgate.v =====

// ===== BEGIN SRC\sub_module\arch_encoder.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Decoders for fabric configuration protocol
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------

// ===== END arch_encoder.v =====

// ===== BEGIN SRC\sub_module\local_encoder.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Local Decoders for Multiplexers
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------

// ===== END local_encoder.v =====

// ===== BEGIN SRC\sub_module\mux_primitives.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Multiplexer primitives
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_basis_input2_mem1 -----
module mux_2level_tapbuf_basis_input2_mem1(in,
                                           mem,
                                           mem_inv,
                                           out);
//----- INPUT PORTS -----
input [0:1] in;
//----- INPUT PORTS -----
input [0:0] mem;
//----- INPUT PORTS -----
input [0:0] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem & in[0]) | (mem_inv & in[1]);

endmodule
// ----- END Verilog module for mux_2level_tapbuf_basis_input2_mem1 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_basis_input3_mem3 -----
module mux_2level_tapbuf_basis_input3_mem3(in,
                                           mem,
                                           mem_inv,
                                           out);
//----- INPUT PORTS -----
input [0:2] in;
//----- INPUT PORTS -----
input [0:2] mem;
//----- INPUT PORTS -----
input [0:2] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem[0] & in[0]) | (mem[1] & in[1]) | (mem[2] & in[2]);


endmodule
// ----- END Verilog module for mux_2level_tapbuf_basis_input3_mem3 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_basis_input2_mem2 -----
module mux_2level_tapbuf_basis_input2_mem2(in,
                                           mem,
                                           mem_inv,
                                           out);
//----- INPUT PORTS -----
input [0:1] in;
//----- INPUT PORTS -----
input [0:1] mem;
//----- INPUT PORTS -----
input [0:1] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem[0] & in[0]) | (mem[1] & in[1]);

endmodule
// ----- END Verilog module for mux_2level_tapbuf_basis_input2_mem2 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_basis_input4_mem4 -----
module mux_2level_tapbuf_basis_input4_mem4(in,
                                           mem,
                                           mem_inv,
                                           out);
//----- INPUT PORTS -----
input [0:3] in;
//----- INPUT PORTS -----
input [0:3] mem;
//----- INPUT PORTS -----
input [0:3] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem[0] & in[0]) | (mem[1] & in[1]) | (mem[2] & in[2]) | (mem[3] & in[3]);



endmodule
// ----- END Verilog module for mux_2level_tapbuf_basis_input4_mem4 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_basis_input5_mem5 -----
module mux_2level_basis_input5_mem5(in,
                                    mem,
                                    mem_inv,
                                    out);
//----- INPUT PORTS -----
input [0:4] in;
//----- INPUT PORTS -----
input [0:4] mem;
//----- INPUT PORTS -----
input [0:4] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem[0] & in[0]) | (mem[1] & in[1]) | (mem[2] & in[2]) | (mem[3] & in[3]) | (mem[4] & in[4]);




endmodule
// ----- END Verilog module for mux_2level_basis_input5_mem5 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_1level_tapbuf_basis_input3_mem3 -----
module mux_1level_tapbuf_basis_input3_mem3(in,
                                           mem,
                                           mem_inv,
                                           out);
//----- INPUT PORTS -----
input [0:2] in;
//----- INPUT PORTS -----
input [0:2] mem;
//----- INPUT PORTS -----
input [0:2] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem[0] & in[0]) | (mem[1] & in[1]) | (mem[2] & in[2]);


endmodule
// ----- END Verilog module for mux_1level_tapbuf_basis_input3_mem3 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for frac_lut4_mux_basis_input2_mem1 -----
module frac_lut4_mux_basis_input2_mem1(in,
                                       mem,
                                       mem_inv,
                                       out);
//----- INPUT PORTS -----
input [0:1] in;
//----- INPUT PORTS -----
input [0:0] mem;
//----- INPUT PORTS -----
input [0:0] mem_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

// ----- TD-friendly logic mux replacement for pass-gate TGATE network -----
	assign out[0] = (mem & in[0]) | (mem_inv & in[1]);

endmodule
// ----- END Verilog module for frac_lut4_mux_basis_input2_mem1 -----

//----- Default net type -----
`default_nettype wire





// ===== END mux_primitives.v =====

// ===== BEGIN SRC\sub_module\muxes.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Multiplexers
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size2 -----
module mux_2level_tapbuf_size2(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:1] in;
//----- INPUT PORTS -----
input [0:1] sram;
//----- INPUT PORTS -----
input [0:1] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input2_mem1_0_out;
wire [0:0] mux_2level_tapbuf_basis_input2_mem1_1_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input2_mem1_1_out),
		.out(out));

	mux_2level_tapbuf_basis_input2_mem1 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(mux_2level_tapbuf_basis_input2_mem1_0_out));

	mux_2level_tapbuf_basis_input2_mem1 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input2_mem1_0_out, const1_0_const1}),
		.mem(sram[1]),
		.mem_inv(sram_inv[1]),
		.out(mux_2level_tapbuf_basis_input2_mem1_1_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size2 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size6 -----
module mux_2level_tapbuf_size6(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:5] in;
//----- INPUT PORTS -----
input [0:5] sram;
//----- INPUT PORTS -----
input [0:5] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] INVTX1_5_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_1_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_2_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	INVTX1 INVTX1_5_ (
		.in(in[5]),
		.out(INVTX1_5_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input3_mem3_2_out),
		.out(out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_0_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_1_ (
		.in({INVTX1_3_out, INVTX1_4_out, INVTX1_5_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_1_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input3_mem3_0_out, mux_2level_tapbuf_basis_input3_mem3_1_out, const1_0_const1}),
		.mem(sram[3:5]),
		.mem_inv(sram_inv[3:5]),
		.out(mux_2level_tapbuf_basis_input3_mem3_2_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size6 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size5 -----
module mux_2level_tapbuf_size5(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:4] in;
//----- INPUT PORTS -----
input [0:5] sram;
//----- INPUT PORTS -----
input [0:5] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input2_mem2_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_1_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input3_mem3_1_out),
		.out(out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_0_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input3_mem3_0_out, mux_2level_tapbuf_basis_input2_mem2_0_out, const1_0_const1}),
		.mem(sram[3:5]),
		.mem_inv(sram_inv[3:5]),
		.out(mux_2level_tapbuf_basis_input3_mem3_1_out));

	mux_2level_tapbuf_basis_input2_mem2 mux_l1_in_1_ (
		.in({INVTX1_3_out, INVTX1_4_out}),
		.mem(sram[0:1]),
		.mem_inv(sram_inv[0:1]),
		.out(mux_2level_tapbuf_basis_input2_mem2_0_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size5 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size8 -----
module mux_2level_tapbuf_size8(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:7] in;
//----- INPUT PORTS -----
input [0:5] sram;
//----- INPUT PORTS -----
input [0:5] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] INVTX1_5_out;
wire [0:0] INVTX1_6_out;
wire [0:0] INVTX1_7_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_1_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_2_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_3_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	INVTX1 INVTX1_5_ (
		.in(in[5]),
		.out(INVTX1_5_out));

	INVTX1 INVTX1_6_ (
		.in(in[6]),
		.out(INVTX1_6_out));

	INVTX1 INVTX1_7_ (
		.in(in[7]),
		.out(INVTX1_7_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input3_mem3_3_out),
		.out(out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_0_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_1_ (
		.in({INVTX1_3_out, INVTX1_4_out, INVTX1_5_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_1_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_2_ (
		.in({INVTX1_6_out, INVTX1_7_out, const1_0_const1}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_2_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input3_mem3_0_out, mux_2level_tapbuf_basis_input3_mem3_1_out, mux_2level_tapbuf_basis_input3_mem3_2_out}),
		.mem(sram[3:5]),
		.mem_inv(sram_inv[3:5]),
		.out(mux_2level_tapbuf_basis_input3_mem3_3_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size8 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size3 -----
module mux_2level_tapbuf_size3(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:2] in;
//----- INPUT PORTS -----
input [0:1] sram;
//----- INPUT PORTS -----
input [0:1] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input2_mem1_0_out;
wire [0:0] mux_2level_tapbuf_basis_input2_mem1_1_out;
wire [0:0] mux_2level_tapbuf_basis_input2_mem1_2_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input2_mem1_2_out),
		.out(out));

	mux_2level_tapbuf_basis_input2_mem1 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(mux_2level_tapbuf_basis_input2_mem1_0_out));

	mux_2level_tapbuf_basis_input2_mem1 mux_l1_in_1_ (
		.in({INVTX1_2_out, const1_0_const1}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(mux_2level_tapbuf_basis_input2_mem1_1_out));

	mux_2level_tapbuf_basis_input2_mem1 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input2_mem1_0_out, mux_2level_tapbuf_basis_input2_mem1_1_out}),
		.mem(sram[1]),
		.mem_inv(sram_inv[1]),
		.out(mux_2level_tapbuf_basis_input2_mem1_2_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size3 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size4 -----
module mux_2level_tapbuf_size4(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:3] in;
//----- INPUT PORTS -----
input [0:5] sram;
//----- INPUT PORTS -----
input [0:5] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_1_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input3_mem3_1_out),
		.out(out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_0_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input3_mem3_0_out, INVTX1_3_out, const1_0_const1}),
		.mem(sram[3:5]),
		.mem_inv(sram_inv[3:5]),
		.out(mux_2level_tapbuf_basis_input3_mem3_1_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size4 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size7 -----
module mux_2level_tapbuf_size7(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:6] in;
//----- INPUT PORTS -----
input [0:5] sram;
//----- INPUT PORTS -----
input [0:5] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] INVTX1_5_out;
wire [0:0] INVTX1_6_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input2_mem2_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_0_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_1_out;
wire [0:0] mux_2level_tapbuf_basis_input3_mem3_2_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	INVTX1 INVTX1_5_ (
		.in(in[5]),
		.out(INVTX1_5_out));

	INVTX1 INVTX1_6_ (
		.in(in[6]),
		.out(INVTX1_6_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input3_mem3_2_out),
		.out(out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_0_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l1_in_1_ (
		.in({INVTX1_3_out, INVTX1_4_out, INVTX1_5_out}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_2level_tapbuf_basis_input3_mem3_1_out));

	mux_2level_tapbuf_basis_input3_mem3 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input3_mem3_0_out, mux_2level_tapbuf_basis_input3_mem3_1_out, mux_2level_tapbuf_basis_input2_mem2_0_out}),
		.mem(sram[3:5]),
		.mem_inv(sram_inv[3:5]),
		.out(mux_2level_tapbuf_basis_input3_mem3_2_out));

	mux_2level_tapbuf_basis_input2_mem2 mux_l1_in_2_ (
		.in({INVTX1_6_out, const1_0_const1}),
		.mem(sram[0:1]),
		.mem_inv(sram_inv[0:1]),
		.out(mux_2level_tapbuf_basis_input2_mem2_0_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size7 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size9 -----
module mux_2level_tapbuf_size9(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:8] in;
//----- INPUT PORTS -----
input [0:7] sram;
//----- INPUT PORTS -----
input [0:7] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] INVTX1_5_out;
wire [0:0] INVTX1_6_out;
wire [0:0] INVTX1_7_out;
wire [0:0] INVTX1_8_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_tapbuf_basis_input4_mem4_0_out;
wire [0:0] mux_2level_tapbuf_basis_input4_mem4_1_out;
wire [0:0] mux_2level_tapbuf_basis_input4_mem4_2_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	INVTX1 INVTX1_5_ (
		.in(in[5]),
		.out(INVTX1_5_out));

	INVTX1 INVTX1_6_ (
		.in(in[6]),
		.out(INVTX1_6_out));

	INVTX1 INVTX1_7_ (
		.in(in[7]),
		.out(INVTX1_7_out));

	INVTX1 INVTX1_8_ (
		.in(in[8]),
		.out(INVTX1_8_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_2level_tapbuf_basis_input4_mem4_2_out),
		.out(out));

	mux_2level_tapbuf_basis_input4_mem4 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out, INVTX1_3_out}),
		.mem(sram[0:3]),
		.mem_inv(sram_inv[0:3]),
		.out(mux_2level_tapbuf_basis_input4_mem4_0_out));

	mux_2level_tapbuf_basis_input4_mem4 mux_l1_in_1_ (
		.in({INVTX1_4_out, INVTX1_5_out, INVTX1_6_out, INVTX1_7_out}),
		.mem(sram[0:3]),
		.mem_inv(sram_inv[0:3]),
		.out(mux_2level_tapbuf_basis_input4_mem4_1_out));

	mux_2level_tapbuf_basis_input4_mem4 mux_l2_in_0_ (
		.in({mux_2level_tapbuf_basis_input4_mem4_0_out, mux_2level_tapbuf_basis_input4_mem4_1_out, INVTX1_8_out, const1_0_const1}),
		.mem(sram[4:7]),
		.mem_inv(sram_inv[4:7]),
		.out(mux_2level_tapbuf_basis_input4_mem4_2_out));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size9 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_size20 -----
module mux_2level_size20(in,
                         sram,
                         sram_inv,
                         out);
//----- INPUT PORTS -----
input [0:19] in;
//----- INPUT PORTS -----
input [0:9] sram;
//----- INPUT PORTS -----
input [0:9] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_10_out;
wire [0:0] INVTX1_11_out;
wire [0:0] INVTX1_12_out;
wire [0:0] INVTX1_13_out;
wire [0:0] INVTX1_14_out;
wire [0:0] INVTX1_15_out;
wire [0:0] INVTX1_16_out;
wire [0:0] INVTX1_17_out;
wire [0:0] INVTX1_18_out;
wire [0:0] INVTX1_19_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] INVTX1_5_out;
wire [0:0] INVTX1_6_out;
wire [0:0] INVTX1_7_out;
wire [0:0] INVTX1_8_out;
wire [0:0] INVTX1_9_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_2level_basis_input5_mem5_0_out;
wire [0:0] mux_2level_basis_input5_mem5_1_out;
wire [0:0] mux_2level_basis_input5_mem5_2_out;
wire [0:0] mux_2level_basis_input5_mem5_3_out;
wire [0:0] mux_2level_basis_input5_mem5_4_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	INVTX1 INVTX1_5_ (
		.in(in[5]),
		.out(INVTX1_5_out));

	INVTX1 INVTX1_6_ (
		.in(in[6]),
		.out(INVTX1_6_out));

	INVTX1 INVTX1_7_ (
		.in(in[7]),
		.out(INVTX1_7_out));

	INVTX1 INVTX1_8_ (
		.in(in[8]),
		.out(INVTX1_8_out));

	INVTX1 INVTX1_9_ (
		.in(in[9]),
		.out(INVTX1_9_out));

	INVTX1 INVTX1_10_ (
		.in(in[10]),
		.out(INVTX1_10_out));

	INVTX1 INVTX1_11_ (
		.in(in[11]),
		.out(INVTX1_11_out));

	INVTX1 INVTX1_12_ (
		.in(in[12]),
		.out(INVTX1_12_out));

	INVTX1 INVTX1_13_ (
		.in(in[13]),
		.out(INVTX1_13_out));

	INVTX1 INVTX1_14_ (
		.in(in[14]),
		.out(INVTX1_14_out));

	INVTX1 INVTX1_15_ (
		.in(in[15]),
		.out(INVTX1_15_out));

	INVTX1 INVTX1_16_ (
		.in(in[16]),
		.out(INVTX1_16_out));

	INVTX1 INVTX1_17_ (
		.in(in[17]),
		.out(INVTX1_17_out));

	INVTX1 INVTX1_18_ (
		.in(in[18]),
		.out(INVTX1_18_out));

	INVTX1 INVTX1_19_ (
		.in(in[19]),
		.out(INVTX1_19_out));

	INVTX1 INVTX1_20_ (
		.in(mux_2level_basis_input5_mem5_4_out),
		.out(out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	mux_2level_basis_input5_mem5 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out, INVTX1_3_out, INVTX1_4_out}),
		.mem(sram[0:4]),
		.mem_inv(sram_inv[0:4]),
		.out(mux_2level_basis_input5_mem5_0_out));

	mux_2level_basis_input5_mem5 mux_l1_in_1_ (
		.in({INVTX1_5_out, INVTX1_6_out, INVTX1_7_out, INVTX1_8_out, INVTX1_9_out}),
		.mem(sram[0:4]),
		.mem_inv(sram_inv[0:4]),
		.out(mux_2level_basis_input5_mem5_1_out));

	mux_2level_basis_input5_mem5 mux_l1_in_2_ (
		.in({INVTX1_10_out, INVTX1_11_out, INVTX1_12_out, INVTX1_13_out, INVTX1_14_out}),
		.mem(sram[0:4]),
		.mem_inv(sram_inv[0:4]),
		.out(mux_2level_basis_input5_mem5_2_out));

	mux_2level_basis_input5_mem5 mux_l1_in_3_ (
		.in({INVTX1_15_out, INVTX1_16_out, INVTX1_17_out, INVTX1_18_out, INVTX1_19_out}),
		.mem(sram[0:4]),
		.mem_inv(sram_inv[0:4]),
		.out(mux_2level_basis_input5_mem5_3_out));

	mux_2level_basis_input5_mem5 mux_l2_in_0_ (
		.in({mux_2level_basis_input5_mem5_0_out, mux_2level_basis_input5_mem5_1_out, mux_2level_basis_input5_mem5_2_out, mux_2level_basis_input5_mem5_3_out, const1_0_const1}),
		.mem(sram[5:9]),
		.mem_inv(sram_inv[5:9]),
		.out(mux_2level_basis_input5_mem5_4_out));

endmodule
// ----- END Verilog module for mux_2level_size20 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_1level_tapbuf_size2 -----
module mux_1level_tapbuf_size2(in,
                               sram,
                               sram_inv,
                               out);
//----- INPUT PORTS -----
input [0:1] in;
//----- INPUT PORTS -----
input [0:2] sram;
//----- INPUT PORTS -----
input [0:2] sram_inv;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] const1_0_const1;
wire [0:0] mux_1level_tapbuf_basis_input3_mem3_0_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	const1 const1_0_ (
		.const1(const1_0_const1));

	tap_buf4 tap_buf4_0_ (
		.in(mux_1level_tapbuf_basis_input3_mem3_0_out),
		.out(out));

	mux_1level_tapbuf_basis_input3_mem3 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out, const1_0_const1}),
		.mem(sram[0:2]),
		.mem_inv(sram_inv[0:2]),
		.out(mux_1level_tapbuf_basis_input3_mem3_0_out));

endmodule
// ----- END Verilog module for mux_1level_tapbuf_size2 -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for frac_lut4_mux -----
module frac_lut4_mux(in,
                     sram,
                     sram_inv,
                     lut3_out,
                     lut4_out);
//----- INPUT PORTS -----
input [0:15] in;
//----- INPUT PORTS -----
input [0:3] sram;
//----- INPUT PORTS -----
input [0:3] sram_inv;
//----- OUTPUT PORTS -----
output [0:1] lut3_out;
//----- OUTPUT PORTS -----
output [0:0] lut4_out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_10_out;
wire [0:0] INVTX1_11_out;
wire [0:0] INVTX1_12_out;
wire [0:0] INVTX1_13_out;
wire [0:0] INVTX1_14_out;
wire [0:0] INVTX1_15_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] INVTX1_4_out;
wire [0:0] INVTX1_5_out;
wire [0:0] INVTX1_6_out;
wire [0:0] INVTX1_7_out;
wire [0:0] INVTX1_8_out;
wire [0:0] INVTX1_9_out;
wire [0:0] buf4_0_out;
wire [0:0] buf4_1_out;
wire [0:0] buf4_2_out;
wire [0:0] buf4_3_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_0_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_10_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_11_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_12_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_13_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_14_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_1_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_2_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_3_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_4_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_5_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_6_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_7_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_8_out;
wire [0:0] frac_lut4_mux_basis_input2_mem1_9_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(in[3]),
		.out(INVTX1_3_out));

	INVTX1 INVTX1_4_ (
		.in(in[4]),
		.out(INVTX1_4_out));

	INVTX1 INVTX1_5_ (
		.in(in[5]),
		.out(INVTX1_5_out));

	INVTX1 INVTX1_6_ (
		.in(in[6]),
		.out(INVTX1_6_out));

	INVTX1 INVTX1_7_ (
		.in(in[7]),
		.out(INVTX1_7_out));

	INVTX1 INVTX1_8_ (
		.in(in[8]),
		.out(INVTX1_8_out));

	INVTX1 INVTX1_9_ (
		.in(in[9]),
		.out(INVTX1_9_out));

	INVTX1 INVTX1_10_ (
		.in(in[10]),
		.out(INVTX1_10_out));

	INVTX1 INVTX1_11_ (
		.in(in[11]),
		.out(INVTX1_11_out));

	INVTX1 INVTX1_12_ (
		.in(in[12]),
		.out(INVTX1_12_out));

	INVTX1 INVTX1_13_ (
		.in(in[13]),
		.out(INVTX1_13_out));

	INVTX1 INVTX1_14_ (
		.in(in[14]),
		.out(INVTX1_14_out));

	INVTX1 INVTX1_15_ (
		.in(in[15]),
		.out(INVTX1_15_out));

	INVTX1 INVTX1_16_ (
		.in(frac_lut4_mux_basis_input2_mem1_12_out),
		.out(lut3_out[0]));

	INVTX1 INVTX1_17_ (
		.in(frac_lut4_mux_basis_input2_mem1_13_out),
		.out(lut3_out[1]));

	INVTX1 INVTX1_18_ (
		.in(frac_lut4_mux_basis_input2_mem1_14_out),
		.out(lut4_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_0_ (
		.in({INVTX1_0_out, INVTX1_1_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_0_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_1_ (
		.in({INVTX1_2_out, INVTX1_3_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_1_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_2_ (
		.in({INVTX1_4_out, INVTX1_5_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_2_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_3_ (
		.in({INVTX1_6_out, INVTX1_7_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_3_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_4_ (
		.in({INVTX1_8_out, INVTX1_9_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_4_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_5_ (
		.in({INVTX1_10_out, INVTX1_11_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_5_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_6_ (
		.in({INVTX1_12_out, INVTX1_13_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_6_out));

	frac_lut4_mux_basis_input2_mem1 mux_l1_in_7_ (
		.in({INVTX1_14_out, INVTX1_15_out}),
		.mem(sram[0]),
		.mem_inv(sram_inv[0]),
		.out(frac_lut4_mux_basis_input2_mem1_7_out));

	frac_lut4_mux_basis_input2_mem1 mux_l2_in_0_ (
		.in({frac_lut4_mux_basis_input2_mem1_0_out, frac_lut4_mux_basis_input2_mem1_1_out}),
		.mem(sram[1]),
		.mem_inv(sram_inv[1]),
		.out(frac_lut4_mux_basis_input2_mem1_8_out));

	frac_lut4_mux_basis_input2_mem1 mux_l2_in_1_ (
		.in({frac_lut4_mux_basis_input2_mem1_2_out, frac_lut4_mux_basis_input2_mem1_3_out}),
		.mem(sram[1]),
		.mem_inv(sram_inv[1]),
		.out(frac_lut4_mux_basis_input2_mem1_9_out));

	frac_lut4_mux_basis_input2_mem1 mux_l2_in_2_ (
		.in({frac_lut4_mux_basis_input2_mem1_4_out, frac_lut4_mux_basis_input2_mem1_5_out}),
		.mem(sram[1]),
		.mem_inv(sram_inv[1]),
		.out(frac_lut4_mux_basis_input2_mem1_10_out));

	frac_lut4_mux_basis_input2_mem1 mux_l2_in_3_ (
		.in({frac_lut4_mux_basis_input2_mem1_6_out, frac_lut4_mux_basis_input2_mem1_7_out}),
		.mem(sram[1]),
		.mem_inv(sram_inv[1]),
		.out(frac_lut4_mux_basis_input2_mem1_11_out));

	frac_lut4_mux_basis_input2_mem1 mux_l3_in_0_ (
		.in({buf4_0_out, buf4_1_out}),
		.mem(sram[2]),
		.mem_inv(sram_inv[2]),
		.out(frac_lut4_mux_basis_input2_mem1_12_out));

	frac_lut4_mux_basis_input2_mem1 mux_l3_in_1_ (
		.in({buf4_2_out, buf4_3_out}),
		.mem(sram[2]),
		.mem_inv(sram_inv[2]),
		.out(frac_lut4_mux_basis_input2_mem1_13_out));

	frac_lut4_mux_basis_input2_mem1 mux_l4_in_0_ (
		.in({frac_lut4_mux_basis_input2_mem1_12_out, frac_lut4_mux_basis_input2_mem1_13_out}),
		.mem(sram[3]),
		.mem_inv(sram_inv[3]),
		.out(frac_lut4_mux_basis_input2_mem1_14_out));

	buf4 buf4_0_ (
		.in(frac_lut4_mux_basis_input2_mem1_8_out),
		.out(buf4_0_out));

	buf4 buf4_1_ (
		.in(frac_lut4_mux_basis_input2_mem1_9_out),
		.out(buf4_1_out));

	buf4 buf4_2_ (
		.in(frac_lut4_mux_basis_input2_mem1_10_out),
		.out(buf4_2_out));

	buf4 buf4_3_ (
		.in(frac_lut4_mux_basis_input2_mem1_11_out),
		.out(buf4_3_out));

endmodule
// ----- END Verilog module for frac_lut4_mux -----

//----- Default net type -----
`default_nettype wire





// ===== END muxes.v =====

// ===== BEGIN SRC\sub_module\luts.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Look-Up Tables
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for frac_lut4 -----
module frac_lut4(in,
                 sram,
                 sram_inv,
                 mode,
                 mode_inv,
                 lut3_out,
                 lut4_out);
//----- INPUT PORTS -----
input [0:3] in;
//----- INPUT PORTS -----
input [0:15] sram;
//----- INPUT PORTS -----
input [0:15] sram_inv;
//----- INPUT PORTS -----
input [0:0] mode;
//----- INPUT PORTS -----
input [0:0] mode_inv;
//----- OUTPUT PORTS -----
output [0:1] lut3_out;
//----- OUTPUT PORTS -----
output [0:0] lut4_out;

//----- BEGIN wire-connection ports -----
wire [0:3] in;
wire [0:1] lut3_out;
wire [0:0] lut4_out;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] INVTX1_0_out;
wire [0:0] INVTX1_1_out;
wire [0:0] INVTX1_2_out;
wire [0:0] INVTX1_3_out;
wire [0:0] OR2_0_out;
wire [0:0] buf4_0_out;
wire [0:0] buf4_1_out;
wire [0:0] buf4_2_out;
wire [0:0] buf4_3_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	OR2 OR2_0_ (
		.a(mode),
		.b(in[3]),
		.out(OR2_0_out));

	INVTX1 INVTX1_0_ (
		.in(in[0]),
		.out(INVTX1_0_out));

	INVTX1 INVTX1_1_ (
		.in(in[1]),
		.out(INVTX1_1_out));

	INVTX1 INVTX1_2_ (
		.in(in[2]),
		.out(INVTX1_2_out));

	INVTX1 INVTX1_3_ (
		.in(OR2_0_out),
		.out(INVTX1_3_out));

	buf4 buf4_0_ (
		.in(in[0]),
		.out(buf4_0_out));

	buf4 buf4_1_ (
		.in(in[1]),
		.out(buf4_1_out));

	buf4 buf4_2_ (
		.in(in[2]),
		.out(buf4_2_out));

	buf4 buf4_3_ (
		.in(OR2_0_out),
		.out(buf4_3_out));

	frac_lut4_mux frac_lut4_mux_0_ (
		.in(sram[0:15]),
		.sram({buf4_0_out, buf4_1_out, buf4_2_out, buf4_3_out}),
		.sram_inv({INVTX1_0_out, INVTX1_1_out, INVTX1_2_out, INVTX1_3_out}),
		.lut3_out(lut3_out[0:1]),
		.lut4_out(lut4_out));

endmodule
// ----- END Verilog module for frac_lut4 -----

//----- Default net type -----
`default_nettype wire




// ===== END luts.v =====

// ===== BEGIN SRC\sub_module\wires.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Wires
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Verilog modules for regular wires -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for direct_interc -----
module direct_interc(in,
                     out);
//----- INPUT PORTS -----
input [0:0] in;
//----- OUTPUT PORTS -----
output [0:0] out;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----

wire [0:0] in;
wire [0:0] out;
	assign out[0] = in[0];
endmodule
// ----- END Verilog module for direct_interc -----

//----- Default net type -----
`default_nettype wire


// ----- END Verilog modules for regular wires -----

// ===== END wires.v =====

// ===== BEGIN SRC\sub_module\memories.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Memories used in FPGA
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size2_mem -----
module mux_2level_tapbuf_size2_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:1] mem_out;
//----- OUTPUT PORTS -----
output [0:1] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[1];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size2_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size6_mem -----
module mux_2level_tapbuf_size6_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:5] mem_out;
//----- OUTPUT PORTS -----
output [0:5] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[5];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size6_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size5_mem -----
module mux_2level_tapbuf_size5_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:5] mem_out;
//----- OUTPUT PORTS -----
output [0:5] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[5];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size5_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size8_mem -----
module mux_2level_tapbuf_size8_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:5] mem_out;
//----- OUTPUT PORTS -----
output [0:5] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[5];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size8_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size3_mem -----
module mux_2level_tapbuf_size3_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:1] mem_out;
//----- OUTPUT PORTS -----
output [0:1] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[1];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size3_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size4_mem -----
module mux_2level_tapbuf_size4_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:5] mem_out;
//----- OUTPUT PORTS -----
output [0:5] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[5];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size4_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size7_mem -----
module mux_2level_tapbuf_size7_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:5] mem_out;
//----- OUTPUT PORTS -----
output [0:5] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[5];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size7_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_tapbuf_size9_mem -----
module mux_2level_tapbuf_size9_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:7] mem_out;
//----- OUTPUT PORTS -----
output [0:7] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[7];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

	DFFR DFFR_6_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[5]),
		.Q(mem_out[6]),
		.QN(mem_outb[6]));

	DFFR DFFR_7_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[6]),
		.Q(mem_out[7]),
		.QN(mem_outb[7]));

endmodule
// ----- END Verilog module for mux_2level_tapbuf_size9_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_2level_size20_mem -----
module mux_2level_size20_mem(pReset,
                             prog_clk,
                             ccff_head,
                             ccff_tail,
                             mem_out,
                             mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:9] mem_out;
//----- OUTPUT PORTS -----
output [0:9] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[9];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

	DFFR DFFR_6_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[5]),
		.Q(mem_out[6]),
		.QN(mem_outb[6]));

	DFFR DFFR_7_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[6]),
		.Q(mem_out[7]),
		.QN(mem_outb[7]));

	DFFR DFFR_8_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[7]),
		.Q(mem_out[8]),
		.QN(mem_outb[8]));

	DFFR DFFR_9_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[8]),
		.Q(mem_out[9]),
		.QN(mem_outb[9]));

endmodule
// ----- END Verilog module for mux_2level_size20_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for mux_1level_tapbuf_size2_mem -----
module mux_1level_tapbuf_size2_mem(pReset,
                                   prog_clk,
                                   ccff_head,
                                   ccff_tail,
                                   mem_out,
                                   mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:2] mem_out;
//----- OUTPUT PORTS -----
output [0:2] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[2];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

endmodule
// ----- END Verilog module for mux_1level_tapbuf_size2_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for MULTI_MODE_DFFRQ_DFFR_mem -----
module MULTI_MODE_DFFRQ_DFFR_mem(pReset,
                                 prog_clk,
                                 ccff_head,
                                 ccff_tail,
                                 mem_out,
                                 mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:0] mem_out;
//----- OUTPUT PORTS -----
output [0:0] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[0];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out),
		.QN(mem_outb));

endmodule
// ----- END Verilog module for MULTI_MODE_DFFRQ_DFFR_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for frac_lut4_DFFR_mem -----
module frac_lut4_DFFR_mem(pReset,
                          prog_clk,
                          ccff_head,
                          ccff_tail,
                          mem_out,
                          mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:16] mem_out;
//----- OUTPUT PORTS -----
output [0:16] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[16];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out[0]),
		.QN(mem_outb[0]));

	DFFR DFFR_1_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[0]),
		.Q(mem_out[1]),
		.QN(mem_outb[1]));

	DFFR DFFR_2_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[1]),
		.Q(mem_out[2]),
		.QN(mem_outb[2]));

	DFFR DFFR_3_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[2]),
		.Q(mem_out[3]),
		.QN(mem_outb[3]));

	DFFR DFFR_4_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[3]),
		.Q(mem_out[4]),
		.QN(mem_outb[4]));

	DFFR DFFR_5_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[4]),
		.Q(mem_out[5]),
		.QN(mem_outb[5]));

	DFFR DFFR_6_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[5]),
		.Q(mem_out[6]),
		.QN(mem_outb[6]));

	DFFR DFFR_7_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[6]),
		.Q(mem_out[7]),
		.QN(mem_outb[7]));

	DFFR DFFR_8_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[7]),
		.Q(mem_out[8]),
		.QN(mem_outb[8]));

	DFFR DFFR_9_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[8]),
		.Q(mem_out[9]),
		.QN(mem_outb[9]));

	DFFR DFFR_10_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[9]),
		.Q(mem_out[10]),
		.QN(mem_outb[10]));

	DFFR DFFR_11_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[10]),
		.Q(mem_out[11]),
		.QN(mem_outb[11]));

	DFFR DFFR_12_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[11]),
		.Q(mem_out[12]),
		.QN(mem_outb[12]));

	DFFR DFFR_13_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[12]),
		.Q(mem_out[13]),
		.QN(mem_outb[13]));

	DFFR DFFR_14_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[13]),
		.Q(mem_out[14]),
		.QN(mem_outb[14]));

	DFFR DFFR_15_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[14]),
		.Q(mem_out[15]),
		.QN(mem_outb[15]));

	DFFR DFFR_16_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(mem_out[15]),
		.Q(mem_out[16]),
		.QN(mem_outb[16]));

endmodule
// ----- END Verilog module for frac_lut4_DFFR_mem -----

//----- Default net type -----
`default_nettype wire




//----- Default net type -----
`default_nettype wire

// ----- Verilog module for GPIO_DFFR_mem -----
module GPIO_DFFR_mem(pReset,
                     prog_clk,
                     ccff_head,
                     ccff_tail,
                     mem_out,
                     mem_outb);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- OUTPUT PORTS -----
output [0:0] mem_out;
//----- OUTPUT PORTS -----
output [0:0] mem_outb;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign ccff_tail[0] = mem_out[0];
// ----- END Local output short connections -----

	DFFR DFFR_0_ (
		.RST(pReset),
		.CK(prog_clk),
		.D(ccff_head),
		.Q(mem_out),
		.QN(mem_outb));

endmodule
// ----- END Verilog module for GPIO_DFFR_mem -----

//----- Default net type -----
`default_nettype wire





// ===== END memories.v =====

// ===== BEGIN SRC\sub_module\shift_register_banks.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Shift register banks used in FPGA
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------

// ===== END shift_register_banks.v =====

// ------ Include logic block netlists -----

// ===== BEGIN SRC\lb\logical_tile_io_mode_physical__iopad.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for primitive pb_type: iopad
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_io_mode_physical__iopad -----
module logical_tile_io_mode_physical__iopad(pReset,
                                            prog_clk,
                                            gfpga_pad_GPIO_PAD,
                                            iopad_outpad,
                                            ccff_head,
                                            iopad_inpad,
                                            ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:0] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] iopad_outpad;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] iopad_inpad;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:0] iopad_outpad;
wire [0:0] iopad_inpad;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] GPIO_0_DIR;
wire [0:0] GPIO_DFFR_mem_undriven_mem_outb;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	GPIO GPIO_0_ (
		.PAD(gfpga_pad_GPIO_PAD),
		.A(iopad_outpad),
		.DIR(GPIO_0_DIR),
		.Y(iopad_inpad));

	GPIO_DFFR_mem GPIO_DFFR_mem (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(ccff_tail),
		.mem_out(GPIO_0_DIR),
		.mem_outb(GPIO_DFFR_mem_undriven_mem_outb));

endmodule
// ----- END Verilog module for logical_tile_io_mode_physical__iopad -----

//----- Default net type -----
`default_nettype wire




// ===== END logical_tile_io_mode_physical__iopad.v =====

// ===== BEGIN SRC\lb\logical_tile_io_mode_io_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for pb_type: io
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Physical programmable logic block Verilog module: io -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_io_mode_io_ -----
module logical_tile_io_mode_io_(pReset,
                                prog_clk,
                                gfpga_pad_GPIO_PAD,
                                io_outpad,
                                ccff_head,
                                io_inpad,
                                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:0] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] io_outpad;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] io_inpad;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:0] io_outpad;
wire [0:0] io_inpad;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] direct_interc_1_out;
wire [0:0] logical_tile_io_mode_physical__iopad_0_iopad_inpad;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_physical__iopad logical_tile_io_mode_physical__iopad_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD),
		.iopad_outpad(direct_interc_1_out),
		.ccff_head(ccff_head),
		.iopad_inpad(logical_tile_io_mode_physical__iopad_0_iopad_inpad),
		.ccff_tail(ccff_tail));

	direct_interc direct_interc_0_ (
		.in(logical_tile_io_mode_physical__iopad_0_iopad_inpad),
		.out(io_inpad));

	direct_interc direct_interc_1_ (
		.in(io_outpad),
		.out(direct_interc_1_out));

endmodule
// ----- END Verilog module for logical_tile_io_mode_io_ -----

//----- Default net type -----
`default_nettype wire



// ----- END Physical programmable logic block Verilog module: io -----

// ===== END logical_tile_io_mode_io_.v =====

// ===== BEGIN SRC\lb\logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for primitive pb_type: frac_lut4
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4 -----
module logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4(pReset,
                                                                                                                 prog_clk,
                                                                                                                 frac_lut4_in,
                                                                                                                 ccff_head,
                                                                                                                 frac_lut4_lut3_out,
                                                                                                                 frac_lut4_lut4_out,
                                                                                                                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:3] frac_lut4_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:1] frac_lut4_lut3_out;
//----- OUTPUT PORTS -----
output [0:0] frac_lut4_lut4_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:3] frac_lut4_in;
wire [0:1] frac_lut4_lut3_out;
wire [0:0] frac_lut4_lut4_out;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] frac_lut4_0_mode;
wire [0:0] frac_lut4_0_mode_inv;
wire [0:15] frac_lut4_0_sram;
wire [0:15] frac_lut4_0_sram_inv;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	frac_lut4 frac_lut4_0_ (
		.in(frac_lut4_in[0:3]),
		.sram(frac_lut4_0_sram[0:15]),
		.sram_inv(frac_lut4_0_sram_inv[0:15]),
		.mode(frac_lut4_0_mode),
		.mode_inv(frac_lut4_0_mode_inv),
		.lut3_out(frac_lut4_lut3_out[0:1]),
		.lut4_out(frac_lut4_lut4_out));

	frac_lut4_DFFR_mem frac_lut4_DFFR_mem (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(ccff_tail),
		.mem_out({frac_lut4_0_sram[0:15], frac_lut4_0_mode}),
		.mem_outb({frac_lut4_0_sram_inv[0:15], frac_lut4_0_mode_inv}));

endmodule
// ----- END Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4 -----

//----- Default net type -----
`default_nettype wire




// ===== END logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4.v =====

// ===== BEGIN SRC\lb\logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for pb_type: frac_logic
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Physical programmable logic block Verilog module: frac_logic -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic -----
module logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic(pReset,
                                                                                         prog_clk,
                                                                                         frac_logic_in,
                                                                                         ccff_head,
                                                                                         frac_logic_out,
                                                                                         ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:3] frac_logic_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:1] frac_logic_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:3] frac_logic_in;
wire [0:1] frac_logic_out;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] direct_interc_1_out;
wire [0:0] direct_interc_2_out;
wire [0:0] direct_interc_3_out;
wire [0:0] direct_interc_4_out;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_ccff_tail;
wire [0:1] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut3_out;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut4_out;
wire [0:2] mux_1level_tapbuf_size2_0_sram;
wire [0:2] mux_1level_tapbuf_size2_0_sram_inv;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4 logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.frac_lut4_in({direct_interc_1_out, direct_interc_2_out, direct_interc_3_out, direct_interc_4_out}),
		.ccff_head(ccff_head),
		.frac_lut4_lut3_out(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut3_out[0:1]),
		.frac_lut4_lut4_out(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut4_out),
		.ccff_tail(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_ccff_tail));

	mux_1level_tapbuf_size2 mux_frac_logic_out_0 (
		.in({logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut4_out, logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut3_out[0]}),
		.sram(mux_1level_tapbuf_size2_0_sram[0:2]),
		.sram_inv(mux_1level_tapbuf_size2_0_sram_inv[0:2]),
		.out(frac_logic_out[0]));

	mux_1level_tapbuf_size2_mem mem_frac_logic_out_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_1level_tapbuf_size2_0_sram[0:2]),
		.mem_outb(mux_1level_tapbuf_size2_0_sram_inv[0:2]));

	direct_interc direct_interc_0_ (
		.in(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_mode_default__frac_lut4_0_frac_lut4_lut3_out[1]),
		.out(frac_logic_out[1]));

	direct_interc direct_interc_1_ (
		.in(frac_logic_in[0]),
		.out(direct_interc_1_out));

	direct_interc direct_interc_2_ (
		.in(frac_logic_in[1]),
		.out(direct_interc_2_out));

	direct_interc direct_interc_3_ (
		.in(frac_logic_in[2]),
		.out(direct_interc_3_out));

	direct_interc direct_interc_4_ (
		.in(frac_logic_in[3]),
		.out(direct_interc_4_out));

endmodule
// ----- END Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic -----

//----- Default net type -----
`default_nettype wire



// ----- END Physical programmable logic block Verilog module: frac_logic -----

// ===== END logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic.v =====

// ===== BEGIN SRC\lb\logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for primitive pb_type: ff
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff -----
module logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff(pReset,
                                                                                 prog_clk,
                                                                                 ff_D,
                                                                                 ff_R,
                                                                                 ccff_head,
                                                                                 ff_Q,
                                                                                 ccff_tail,
                                                                                 ff_C);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] ff_D;
//----- INPUT PORTS -----
input [0:0] ff_R;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ff_Q;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- CLOCK PORTS -----
input [0:0] ff_C;

//----- BEGIN wire-connection ports -----
wire [0:0] ff_D;
wire [0:0] ff_R;
wire [0:0] ff_Q;
wire [0:0] ff_C;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] MULTI_MODE_DFFRQ_0_mode;
wire [0:0] MULTI_MODE_DFFRQ_DFFR_mem_undriven_mem_outb;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	MULTI_MODE_DFFRQ MULTI_MODE_DFFRQ_0_ (
		.D(ff_D),
		.RST(ff_R),
		.CK(ff_C),
		.mode(MULTI_MODE_DFFRQ_0_mode),
		.Q(ff_Q));

	MULTI_MODE_DFFRQ_DFFR_mem MULTI_MODE_DFFRQ_DFFR_mem (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(ccff_tail),
		.mem_out(MULTI_MODE_DFFRQ_0_mode),
		.mem_outb(MULTI_MODE_DFFRQ_DFFR_mem_undriven_mem_outb));

endmodule
// ----- END Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff -----

//----- Default net type -----
`default_nettype wire




// ===== END logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff.v =====

// ===== BEGIN SRC\lb\logical_tile_clb_mode_default__fle_mode_physical__fabric.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for pb_type: fabric
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Physical programmable logic block Verilog module: fabric -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric -----
module logical_tile_clb_mode_default__fle_mode_physical__fabric(pReset,
                                                                prog_clk,
                                                                fabric_in,
                                                                fabric_reset,
                                                                fabric_clk,
                                                                ccff_head,
                                                                fabric_out,
                                                                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:3] fabric_in;
//----- INPUT PORTS -----
input [0:0] fabric_reset;
//----- INPUT PORTS -----
input [0:0] fabric_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:1] fabric_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:3] fabric_in;
wire [0:0] fabric_reset;
wire [0:0] fabric_clk;
wire [0:1] fabric_out;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] direct_interc_0_out;
wire [0:0] direct_interc_1_out;
wire [0:0] direct_interc_2_out;
wire [0:0] direct_interc_3_out;
wire [0:0] direct_interc_4_out;
wire [0:0] direct_interc_5_out;
wire [0:0] direct_interc_6_out;
wire [0:0] direct_interc_7_out;
wire [0:0] direct_interc_8_out;
wire [0:0] direct_interc_9_out;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0_ccff_tail;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0_ff_Q;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1_ccff_tail;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1_ff_Q;
wire [0:0] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_ccff_tail;
wire [0:1] logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_frac_logic_out;
wire [0:2] mux_1level_tapbuf_size2_0_sram;
wire [0:2] mux_1level_tapbuf_size2_0_sram_inv;
wire [0:2] mux_1level_tapbuf_size2_1_sram;
wire [0:2] mux_1level_tapbuf_size2_1_sram_inv;
wire [0:0] mux_1level_tapbuf_size2_mem_0_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.frac_logic_in({direct_interc_0_out, direct_interc_1_out, direct_interc_2_out, direct_interc_3_out}),
		.ccff_head(ccff_head),
		.frac_logic_out(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_frac_logic_out[0:1]),
		.ccff_tail(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_ccff_tail));

	logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ff_D(direct_interc_4_out),
		.ff_R(direct_interc_5_out),
		.ccff_head(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_ccff_tail),
		.ff_Q(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0_ff_Q),
		.ccff_tail(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0_ccff_tail),
		.ff_C(direct_interc_6_out));

	logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ff_D(direct_interc_7_out),
		.ff_R(direct_interc_8_out),
		.ccff_head(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0_ccff_tail),
		.ff_Q(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1_ff_Q),
		.ccff_tail(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1_ccff_tail),
		.ff_C(direct_interc_9_out));

	mux_1level_tapbuf_size2 mux_fabric_out_0 (
		.in({logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_0_ff_Q, logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_frac_logic_out[0]}),
		.sram(mux_1level_tapbuf_size2_0_sram[0:2]),
		.sram_inv(mux_1level_tapbuf_size2_0_sram_inv[0:2]),
		.out(fabric_out[0]));

	mux_1level_tapbuf_size2 mux_fabric_out_1 (
		.in({logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1_ff_Q, logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_frac_logic_out[1]}),
		.sram(mux_1level_tapbuf_size2_1_sram[0:2]),
		.sram_inv(mux_1level_tapbuf_size2_1_sram_inv[0:2]),
		.out(fabric_out[1]));

	mux_1level_tapbuf_size2_mem mem_fabric_out_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__ff_1_ccff_tail),
		.ccff_tail(mux_1level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_1level_tapbuf_size2_0_sram[0:2]),
		.mem_outb(mux_1level_tapbuf_size2_0_sram_inv[0:2]));

	mux_1level_tapbuf_size2_mem mem_fabric_out_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_1level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_1level_tapbuf_size2_1_sram[0:2]),
		.mem_outb(mux_1level_tapbuf_size2_1_sram_inv[0:2]));

	direct_interc direct_interc_0_ (
		.in(fabric_in[0]),
		.out(direct_interc_0_out));

	direct_interc direct_interc_1_ (
		.in(fabric_in[1]),
		.out(direct_interc_1_out));

	direct_interc direct_interc_2_ (
		.in(fabric_in[2]),
		.out(direct_interc_2_out));

	direct_interc direct_interc_3_ (
		.in(fabric_in[3]),
		.out(direct_interc_3_out));

	direct_interc direct_interc_4_ (
		.in(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_frac_logic_out[0]),
		.out(direct_interc_4_out));

	direct_interc direct_interc_5_ (
		.in(fabric_reset),
		.out(direct_interc_5_out));

	direct_interc direct_interc_6_ (
		.in(fabric_clk),
		.out(direct_interc_6_out));

	direct_interc direct_interc_7_ (
		.in(logical_tile_clb_mode_default__fle_mode_physical__fabric_mode_default__frac_logic_0_frac_logic_out[1]),
		.out(direct_interc_7_out));

	direct_interc direct_interc_8_ (
		.in(fabric_reset),
		.out(direct_interc_8_out));

	direct_interc direct_interc_9_ (
		.in(fabric_clk),
		.out(direct_interc_9_out));

endmodule
// ----- END Verilog module for logical_tile_clb_mode_default__fle_mode_physical__fabric -----

//----- Default net type -----
`default_nettype wire



// ----- END Physical programmable logic block Verilog module: fabric -----

// ===== END logical_tile_clb_mode_default__fle_mode_physical__fabric.v =====

// ===== BEGIN SRC\lb\logical_tile_clb_mode_default__fle.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for pb_type: fle
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Physical programmable logic block Verilog module: fle -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_clb_mode_default__fle -----
module logical_tile_clb_mode_default__fle(pReset,
                                          prog_clk,
                                          fle_in,
                                          fle_reset,
                                          fle_clk,
                                          ccff_head,
                                          fle_out,
                                          ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:3] fle_in;
//----- INPUT PORTS -----
input [0:0] fle_reset;
//----- INPUT PORTS -----
input [0:0] fle_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:1] fle_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:3] fle_in;
wire [0:0] fle_reset;
wire [0:0] fle_clk;
wire [0:1] fle_out;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] direct_interc_2_out;
wire [0:0] direct_interc_3_out;
wire [0:0] direct_interc_4_out;
wire [0:0] direct_interc_5_out;
wire [0:0] direct_interc_6_out;
wire [0:0] direct_interc_7_out;
wire [0:1] logical_tile_clb_mode_default__fle_mode_physical__fabric_0_fabric_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_clb_mode_default__fle_mode_physical__fabric logical_tile_clb_mode_default__fle_mode_physical__fabric_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.fabric_in({direct_interc_2_out, direct_interc_3_out, direct_interc_4_out, direct_interc_5_out}),
		.fabric_reset(direct_interc_6_out),
		.fabric_clk(direct_interc_7_out),
		.ccff_head(ccff_head),
		.fabric_out(logical_tile_clb_mode_default__fle_mode_physical__fabric_0_fabric_out[0:1]),
		.ccff_tail(ccff_tail));

	direct_interc direct_interc_0_ (
		.in(logical_tile_clb_mode_default__fle_mode_physical__fabric_0_fabric_out[0]),
		.out(fle_out[0]));

	direct_interc direct_interc_1_ (
		.in(logical_tile_clb_mode_default__fle_mode_physical__fabric_0_fabric_out[1]),
		.out(fle_out[1]));

	direct_interc direct_interc_2_ (
		.in(fle_in[0]),
		.out(direct_interc_2_out));

	direct_interc direct_interc_3_ (
		.in(fle_in[1]),
		.out(direct_interc_3_out));

	direct_interc direct_interc_4_ (
		.in(fle_in[2]),
		.out(direct_interc_4_out));

	direct_interc direct_interc_5_ (
		.in(fle_in[3]),
		.out(direct_interc_5_out));

	direct_interc direct_interc_6_ (
		.in(fle_reset),
		.out(direct_interc_6_out));

	direct_interc direct_interc_7_ (
		.in(fle_clk),
		.out(direct_interc_7_out));

endmodule
// ----- END Verilog module for logical_tile_clb_mode_default__fle -----

//----- Default net type -----
`default_nettype wire



// ----- END Physical programmable logic block Verilog module: fle -----

// ===== END logical_tile_clb_mode_default__fle.v =====

// ===== BEGIN SRC\lb\logical_tile_clb_mode_clb_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for pb_type: clb
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Physical programmable logic block Verilog module: clb -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for logical_tile_clb_mode_clb_ -----
module logical_tile_clb_mode_clb_(pReset,
                                  prog_clk,
                                  clb_I,
                                  clb_reset,
                                  clb_clk,
                                  ccff_head,
                                  clb_O,
                                  ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:11] clb_I;
//----- INPUT PORTS -----
input [0:0] clb_reset;
//----- INPUT PORTS -----
input [0:0] clb_clk;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:7] clb_O;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
wire [0:11] clb_I;
wire [0:0] clb_reset;
wire [0:0] clb_clk;
wire [0:7] clb_O;
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] direct_interc_10_out;
wire [0:0] direct_interc_11_out;
wire [0:0] direct_interc_12_out;
wire [0:0] direct_interc_13_out;
wire [0:0] direct_interc_14_out;
wire [0:0] direct_interc_15_out;
wire [0:0] direct_interc_8_out;
wire [0:0] direct_interc_9_out;
wire [0:0] logical_tile_clb_mode_default__fle_0_ccff_tail;
wire [0:1] logical_tile_clb_mode_default__fle_0_fle_out;
wire [0:0] logical_tile_clb_mode_default__fle_1_ccff_tail;
wire [0:1] logical_tile_clb_mode_default__fle_1_fle_out;
wire [0:0] logical_tile_clb_mode_default__fle_2_ccff_tail;
wire [0:1] logical_tile_clb_mode_default__fle_2_fle_out;
wire [0:0] logical_tile_clb_mode_default__fle_3_ccff_tail;
wire [0:1] logical_tile_clb_mode_default__fle_3_fle_out;
wire [0:0] mux_2level_size20_0_out;
wire [0:9] mux_2level_size20_0_sram;
wire [0:9] mux_2level_size20_0_sram_inv;
wire [0:0] mux_2level_size20_10_out;
wire [0:9] mux_2level_size20_10_sram;
wire [0:9] mux_2level_size20_10_sram_inv;
wire [0:0] mux_2level_size20_11_out;
wire [0:9] mux_2level_size20_11_sram;
wire [0:9] mux_2level_size20_11_sram_inv;
wire [0:0] mux_2level_size20_12_out;
wire [0:9] mux_2level_size20_12_sram;
wire [0:9] mux_2level_size20_12_sram_inv;
wire [0:0] mux_2level_size20_13_out;
wire [0:9] mux_2level_size20_13_sram;
wire [0:9] mux_2level_size20_13_sram_inv;
wire [0:0] mux_2level_size20_14_out;
wire [0:9] mux_2level_size20_14_sram;
wire [0:9] mux_2level_size20_14_sram_inv;
wire [0:0] mux_2level_size20_15_out;
wire [0:9] mux_2level_size20_15_sram;
wire [0:9] mux_2level_size20_15_sram_inv;
wire [0:0] mux_2level_size20_1_out;
wire [0:9] mux_2level_size20_1_sram;
wire [0:9] mux_2level_size20_1_sram_inv;
wire [0:0] mux_2level_size20_2_out;
wire [0:9] mux_2level_size20_2_sram;
wire [0:9] mux_2level_size20_2_sram_inv;
wire [0:0] mux_2level_size20_3_out;
wire [0:9] mux_2level_size20_3_sram;
wire [0:9] mux_2level_size20_3_sram_inv;
wire [0:0] mux_2level_size20_4_out;
wire [0:9] mux_2level_size20_4_sram;
wire [0:9] mux_2level_size20_4_sram_inv;
wire [0:0] mux_2level_size20_5_out;
wire [0:9] mux_2level_size20_5_sram;
wire [0:9] mux_2level_size20_5_sram_inv;
wire [0:0] mux_2level_size20_6_out;
wire [0:9] mux_2level_size20_6_sram;
wire [0:9] mux_2level_size20_6_sram_inv;
wire [0:0] mux_2level_size20_7_out;
wire [0:9] mux_2level_size20_7_sram;
wire [0:9] mux_2level_size20_7_sram_inv;
wire [0:0] mux_2level_size20_8_out;
wire [0:9] mux_2level_size20_8_sram;
wire [0:9] mux_2level_size20_8_sram_inv;
wire [0:0] mux_2level_size20_9_out;
wire [0:9] mux_2level_size20_9_sram;
wire [0:9] mux_2level_size20_9_sram_inv;
wire [0:0] mux_2level_size20_mem_0_ccff_tail;
wire [0:0] mux_2level_size20_mem_10_ccff_tail;
wire [0:0] mux_2level_size20_mem_11_ccff_tail;
wire [0:0] mux_2level_size20_mem_12_ccff_tail;
wire [0:0] mux_2level_size20_mem_13_ccff_tail;
wire [0:0] mux_2level_size20_mem_14_ccff_tail;
wire [0:0] mux_2level_size20_mem_1_ccff_tail;
wire [0:0] mux_2level_size20_mem_2_ccff_tail;
wire [0:0] mux_2level_size20_mem_3_ccff_tail;
wire [0:0] mux_2level_size20_mem_4_ccff_tail;
wire [0:0] mux_2level_size20_mem_5_ccff_tail;
wire [0:0] mux_2level_size20_mem_6_ccff_tail;
wire [0:0] mux_2level_size20_mem_7_ccff_tail;
wire [0:0] mux_2level_size20_mem_8_ccff_tail;
wire [0:0] mux_2level_size20_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_clb_mode_default__fle logical_tile_clb_mode_default__fle_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.fle_in({mux_2level_size20_0_out, mux_2level_size20_1_out, mux_2level_size20_2_out, mux_2level_size20_3_out}),
		.fle_reset(direct_interc_8_out),
		.fle_clk(direct_interc_9_out),
		.ccff_head(ccff_head),
		.fle_out(logical_tile_clb_mode_default__fle_0_fle_out[0:1]),
		.ccff_tail(logical_tile_clb_mode_default__fle_0_ccff_tail));

	logical_tile_clb_mode_default__fle logical_tile_clb_mode_default__fle_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.fle_in({mux_2level_size20_4_out, mux_2level_size20_5_out, mux_2level_size20_6_out, mux_2level_size20_7_out}),
		.fle_reset(direct_interc_10_out),
		.fle_clk(direct_interc_11_out),
		.ccff_head(logical_tile_clb_mode_default__fle_0_ccff_tail),
		.fle_out(logical_tile_clb_mode_default__fle_1_fle_out[0:1]),
		.ccff_tail(logical_tile_clb_mode_default__fle_1_ccff_tail));

	logical_tile_clb_mode_default__fle logical_tile_clb_mode_default__fle_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.fle_in({mux_2level_size20_8_out, mux_2level_size20_9_out, mux_2level_size20_10_out, mux_2level_size20_11_out}),
		.fle_reset(direct_interc_12_out),
		.fle_clk(direct_interc_13_out),
		.ccff_head(logical_tile_clb_mode_default__fle_1_ccff_tail),
		.fle_out(logical_tile_clb_mode_default__fle_2_fle_out[0:1]),
		.ccff_tail(logical_tile_clb_mode_default__fle_2_ccff_tail));

	logical_tile_clb_mode_default__fle logical_tile_clb_mode_default__fle_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.fle_in({mux_2level_size20_12_out, mux_2level_size20_13_out, mux_2level_size20_14_out, mux_2level_size20_15_out}),
		.fle_reset(direct_interc_14_out),
		.fle_clk(direct_interc_15_out),
		.ccff_head(logical_tile_clb_mode_default__fle_2_ccff_tail),
		.fle_out(logical_tile_clb_mode_default__fle_3_fle_out[0:1]),
		.ccff_tail(logical_tile_clb_mode_default__fle_3_ccff_tail));

	direct_interc direct_interc_0_ (
		.in(logical_tile_clb_mode_default__fle_0_fle_out[0]),
		.out(clb_O[0]));

	direct_interc direct_interc_1_ (
		.in(logical_tile_clb_mode_default__fle_1_fle_out[0]),
		.out(clb_O[1]));

	direct_interc direct_interc_2_ (
		.in(logical_tile_clb_mode_default__fle_2_fle_out[0]),
		.out(clb_O[2]));

	direct_interc direct_interc_3_ (
		.in(logical_tile_clb_mode_default__fle_3_fle_out[0]),
		.out(clb_O[3]));

	direct_interc direct_interc_4_ (
		.in(logical_tile_clb_mode_default__fle_0_fle_out[1]),
		.out(clb_O[4]));

	direct_interc direct_interc_5_ (
		.in(logical_tile_clb_mode_default__fle_1_fle_out[1]),
		.out(clb_O[5]));

	direct_interc direct_interc_6_ (
		.in(logical_tile_clb_mode_default__fle_2_fle_out[1]),
		.out(clb_O[6]));

	direct_interc direct_interc_7_ (
		.in(logical_tile_clb_mode_default__fle_3_fle_out[1]),
		.out(clb_O[7]));

	direct_interc direct_interc_8_ (
		.in(clb_reset),
		.out(direct_interc_8_out));

	direct_interc direct_interc_9_ (
		.in(clb_clk),
		.out(direct_interc_9_out));

	direct_interc direct_interc_10_ (
		.in(clb_reset),
		.out(direct_interc_10_out));

	direct_interc direct_interc_11_ (
		.in(clb_clk),
		.out(direct_interc_11_out));

	direct_interc direct_interc_12_ (
		.in(clb_reset),
		.out(direct_interc_12_out));

	direct_interc direct_interc_13_ (
		.in(clb_clk),
		.out(direct_interc_13_out));

	direct_interc direct_interc_14_ (
		.in(clb_reset),
		.out(direct_interc_14_out));

	direct_interc direct_interc_15_ (
		.in(clb_clk),
		.out(direct_interc_15_out));

	mux_2level_size20 mux_fle_0_in_0 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_0_sram[0:9]),
		.sram_inv(mux_2level_size20_0_sram_inv[0:9]),
		.out(mux_2level_size20_0_out));

	mux_2level_size20 mux_fle_0_in_1 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_1_sram[0:9]),
		.sram_inv(mux_2level_size20_1_sram_inv[0:9]),
		.out(mux_2level_size20_1_out));

	mux_2level_size20 mux_fle_0_in_2 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_2_sram[0:9]),
		.sram_inv(mux_2level_size20_2_sram_inv[0:9]),
		.out(mux_2level_size20_2_out));

	mux_2level_size20 mux_fle_0_in_3 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_3_sram[0:9]),
		.sram_inv(mux_2level_size20_3_sram_inv[0:9]),
		.out(mux_2level_size20_3_out));

	mux_2level_size20 mux_fle_1_in_0 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_4_sram[0:9]),
		.sram_inv(mux_2level_size20_4_sram_inv[0:9]),
		.out(mux_2level_size20_4_out));

	mux_2level_size20 mux_fle_1_in_1 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_5_sram[0:9]),
		.sram_inv(mux_2level_size20_5_sram_inv[0:9]),
		.out(mux_2level_size20_5_out));

	mux_2level_size20 mux_fle_1_in_2 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_6_sram[0:9]),
		.sram_inv(mux_2level_size20_6_sram_inv[0:9]),
		.out(mux_2level_size20_6_out));

	mux_2level_size20 mux_fle_1_in_3 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_7_sram[0:9]),
		.sram_inv(mux_2level_size20_7_sram_inv[0:9]),
		.out(mux_2level_size20_7_out));

	mux_2level_size20 mux_fle_2_in_0 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_8_sram[0:9]),
		.sram_inv(mux_2level_size20_8_sram_inv[0:9]),
		.out(mux_2level_size20_8_out));

	mux_2level_size20 mux_fle_2_in_1 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_9_sram[0:9]),
		.sram_inv(mux_2level_size20_9_sram_inv[0:9]),
		.out(mux_2level_size20_9_out));

	mux_2level_size20 mux_fle_2_in_2 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_10_sram[0:9]),
		.sram_inv(mux_2level_size20_10_sram_inv[0:9]),
		.out(mux_2level_size20_10_out));

	mux_2level_size20 mux_fle_2_in_3 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_11_sram[0:9]),
		.sram_inv(mux_2level_size20_11_sram_inv[0:9]),
		.out(mux_2level_size20_11_out));

	mux_2level_size20 mux_fle_3_in_0 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_12_sram[0:9]),
		.sram_inv(mux_2level_size20_12_sram_inv[0:9]),
		.out(mux_2level_size20_12_out));

	mux_2level_size20 mux_fle_3_in_1 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_13_sram[0:9]),
		.sram_inv(mux_2level_size20_13_sram_inv[0:9]),
		.out(mux_2level_size20_13_out));

	mux_2level_size20 mux_fle_3_in_2 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_14_sram[0:9]),
		.sram_inv(mux_2level_size20_14_sram_inv[0:9]),
		.out(mux_2level_size20_14_out));

	mux_2level_size20 mux_fle_3_in_3 (
		.in({clb_I[0:11], logical_tile_clb_mode_default__fle_0_fle_out[0:1], logical_tile_clb_mode_default__fle_1_fle_out[0:1], logical_tile_clb_mode_default__fle_2_fle_out[0:1], logical_tile_clb_mode_default__fle_3_fle_out[0:1]}),
		.sram(mux_2level_size20_15_sram[0:9]),
		.sram_inv(mux_2level_size20_15_sram_inv[0:9]),
		.out(mux_2level_size20_15_out));

	mux_2level_size20_mem mem_fle_0_in_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(logical_tile_clb_mode_default__fle_3_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_0_ccff_tail),
		.mem_out(mux_2level_size20_0_sram[0:9]),
		.mem_outb(mux_2level_size20_0_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_0_in_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_0_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_1_ccff_tail),
		.mem_out(mux_2level_size20_1_sram[0:9]),
		.mem_outb(mux_2level_size20_1_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_0_in_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_1_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_2_ccff_tail),
		.mem_out(mux_2level_size20_2_sram[0:9]),
		.mem_outb(mux_2level_size20_2_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_0_in_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_2_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_3_ccff_tail),
		.mem_out(mux_2level_size20_3_sram[0:9]),
		.mem_outb(mux_2level_size20_3_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_1_in_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_3_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_4_ccff_tail),
		.mem_out(mux_2level_size20_4_sram[0:9]),
		.mem_outb(mux_2level_size20_4_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_1_in_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_4_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_5_ccff_tail),
		.mem_out(mux_2level_size20_5_sram[0:9]),
		.mem_outb(mux_2level_size20_5_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_1_in_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_5_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_6_ccff_tail),
		.mem_out(mux_2level_size20_6_sram[0:9]),
		.mem_outb(mux_2level_size20_6_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_1_in_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_6_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_7_ccff_tail),
		.mem_out(mux_2level_size20_7_sram[0:9]),
		.mem_outb(mux_2level_size20_7_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_2_in_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_7_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_8_ccff_tail),
		.mem_out(mux_2level_size20_8_sram[0:9]),
		.mem_outb(mux_2level_size20_8_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_2_in_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_8_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_9_ccff_tail),
		.mem_out(mux_2level_size20_9_sram[0:9]),
		.mem_outb(mux_2level_size20_9_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_2_in_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_9_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_10_ccff_tail),
		.mem_out(mux_2level_size20_10_sram[0:9]),
		.mem_outb(mux_2level_size20_10_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_2_in_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_10_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_11_ccff_tail),
		.mem_out(mux_2level_size20_11_sram[0:9]),
		.mem_outb(mux_2level_size20_11_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_3_in_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_11_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_12_ccff_tail),
		.mem_out(mux_2level_size20_12_sram[0:9]),
		.mem_outb(mux_2level_size20_12_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_3_in_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_12_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_13_ccff_tail),
		.mem_out(mux_2level_size20_13_sram[0:9]),
		.mem_outb(mux_2level_size20_13_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_3_in_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_13_ccff_tail),
		.ccff_tail(mux_2level_size20_mem_14_ccff_tail),
		.mem_out(mux_2level_size20_14_sram[0:9]),
		.mem_outb(mux_2level_size20_14_sram_inv[0:9]));

	mux_2level_size20_mem mem_fle_3_in_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_size20_mem_14_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_size20_15_sram[0:9]),
		.mem_outb(mux_2level_size20_15_sram_inv[0:9]));

endmodule
// ----- END Verilog module for logical_tile_clb_mode_clb_ -----

//----- Default net type -----
`default_nettype wire



// ----- END Physical programmable logic block Verilog module: clb -----

// ===== END logical_tile_clb_mode_clb_.v =====

// ===== BEGIN SRC\lb\grid_io_top.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for physical tile: io]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Grid Verilog module: grid_io_top -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for grid_io_top -----
module grid_io_top(pReset,
                   prog_clk,
                   gfpga_pad_GPIO_PAD,
                   bottom_width_0_height_0_subtile_0__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_1__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_2__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_3__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_4__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_5__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_6__pin_outpad_0_,
                   bottom_width_0_height_0_subtile_7__pin_outpad_0_,
                   ccff_head,
                   bottom_width_0_height_0_subtile_0__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_1__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_2__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_3__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_4__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_5__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_6__pin_inpad_0_,
                   bottom_width_0_height_0_subtile_7__pin_inpad_0_,
                   ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:7] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_0__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_1__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_2__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_3__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_4__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_5__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_6__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_width_0_height_0_subtile_7__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_0__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_1__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_2__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_3__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_4__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_5__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_6__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_width_0_height_0_subtile_7__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] logical_tile_io_mode_io__0_ccff_tail;
wire [0:0] logical_tile_io_mode_io__1_ccff_tail;
wire [0:0] logical_tile_io_mode_io__2_ccff_tail;
wire [0:0] logical_tile_io_mode_io__3_ccff_tail;
wire [0:0] logical_tile_io_mode_io__4_ccff_tail;
wire [0:0] logical_tile_io_mode_io__5_ccff_tail;
wire [0:0] logical_tile_io_mode_io__6_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_io_ logical_tile_io_mode_io__0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[0]),
		.io_outpad(bottom_width_0_height_0_subtile_0__pin_outpad_0_),
		.ccff_head(ccff_head),
		.io_inpad(bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__0_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[1]),
		.io_outpad(bottom_width_0_height_0_subtile_1__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__0_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__1_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[2]),
		.io_outpad(bottom_width_0_height_0_subtile_2__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__1_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__2_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[3]),
		.io_outpad(bottom_width_0_height_0_subtile_3__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__2_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__3_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[4]),
		.io_outpad(bottom_width_0_height_0_subtile_4__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__3_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__4_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[5]),
		.io_outpad(bottom_width_0_height_0_subtile_5__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__4_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__5_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[6]),
		.io_outpad(bottom_width_0_height_0_subtile_6__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__5_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__6_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[7]),
		.io_outpad(bottom_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__6_ccff_tail),
		.io_inpad(bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(ccff_tail));

endmodule
// ----- END Verilog module for grid_io_top -----

//----- Default net type -----
`default_nettype wire



// ----- END Grid Verilog module: grid_io_top -----


// ===== END grid_io_top.v =====

// ===== BEGIN SRC\lb\grid_io_right.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for physical tile: io]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Grid Verilog module: grid_io_right -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for grid_io_right -----
module grid_io_right(pReset,
                     prog_clk,
                     gfpga_pad_GPIO_PAD,
                     left_width_0_height_0_subtile_0__pin_outpad_0_,
                     left_width_0_height_0_subtile_1__pin_outpad_0_,
                     left_width_0_height_0_subtile_2__pin_outpad_0_,
                     left_width_0_height_0_subtile_3__pin_outpad_0_,
                     left_width_0_height_0_subtile_4__pin_outpad_0_,
                     left_width_0_height_0_subtile_5__pin_outpad_0_,
                     left_width_0_height_0_subtile_6__pin_outpad_0_,
                     left_width_0_height_0_subtile_7__pin_outpad_0_,
                     ccff_head,
                     left_width_0_height_0_subtile_0__pin_inpad_0_,
                     left_width_0_height_0_subtile_1__pin_inpad_0_,
                     left_width_0_height_0_subtile_2__pin_inpad_0_,
                     left_width_0_height_0_subtile_3__pin_inpad_0_,
                     left_width_0_height_0_subtile_4__pin_inpad_0_,
                     left_width_0_height_0_subtile_5__pin_inpad_0_,
                     left_width_0_height_0_subtile_6__pin_inpad_0_,
                     left_width_0_height_0_subtile_7__pin_inpad_0_,
                     ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:7] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_0__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_1__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_2__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_3__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_4__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_5__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_6__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] left_width_0_height_0_subtile_7__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_0__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_1__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_2__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_3__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_4__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_5__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_6__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_width_0_height_0_subtile_7__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] logical_tile_io_mode_io__0_ccff_tail;
wire [0:0] logical_tile_io_mode_io__1_ccff_tail;
wire [0:0] logical_tile_io_mode_io__2_ccff_tail;
wire [0:0] logical_tile_io_mode_io__3_ccff_tail;
wire [0:0] logical_tile_io_mode_io__4_ccff_tail;
wire [0:0] logical_tile_io_mode_io__5_ccff_tail;
wire [0:0] logical_tile_io_mode_io__6_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_io_ logical_tile_io_mode_io__0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[0]),
		.io_outpad(left_width_0_height_0_subtile_0__pin_outpad_0_),
		.ccff_head(ccff_head),
		.io_inpad(left_width_0_height_0_subtile_0__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__0_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[1]),
		.io_outpad(left_width_0_height_0_subtile_1__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__0_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_1__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__1_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[2]),
		.io_outpad(left_width_0_height_0_subtile_2__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__1_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_2__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__2_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[3]),
		.io_outpad(left_width_0_height_0_subtile_3__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__2_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_3__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__3_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[4]),
		.io_outpad(left_width_0_height_0_subtile_4__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__3_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_4__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__4_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[5]),
		.io_outpad(left_width_0_height_0_subtile_5__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__4_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_5__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__5_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[6]),
		.io_outpad(left_width_0_height_0_subtile_6__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__5_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_6__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__6_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[7]),
		.io_outpad(left_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__6_ccff_tail),
		.io_inpad(left_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(ccff_tail));

endmodule
// ----- END Verilog module for grid_io_right -----

//----- Default net type -----
`default_nettype wire



// ----- END Grid Verilog module: grid_io_right -----


// ===== END grid_io_right.v =====

// ===== BEGIN SRC\lb\grid_io_bottom.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for physical tile: io]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Grid Verilog module: grid_io_bottom -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for grid_io_bottom -----
module grid_io_bottom(pReset,
                      prog_clk,
                      gfpga_pad_GPIO_PAD,
                      top_width_0_height_0_subtile_0__pin_outpad_0_,
                      top_width_0_height_0_subtile_1__pin_outpad_0_,
                      top_width_0_height_0_subtile_2__pin_outpad_0_,
                      top_width_0_height_0_subtile_3__pin_outpad_0_,
                      top_width_0_height_0_subtile_4__pin_outpad_0_,
                      top_width_0_height_0_subtile_5__pin_outpad_0_,
                      top_width_0_height_0_subtile_6__pin_outpad_0_,
                      top_width_0_height_0_subtile_7__pin_outpad_0_,
                      ccff_head,
                      top_width_0_height_0_subtile_0__pin_inpad_0_,
                      top_width_0_height_0_subtile_1__pin_inpad_0_,
                      top_width_0_height_0_subtile_2__pin_inpad_0_,
                      top_width_0_height_0_subtile_3__pin_inpad_0_,
                      top_width_0_height_0_subtile_4__pin_inpad_0_,
                      top_width_0_height_0_subtile_5__pin_inpad_0_,
                      top_width_0_height_0_subtile_6__pin_inpad_0_,
                      top_width_0_height_0_subtile_7__pin_inpad_0_,
                      ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:7] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_1__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_2__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_3__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_4__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_5__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_6__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_7__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] logical_tile_io_mode_io__0_ccff_tail;
wire [0:0] logical_tile_io_mode_io__1_ccff_tail;
wire [0:0] logical_tile_io_mode_io__2_ccff_tail;
wire [0:0] logical_tile_io_mode_io__3_ccff_tail;
wire [0:0] logical_tile_io_mode_io__4_ccff_tail;
wire [0:0] logical_tile_io_mode_io__5_ccff_tail;
wire [0:0] logical_tile_io_mode_io__6_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_io_ logical_tile_io_mode_io__0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[0]),
		.io_outpad(top_width_0_height_0_subtile_0__pin_outpad_0_),
		.ccff_head(ccff_head),
		.io_inpad(top_width_0_height_0_subtile_0__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__0_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[1]),
		.io_outpad(top_width_0_height_0_subtile_1__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__0_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_1__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__1_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[2]),
		.io_outpad(top_width_0_height_0_subtile_2__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__1_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_2__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__2_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[3]),
		.io_outpad(top_width_0_height_0_subtile_3__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__2_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_3__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__3_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[4]),
		.io_outpad(top_width_0_height_0_subtile_4__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__3_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_4__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__4_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[5]),
		.io_outpad(top_width_0_height_0_subtile_5__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__4_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_5__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__5_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[6]),
		.io_outpad(top_width_0_height_0_subtile_6__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__5_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_6__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__6_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[7]),
		.io_outpad(top_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__6_ccff_tail),
		.io_inpad(top_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(ccff_tail));

endmodule
// ----- END Verilog module for grid_io_bottom -----

//----- Default net type -----
`default_nettype wire



// ----- END Grid Verilog module: grid_io_bottom -----


// ===== END grid_io_bottom.v =====

// ===== BEGIN SRC\lb\grid_io_left.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for physical tile: io]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Grid Verilog module: grid_io_left -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for grid_io_left -----
module grid_io_left(pReset,
                    prog_clk,
                    gfpga_pad_GPIO_PAD,
                    right_width_0_height_0_subtile_0__pin_outpad_0_,
                    right_width_0_height_0_subtile_1__pin_outpad_0_,
                    right_width_0_height_0_subtile_2__pin_outpad_0_,
                    right_width_0_height_0_subtile_3__pin_outpad_0_,
                    right_width_0_height_0_subtile_4__pin_outpad_0_,
                    right_width_0_height_0_subtile_5__pin_outpad_0_,
                    right_width_0_height_0_subtile_6__pin_outpad_0_,
                    right_width_0_height_0_subtile_7__pin_outpad_0_,
                    ccff_head,
                    right_width_0_height_0_subtile_0__pin_inpad_0_,
                    right_width_0_height_0_subtile_1__pin_inpad_0_,
                    right_width_0_height_0_subtile_2__pin_inpad_0_,
                    right_width_0_height_0_subtile_3__pin_inpad_0_,
                    right_width_0_height_0_subtile_4__pin_inpad_0_,
                    right_width_0_height_0_subtile_5__pin_inpad_0_,
                    right_width_0_height_0_subtile_6__pin_inpad_0_,
                    right_width_0_height_0_subtile_7__pin_inpad_0_,
                    ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:7] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_1__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_2__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_3__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_4__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_5__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_6__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_7__pin_outpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_0__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_1__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_2__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_3__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_4__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_5__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_6__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_7__pin_inpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] logical_tile_io_mode_io__0_ccff_tail;
wire [0:0] logical_tile_io_mode_io__1_ccff_tail;
wire [0:0] logical_tile_io_mode_io__2_ccff_tail;
wire [0:0] logical_tile_io_mode_io__3_ccff_tail;
wire [0:0] logical_tile_io_mode_io__4_ccff_tail;
wire [0:0] logical_tile_io_mode_io__5_ccff_tail;
wire [0:0] logical_tile_io_mode_io__6_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_io_mode_io_ logical_tile_io_mode_io__0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[0]),
		.io_outpad(right_width_0_height_0_subtile_0__pin_outpad_0_),
		.ccff_head(ccff_head),
		.io_inpad(right_width_0_height_0_subtile_0__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__0_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[1]),
		.io_outpad(right_width_0_height_0_subtile_1__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__0_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_1__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__1_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[2]),
		.io_outpad(right_width_0_height_0_subtile_2__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__1_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_2__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__2_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[3]),
		.io_outpad(right_width_0_height_0_subtile_3__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__2_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_3__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__3_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[4]),
		.io_outpad(right_width_0_height_0_subtile_4__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__3_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_4__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__4_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[5]),
		.io_outpad(right_width_0_height_0_subtile_5__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__4_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_5__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__5_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[6]),
		.io_outpad(right_width_0_height_0_subtile_6__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__5_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_6__pin_inpad_0_),
		.ccff_tail(logical_tile_io_mode_io__6_ccff_tail));

	logical_tile_io_mode_io_ logical_tile_io_mode_io__7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[7]),
		.io_outpad(right_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(logical_tile_io_mode_io__6_ccff_tail),
		.io_inpad(right_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(ccff_tail));

endmodule
// ----- END Verilog module for grid_io_left -----

//----- Default net type -----
`default_nettype wire



// ----- END Grid Verilog module: grid_io_left -----


// ===== END grid_io_left.v =====

// ===== BEGIN SRC\lb\grid_clb.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for physical tile: clb]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
// ----- BEGIN Grid Verilog module: grid_clb -----
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for grid_clb -----
module grid_clb(pReset,
                prog_clk,
                top_width_0_height_0_subtile_0__pin_I_6_,
                top_width_0_height_0_subtile_0__pin_I_7_,
                top_width_0_height_0_subtile_0__pin_I_8_,
                top_width_0_height_0_subtile_0__pin_I_9_,
                top_width_0_height_0_subtile_0__pin_I_10_,
                top_width_0_height_0_subtile_0__pin_I_11_,
                right_width_0_height_0_subtile_0__pin_I_0_,
                right_width_0_height_0_subtile_0__pin_I_1_,
                right_width_0_height_0_subtile_0__pin_I_2_,
                right_width_0_height_0_subtile_0__pin_I_3_,
                right_width_0_height_0_subtile_0__pin_I_4_,
                right_width_0_height_0_subtile_0__pin_I_5_,
                right_width_0_height_0_subtile_0__pin_reset_0_,
                right_width_0_height_0_subtile_0__pin_clk_0_,
                ccff_head,
                top_width_0_height_0_subtile_0__pin_O_4_,
                top_width_0_height_0_subtile_0__pin_O_5_,
                top_width_0_height_0_subtile_0__pin_O_6_,
                top_width_0_height_0_subtile_0__pin_O_7_,
                right_width_0_height_0_subtile_0__pin_O_0_,
                right_width_0_height_0_subtile_0__pin_O_1_,
                right_width_0_height_0_subtile_0__pin_O_2_,
                right_width_0_height_0_subtile_0__pin_O_3_,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_I_6_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_I_7_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_I_8_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_I_9_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_I_10_;
//----- INPUT PORTS -----
input [0:0] top_width_0_height_0_subtile_0__pin_I_11_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_I_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_I_1_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_I_2_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_I_3_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_I_4_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_I_5_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_reset_0_;
//----- INPUT PORTS -----
input [0:0] right_width_0_height_0_subtile_0__pin_clk_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_0__pin_O_4_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_0__pin_O_5_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_0__pin_O_6_;
//----- OUTPUT PORTS -----
output [0:0] top_width_0_height_0_subtile_0__pin_O_7_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_0__pin_O_0_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_0__pin_O_1_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_0__pin_O_2_;
//----- OUTPUT PORTS -----
output [0:0] right_width_0_height_0_subtile_0__pin_O_3_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----



// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	logical_tile_clb_mode_clb_ logical_tile_clb_mode_clb__0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.clb_I({right_width_0_height_0_subtile_0__pin_I_0_, right_width_0_height_0_subtile_0__pin_I_1_, right_width_0_height_0_subtile_0__pin_I_2_, right_width_0_height_0_subtile_0__pin_I_3_, right_width_0_height_0_subtile_0__pin_I_4_, right_width_0_height_0_subtile_0__pin_I_5_, top_width_0_height_0_subtile_0__pin_I_6_, top_width_0_height_0_subtile_0__pin_I_7_, top_width_0_height_0_subtile_0__pin_I_8_, top_width_0_height_0_subtile_0__pin_I_9_, top_width_0_height_0_subtile_0__pin_I_10_, top_width_0_height_0_subtile_0__pin_I_11_}),
		.clb_reset(right_width_0_height_0_subtile_0__pin_reset_0_),
		.clb_clk(right_width_0_height_0_subtile_0__pin_clk_0_),
		.ccff_head(ccff_head),
		.clb_O({right_width_0_height_0_subtile_0__pin_O_0_, right_width_0_height_0_subtile_0__pin_O_1_, right_width_0_height_0_subtile_0__pin_O_2_, right_width_0_height_0_subtile_0__pin_O_3_, top_width_0_height_0_subtile_0__pin_O_4_, top_width_0_height_0_subtile_0__pin_O_5_, top_width_0_height_0_subtile_0__pin_O_6_, top_width_0_height_0_subtile_0__pin_O_7_}),
		.ccff_tail(ccff_tail));

endmodule
// ----- END Verilog module for grid_clb -----

//----- Default net type -----
`default_nettype wire



// ----- END Grid Verilog module: grid_clb -----


// ===== END grid_clb.v =====

// ------ Include routing module netlists -----

// ===== BEGIN SRC\routing\sb_0__0_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[0][0]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_0__0_ -----
module sb_0__0_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_,
                chanx_right_in,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_,
                ccff_head,
                chany_top_out,
                chanx_right_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_10_sram;
wire [0:1] mux_2level_tapbuf_size2_10_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_11_sram;
wire [0:1] mux_2level_tapbuf_size2_11_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_12_sram;
wire [0:1] mux_2level_tapbuf_size2_12_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_13_sram;
wire [0:1] mux_2level_tapbuf_size2_13_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_14_sram;
wire [0:1] mux_2level_tapbuf_size2_14_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_15_sram;
wire [0:1] mux_2level_tapbuf_size2_15_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_10_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_11_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_12_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_13_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_14_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[8] = chany_top_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[9] = chany_top_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[10] = chany_top_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[11] = chany_top_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[12] = chany_top_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[13] = chany_top_in[12];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chanx_right_in[0];
// ----- Local connection due to Wire 31 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[8] = chanx_right_in[9];
// ----- Local connection due to Wire 32 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chanx_right_in[10];
// ----- Local connection due to Wire 33 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chanx_right_in[11];
// ----- Local connection due to Wire 34 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chanx_right_in[12];
// ----- Local connection due to Wire 35 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[12] = chanx_right_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_, chanx_right_in[1]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size2 mux_top_track_2 (
		.in({top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_, chanx_right_in[2]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chany_top_out[1]));

	mux_2level_tapbuf_size2 mux_top_track_4 (
		.in({top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_, chanx_right_in[3]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chany_top_out[2]));

	mux_2level_tapbuf_size2 mux_top_track_6 (
		.in({top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_, chanx_right_in[4]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chany_top_out[3]));

	mux_2level_tapbuf_size2 mux_top_track_8 (
		.in({top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_, chanx_right_in[5]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chany_top_out[4]));

	mux_2level_tapbuf_size2 mux_top_track_10 (
		.in({top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_, chanx_right_in[6]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chany_top_out[5]));

	mux_2level_tapbuf_size2 mux_top_track_12 (
		.in({top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_, chanx_right_in[7]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chany_top_out[6]));

	mux_2level_tapbuf_size2 mux_top_track_14 (
		.in({top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_, chanx_right_in[8]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chany_top_out[7]));

	mux_2level_tapbuf_size2 mux_right_track_0 (
		.in({chany_top_in[13], right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(chanx_right_out[0]));

	mux_2level_tapbuf_size2 mux_right_track_2 (
		.in({chany_top_in[0], right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(chanx_right_out[1]));

	mux_2level_tapbuf_size2 mux_right_track_4 (
		.in({chany_top_in[1], right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_10_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_10_sram_inv[0:1]),
		.out(chanx_right_out[2]));

	mux_2level_tapbuf_size2 mux_right_track_6 (
		.in({chany_top_in[2], right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_11_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_11_sram_inv[0:1]),
		.out(chanx_right_out[3]));

	mux_2level_tapbuf_size2 mux_right_track_8 (
		.in({chany_top_in[3], right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_12_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_12_sram_inv[0:1]),
		.out(chanx_right_out[4]));

	mux_2level_tapbuf_size2 mux_right_track_10 (
		.in({chany_top_in[4], right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_13_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_13_sram_inv[0:1]),
		.out(chanx_right_out[5]));

	mux_2level_tapbuf_size2 mux_right_track_12 (
		.in({chany_top_in[5], right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_14_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_14_sram_inv[0:1]),
		.out(chanx_right_out[6]));

	mux_2level_tapbuf_size2 mux_right_track_14 (
		.in({chany_top_in[6], right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_15_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_15_sram_inv[0:1]),
		.out(chanx_right_out[7]));

	mux_2level_tapbuf_size2_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_10_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_10_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_11_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_11_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_12_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_12_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_13_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_13_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_14_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_14_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_15_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_15_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_0__0_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_0__0_.v =====

// ===== BEGIN SRC\routing\sb_0__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[0][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_0__1_ -----
module sb_0__1_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_,
                top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_,
                chanx_right_in,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                chany_bottom_in,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_,
                ccff_head,
                chany_top_out,
                chanx_right_out,
                chany_bottom_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:1] mux_2level_tapbuf_size3_0_sram;
wire [0:1] mux_2level_tapbuf_size3_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_1_sram;
wire [0:1] mux_2level_tapbuf_size3_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_2_sram;
wire [0:1] mux_2level_tapbuf_size3_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_3_sram;
wire [0:1] mux_2level_tapbuf_size3_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_4_sram;
wire [0:1] mux_2level_tapbuf_size3_4_sram_inv;
wire [0:0] mux_2level_tapbuf_size3_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_4_ccff_tail;
wire [0:5] mux_2level_tapbuf_size4_0_sram;
wire [0:5] mux_2level_tapbuf_size4_0_sram_inv;
wire [0:0] mux_2level_tapbuf_size4_mem_0_ccff_tail;
wire [0:5] mux_2level_tapbuf_size5_0_sram;
wire [0:5] mux_2level_tapbuf_size5_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_1_sram;
wire [0:5] mux_2level_tapbuf_size5_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_2_sram;
wire [0:5] mux_2level_tapbuf_size5_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_3_sram;
wire [0:5] mux_2level_tapbuf_size5_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size5_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size5_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size5_mem_2_ccff_tail;
wire [0:5] mux_2level_tapbuf_size6_0_sram;
wire [0:5] mux_2level_tapbuf_size6_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_1_sram;
wire [0:5] mux_2level_tapbuf_size6_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_2_sram;
wire [0:5] mux_2level_tapbuf_size6_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_3_sram;
wire [0:5] mux_2level_tapbuf_size6_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size6_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_3_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[1] = chany_top_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[2] = chany_top_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[3] = chany_top_in[2];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[5] = chany_top_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[6] = chany_top_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[7] = chany_top_in[6];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[9] = chany_top_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[10] = chany_top_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[11] = chany_top_in[10];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[13] = chany_top_in[12];
// ----- Local connection due to Wire 36 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[0] = right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_[0];
// ----- Local connection due to Wire 40 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[1] = chany_bottom_in[0];
// ----- Local connection due to Wire 41 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[2] = chany_bottom_in[1];
// ----- Local connection due to Wire 42 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[3] = chany_bottom_in[2];
// ----- Local connection due to Wire 44 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[5] = chany_bottom_in[4];
// ----- Local connection due to Wire 45 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[6] = chany_bottom_in[5];
// ----- Local connection due to Wire 46 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[7] = chany_bottom_in[6];
// ----- Local connection due to Wire 48 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chany_bottom_in[8];
// ----- Local connection due to Wire 49 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chany_bottom_in[9];
// ----- Local connection due to Wire 50 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chany_bottom_in[10];
// ----- Local connection due to Wire 52 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chany_bottom_in[12];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size6 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_, top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_, chanx_right_in[1], chanx_right_in[5], chanx_right_in[9], chanx_right_in[13]}),
		.sram(mux_2level_tapbuf_size6_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_0_sram_inv[0:5]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size6 mux_top_track_24 (
		.in({top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_, top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_, chanx_right_in[0], chanx_right_in[4], chanx_right_in[8], chanx_right_in[12]}),
		.sram(mux_2level_tapbuf_size6_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_1_sram_inv[0:5]),
		.out(chany_top_out[12]));

	mux_2level_tapbuf_size6 mux_bottom_track_9 (
		.in({chanx_right_in[1], chanx_right_in[5], chanx_right_in[9], chanx_right_in[13], bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size6_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_2_sram_inv[0:5]),
		.out(chany_bottom_out[4]));

	mux_2level_tapbuf_size6 mux_bottom_track_17 (
		.in({chanx_right_in[0], chanx_right_in[4], chanx_right_in[8], chanx_right_in[12], bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size6_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_3_sram_inv[0:5]),
		.out(chany_bottom_out[8]));

	mux_2level_tapbuf_size6_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_0_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_top_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_1_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_bottom_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_2_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_bottom_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_3_sram_inv[0:5]));

	mux_2level_tapbuf_size5 mux_top_track_8 (
		.in({top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_, top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_, chanx_right_in[2], chanx_right_in[6], chanx_right_in[10]}),
		.sram(mux_2level_tapbuf_size5_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_0_sram_inv[0:5]),
		.out(chany_top_out[4]));

	mux_2level_tapbuf_size5 mux_top_track_16 (
		.in({top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_, top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_, chanx_right_in[3], chanx_right_in[7], chanx_right_in[11]}),
		.sram(mux_2level_tapbuf_size5_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_1_sram_inv[0:5]),
		.out(chany_top_out[8]));

	mux_2level_tapbuf_size5 mux_bottom_track_1 (
		.in({chanx_right_in[2], chanx_right_in[6], chanx_right_in[10], bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size5_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_2_sram_inv[0:5]),
		.out(chany_bottom_out[0]));

	mux_2level_tapbuf_size5 mux_bottom_track_25 (
		.in({chanx_right_in[3], chanx_right_in[7], chanx_right_in[11], bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size5_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_3_sram_inv[0:5]),
		.out(chany_bottom_out[12]));

	mux_2level_tapbuf_size5_mem mem_top_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_0_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_top_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_1_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_bottom_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_2_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_bottom_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_3_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_3_sram_inv[0:5]));

	mux_2level_tapbuf_size3 mux_right_track_2 (
		.in({chany_top_in[0], chany_top_in[3], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_}),
		.sram(mux_2level_tapbuf_size3_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_0_sram_inv[0:1]),
		.out(chanx_right_out[1]));

	mux_2level_tapbuf_size3 mux_right_track_4 (
		.in({chany_top_in[1], chany_top_in[7], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_}),
		.sram(mux_2level_tapbuf_size3_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_1_sram_inv[0:1]),
		.out(chanx_right_out[2]));

	mux_2level_tapbuf_size3 mux_right_track_8 (
		.in({chany_top_in[4], chany_top_in[13], chany_bottom_in[10]}),
		.sram(mux_2level_tapbuf_size3_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_2_sram_inv[0:1]),
		.out(chanx_right_out[4]));

	mux_2level_tapbuf_size3 mux_right_track_18 (
		.in({chany_top_in[10], chany_bottom_in[4], chany_bottom_in[13]}),
		.sram(mux_2level_tapbuf_size3_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_3_sram_inv[0:1]),
		.out(chanx_right_out[9]));

	mux_2level_tapbuf_size3 mux_right_track_20 (
		.in({chany_top_in[12], chany_bottom_in[2], chany_bottom_in[11]}),
		.sram(mux_2level_tapbuf_size3_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_4_sram_inv[0:1]),
		.out(chanx_right_out[10]));

	mux_2level_tapbuf_size3_mem mem_right_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_0_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_right_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_1_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_right_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size4_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_2_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_right_track_18 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_3_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_right_track_20 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_4_sram_inv[0:1]));

	mux_2level_tapbuf_size4 mux_right_track_6 (
		.in({chany_top_in[2], chany_top_in[11], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_, chany_bottom_in[12]}),
		.sram(mux_2level_tapbuf_size4_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size4_0_sram_inv[0:5]),
		.out(chanx_right_out[3]));

	mux_2level_tapbuf_size4_mem mem_right_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size4_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size4_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size4_0_sram_inv[0:5]));

	mux_2level_tapbuf_size2 mux_right_track_10 (
		.in({chany_top_in[5], chany_bottom_in[9]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chanx_right_out[5]));

	mux_2level_tapbuf_size2 mux_right_track_12 (
		.in({chany_top_in[6], chany_bottom_in[8]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chanx_right_out[6]));

	mux_2level_tapbuf_size2 mux_right_track_14 (
		.in({chany_top_in[8], chany_bottom_in[6]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chanx_right_out[7]));

	mux_2level_tapbuf_size2 mux_right_track_16 (
		.in({chany_top_in[9], chany_bottom_in[5]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chanx_right_out[8]));

	mux_2level_tapbuf_size2 mux_right_track_22 (
		.in({chany_bottom_in[1], chany_bottom_in[7]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chanx_right_out[11]));

	mux_2level_tapbuf_size2 mux_right_track_24 (
		.in({chany_bottom_in[0], chany_bottom_in[3]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chanx_right_out[12]));

	mux_2level_tapbuf_size2_mem mem_right_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_22 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_0__1_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_0__1_.v =====

// ===== BEGIN SRC\routing\sb_0__2_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[0][2]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_0__2_ -----
module sb_0__2_(pReset,
                prog_clk,
                chanx_right_in,
                right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                chany_bottom_in,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_,
                ccff_head,
                chanx_right_out,
                chany_bottom_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_10_sram;
wire [0:1] mux_2level_tapbuf_size2_10_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_11_sram;
wire [0:1] mux_2level_tapbuf_size2_11_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_12_sram;
wire [0:1] mux_2level_tapbuf_size2_12_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_13_sram;
wire [0:1] mux_2level_tapbuf_size2_13_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_14_sram;
wire [0:1] mux_2level_tapbuf_size2_14_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_15_sram;
wire [0:1] mux_2level_tapbuf_size2_15_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_16_sram;
wire [0:1] mux_2level_tapbuf_size2_16_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_17_sram;
wire [0:1] mux_2level_tapbuf_size2_17_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_18_sram;
wire [0:1] mux_2level_tapbuf_size2_18_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_19_sram;
wire [0:1] mux_2level_tapbuf_size2_19_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_10_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_11_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_12_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_13_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_14_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_15_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_16_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_17_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_18_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[12] = chanx_right_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[11] = chanx_right_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[10] = chanx_right_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[9] = chanx_right_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[8] = chanx_right_in[4];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[13] = chanx_right_in[13];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[12] = chany_bottom_in[0];
// ----- Local connection due to Wire 39 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[13] = chany_bottom_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_right_track_0 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_, chany_bottom_in[12]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chanx_right_out[0]));

	mux_2level_tapbuf_size2 mux_right_track_2 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_, chany_bottom_in[11]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chanx_right_out[1]));

	mux_2level_tapbuf_size2 mux_right_track_4 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_, chany_bottom_in[10]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chanx_right_out[2]));

	mux_2level_tapbuf_size2 mux_right_track_6 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_, chany_bottom_in[9]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chanx_right_out[3]));

	mux_2level_tapbuf_size2 mux_right_track_8 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_, chany_bottom_in[8]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chanx_right_out[4]));

	mux_2level_tapbuf_size2 mux_right_track_10 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_, chany_bottom_in[7]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chanx_right_out[5]));

	mux_2level_tapbuf_size2 mux_right_track_12 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_, chany_bottom_in[6]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chanx_right_out[6]));

	mux_2level_tapbuf_size2 mux_right_track_14 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_, chany_bottom_in[5]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chanx_right_out[7]));

	mux_2level_tapbuf_size2 mux_right_track_16 (
		.in({right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_, chany_bottom_in[4]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(chanx_right_out[8]));

	mux_2level_tapbuf_size2 mux_right_track_18 (
		.in({right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_, chany_bottom_in[3]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(chanx_right_out[9]));

	mux_2level_tapbuf_size2 mux_right_track_20 (
		.in({right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_, chany_bottom_in[2]}),
		.sram(mux_2level_tapbuf_size2_10_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_10_sram_inv[0:1]),
		.out(chanx_right_out[10]));

	mux_2level_tapbuf_size2 mux_right_track_22 (
		.in({right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_, chany_bottom_in[1]}),
		.sram(mux_2level_tapbuf_size2_11_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_11_sram_inv[0:1]),
		.out(chanx_right_out[11]));

	mux_2level_tapbuf_size2 mux_bottom_track_1 (
		.in({chanx_right_in[12], bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_12_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_12_sram_inv[0:1]),
		.out(chany_bottom_out[0]));

	mux_2level_tapbuf_size2 mux_bottom_track_3 (
		.in({chanx_right_in[11], bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_13_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_13_sram_inv[0:1]),
		.out(chany_bottom_out[1]));

	mux_2level_tapbuf_size2 mux_bottom_track_5 (
		.in({chanx_right_in[10], bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_14_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_14_sram_inv[0:1]),
		.out(chany_bottom_out[2]));

	mux_2level_tapbuf_size2 mux_bottom_track_7 (
		.in({chanx_right_in[9], bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_15_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_15_sram_inv[0:1]),
		.out(chany_bottom_out[3]));

	mux_2level_tapbuf_size2 mux_bottom_track_9 (
		.in({chanx_right_in[8], bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_16_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_16_sram_inv[0:1]),
		.out(chany_bottom_out[4]));

	mux_2level_tapbuf_size2 mux_bottom_track_11 (
		.in({chanx_right_in[7], bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_17_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_17_sram_inv[0:1]),
		.out(chany_bottom_out[5]));

	mux_2level_tapbuf_size2 mux_bottom_track_13 (
		.in({chanx_right_in[6], bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_18_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_18_sram_inv[0:1]),
		.out(chany_bottom_out[6]));

	mux_2level_tapbuf_size2 mux_bottom_track_15 (
		.in({chanx_right_in[5], bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_19_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_19_sram_inv[0:1]),
		.out(chany_bottom_out[7]));

	mux_2level_tapbuf_size2_mem mem_right_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_18 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_20 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_10_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_10_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_track_22 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_11_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_11_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_12_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_12_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_13_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_13_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_14_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_14_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_15_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_15_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_15_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_15_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_16_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_16_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_16_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_11 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_16_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_17_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_17_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_17_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_17_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_18_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_18_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_18_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_15 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_18_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_19_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_19_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_0__2_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_0__2_.v =====

// ===== BEGIN SRC\routing\sb_1__0_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[1][0]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_1__0_ -----
module sb_1__0_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                chanx_right_in,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_,
                chanx_left_in,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_,
                ccff_head,
                chany_top_out,
                chanx_right_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:1] mux_2level_tapbuf_size3_0_sram;
wire [0:1] mux_2level_tapbuf_size3_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_1_sram;
wire [0:1] mux_2level_tapbuf_size3_1_sram_inv;
wire [0:0] mux_2level_tapbuf_size3_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_1_ccff_tail;
wire [0:5] mux_2level_tapbuf_size4_0_sram;
wire [0:5] mux_2level_tapbuf_size4_0_sram_inv;
wire [0:0] mux_2level_tapbuf_size4_mem_0_ccff_tail;
wire [0:5] mux_2level_tapbuf_size5_0_sram;
wire [0:5] mux_2level_tapbuf_size5_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_1_sram;
wire [0:5] mux_2level_tapbuf_size5_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_2_sram;
wire [0:5] mux_2level_tapbuf_size5_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_3_sram;
wire [0:5] mux_2level_tapbuf_size5_3_sram_inv;
wire [0:5] mux_2level_tapbuf_size5_4_sram;
wire [0:5] mux_2level_tapbuf_size5_4_sram_inv;
wire [0:0] mux_2level_tapbuf_size5_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size5_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size5_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size5_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size5_mem_4_ccff_tail;
wire [0:5] mux_2level_tapbuf_size6_0_sram;
wire [0:5] mux_2level_tapbuf_size6_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_1_sram;
wire [0:5] mux_2level_tapbuf_size6_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_2_sram;
wire [0:5] mux_2level_tapbuf_size6_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_3_sram;
wire [0:5] mux_2level_tapbuf_size6_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size6_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_2_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[1] = chanx_right_in[0];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[2] = chanx_right_in[1];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[3] = chanx_right_in[2];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[5] = chanx_right_in[4];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[6] = chanx_right_in[5];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[4] = chanx_right_in[6];
// ----- Net sink id 1 -----
	assign chanx_left_out[7] = chanx_right_in[6];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[9] = chanx_right_in[8];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[10] = chanx_right_in[9];
// ----- Local connection due to Wire 28 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[11] = chanx_right_in[10];
// ----- Local connection due to Wire 30 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[13] = chanx_right_in[12];
// ----- Local connection due to Wire 40 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[1] = chanx_left_in[0];
// ----- Local connection due to Wire 41 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[2] = chanx_left_in[1];
// ----- Local connection due to Wire 42 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[3] = chanx_left_in[2];
// ----- Local connection due to Wire 44 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[5] = chanx_left_in[4];
// ----- Local connection due to Wire 45 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chanx_left_in[5];
// ----- Net sink id 1 -----
	assign chanx_right_out[6] = chanx_left_in[5];
// ----- Local connection due to Wire 46 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chanx_left_in[6];
// ----- Net sink id 1 -----
	assign chanx_right_out[7] = chanx_left_in[6];
// ----- Local connection due to Wire 48 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[9] = chanx_left_in[8];
// ----- Local connection due to Wire 49 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[10] = chanx_left_in[9];
// ----- Local connection due to Wire 50 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[11] = chanx_left_in[10];
// ----- Local connection due to Wire 52 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[13] = chanx_left_in[12];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
	assign chanx_left_out[7] = chany_top_out[4];
	assign chanx_right_out[6] = chany_top_out[10];
	assign chanx_right_out[7] = chany_top_out[9];
// ----- END Local output short connections -----

	mux_2level_tapbuf_size5 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_right_in[1], chanx_right_in[7], chanx_left_in[0], chanx_left_in[3]}),
		.sram(mux_2level_tapbuf_size5_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_0_sram_inv[0:5]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size5 mux_right_track_0 (
		.in({chany_top_in[3], chany_top_in[7], chany_top_in[11], right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size5_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_1_sram_inv[0:5]),
		.out(chanx_right_out[0]));

	mux_2level_tapbuf_size5 mux_right_track_24 (
		.in({chany_top_in[2], chany_top_in[6], chany_top_in[10], right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size5_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_2_sram_inv[0:5]),
		.out(chanx_right_out[12]));

	mux_2level_tapbuf_size5 mux_left_track_9 (
		.in({chany_top_in[3], chany_top_in[7], chany_top_in[11], left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size5_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_3_sram_inv[0:5]),
		.out(chanx_left_out[4]));

	mux_2level_tapbuf_size5 mux_left_track_17 (
		.in({chany_top_in[2], chany_top_in[6], chany_top_in[10], left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size5_4_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size5_4_sram_inv[0:5]),
		.out(chanx_left_out[8]));

	mux_2level_tapbuf_size5_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size5_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_0_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_right_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size4_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_1_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_right_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_2_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_left_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_3_sram_inv[0:5]));

	mux_2level_tapbuf_size5_mem mem_left_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size5_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size5_4_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size5_4_sram_inv[0:5]));

	mux_2level_tapbuf_size3 mux_top_track_2 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_right_in[2], chanx_right_in[11]}),
		.sram(mux_2level_tapbuf_size3_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_0_sram_inv[0:1]),
		.out(chany_top_out[1]));

	mux_2level_tapbuf_size3 mux_top_track_4 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_right_in[4], chanx_right_in[13]}),
		.sram(mux_2level_tapbuf_size3_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_1_sram_inv[0:1]),
		.out(chany_top_out[2]));

	mux_2level_tapbuf_size3_mem mem_top_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_0_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_top_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2 mux_top_track_6 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_right_in[5]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chany_top_out[3]));

	mux_2level_tapbuf_size2 mux_top_track_10 (
		.in({chanx_right_in[8], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chany_top_out[5]));

	mux_2level_tapbuf_size2 mux_top_track_12 (
		.in({chanx_right_in[9], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chany_top_out[6]));

	mux_2level_tapbuf_size2 mux_top_track_14 (
		.in({chanx_right_in[10], chanx_left_in[9]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chany_top_out[7]));

	mux_2level_tapbuf_size2 mux_top_track_16 (
		.in({chanx_right_in[12], chanx_left_in[8]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chany_top_out[8]));

	mux_2level_tapbuf_size2 mux_top_track_22 (
		.in({chanx_left_in[4], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chany_top_out[11]));

	mux_2level_tapbuf_size2 mux_top_track_24 (
		.in({chanx_left_in[2], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chany_top_out[12]));

	mux_2level_tapbuf_size2_mem mem_top_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_22 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size4 mux_top_track_26 (
		.in({chanx_right_in[0], chanx_right_in[3], chanx_left_in[1], chanx_left_in[7]}),
		.sram(mux_2level_tapbuf_size4_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size4_0_sram_inv[0:5]),
		.out(chany_top_out[13]));

	mux_2level_tapbuf_size4_mem mem_top_track_26 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size4_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size4_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size4_0_sram_inv[0:5]));

	mux_2level_tapbuf_size6 mux_right_track_8 (
		.in({chany_top_in[0], chany_top_in[4], chany_top_in[8], chany_top_in[12], right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size6_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_0_sram_inv[0:5]),
		.out(chanx_right_out[4]));

	mux_2level_tapbuf_size6 mux_right_track_16 (
		.in({chany_top_in[1], chany_top_in[5], chany_top_in[9], chany_top_in[13], right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size6_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_1_sram_inv[0:5]),
		.out(chanx_right_out[8]));

	mux_2level_tapbuf_size6 mux_left_track_1 (
		.in({chany_top_in[0], chany_top_in[4], chany_top_in[8], chany_top_in[12], left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size6_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_2_sram_inv[0:5]),
		.out(chanx_left_out[0]));

	mux_2level_tapbuf_size6 mux_left_track_25 (
		.in({chany_top_in[1], chany_top_in[5], chany_top_in[9], chany_top_in[13], left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size6_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_3_sram_inv[0:5]),
		.out(chanx_left_out[12]));

	mux_2level_tapbuf_size6_mem mem_right_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_0_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_right_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_1_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_left_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_2_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_left_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size5_mem_4_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_3_sram_inv[0:5]));

endmodule
// ----- END Verilog module for sb_1__0_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_1__0_.v =====

// ===== BEGIN SRC\routing\sb_1__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[1][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_1__1_ -----
module sb_1__1_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                chanx_right_in,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                chany_bottom_in,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                chanx_left_in,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                ccff_head,
                chany_top_out,
                chanx_right_out,
                chany_bottom_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:5] mux_2level_tapbuf_size7_0_sram;
wire [0:5] mux_2level_tapbuf_size7_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_1_sram;
wire [0:5] mux_2level_tapbuf_size7_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_2_sram;
wire [0:5] mux_2level_tapbuf_size7_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_3_sram;
wire [0:5] mux_2level_tapbuf_size7_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size7_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_3_ccff_tail;
wire [0:5] mux_2level_tapbuf_size8_0_sram;
wire [0:5] mux_2level_tapbuf_size8_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_1_sram;
wire [0:5] mux_2level_tapbuf_size8_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_2_sram;
wire [0:5] mux_2level_tapbuf_size8_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_3_sram;
wire [0:5] mux_2level_tapbuf_size8_3_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_4_sram;
wire [0:5] mux_2level_tapbuf_size8_4_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_5_sram;
wire [0:5] mux_2level_tapbuf_size8_5_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_6_sram;
wire [0:5] mux_2level_tapbuf_size8_6_sram_inv;
wire [0:5] mux_2level_tapbuf_size8_7_sram;
wire [0:5] mux_2level_tapbuf_size8_7_sram_inv;
wire [0:0] mux_2level_tapbuf_size8_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size8_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size8_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size8_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size8_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size8_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size8_mem_6_ccff_tail;
wire [0:7] mux_2level_tapbuf_size9_0_sram;
wire [0:7] mux_2level_tapbuf_size9_0_sram_inv;
wire [0:7] mux_2level_tapbuf_size9_1_sram;
wire [0:7] mux_2level_tapbuf_size9_1_sram_inv;
wire [0:7] mux_2level_tapbuf_size9_2_sram;
wire [0:7] mux_2level_tapbuf_size9_2_sram_inv;
wire [0:7] mux_2level_tapbuf_size9_3_sram;
wire [0:7] mux_2level_tapbuf_size9_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size9_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size9_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size9_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size9_mem_3_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[1] = chany_top_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[2] = chany_top_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[3] = chany_top_in[2];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[5] = chany_top_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[6] = chany_top_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[7] = chany_top_in[6];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[9] = chany_top_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[10] = chany_top_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[11] = chany_top_in[10];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chany_bottom_out[13] = chany_top_in[12];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[1] = chanx_right_in[0];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[2] = chanx_right_in[1];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[3] = chanx_right_in[2];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[5] = chanx_right_in[4];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[6] = chanx_right_in[5];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[7] = chanx_right_in[6];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[9] = chanx_right_in[8];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[10] = chanx_right_in[9];
// ----- Local connection due to Wire 28 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[11] = chanx_right_in[10];
// ----- Local connection due to Wire 30 -----
// ----- Net source id 0 -----
// ----- Net sink id 2 -----
	assign chanx_left_out[13] = chanx_right_in[12];
// ----- Local connection due to Wire 36 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[1] = chany_bottom_in[0];
// ----- Local connection due to Wire 37 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[2] = chany_bottom_in[1];
// ----- Local connection due to Wire 38 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[3] = chany_bottom_in[2];
// ----- Local connection due to Wire 40 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[5] = chany_bottom_in[4];
// ----- Local connection due to Wire 41 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[6] = chany_bottom_in[5];
// ----- Local connection due to Wire 42 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[7] = chany_bottom_in[6];
// ----- Local connection due to Wire 44 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chany_bottom_in[8];
// ----- Local connection due to Wire 45 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chany_bottom_in[9];
// ----- Local connection due to Wire 46 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chany_bottom_in[10];
// ----- Local connection due to Wire 48 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chany_bottom_in[12];
// ----- Local connection due to Wire 54 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[1] = chanx_left_in[0];
// ----- Local connection due to Wire 55 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[2] = chanx_left_in[1];
// ----- Local connection due to Wire 56 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[3] = chanx_left_in[2];
// ----- Local connection due to Wire 58 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[5] = chanx_left_in[4];
// ----- Local connection due to Wire 59 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[6] = chanx_left_in[5];
// ----- Local connection due to Wire 60 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[7] = chanx_left_in[6];
// ----- Local connection due to Wire 62 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[9] = chanx_left_in[8];
// ----- Local connection due to Wire 63 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[10] = chanx_left_in[9];
// ----- Local connection due to Wire 64 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[11] = chanx_left_in[10];
// ----- Local connection due to Wire 66 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_right_out[13] = chanx_left_in[12];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size9 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_right_in[1], chanx_right_in[6:7], chanx_right_in[12], chanx_left_in[0], chanx_left_in[3], chanx_left_in[5], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size9_0_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_0_sram_inv[0:7]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size9 mux_top_track_24 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_right_in[0], chanx_right_in[3], chanx_right_in[5], chanx_right_in[10], chanx_left_in[1], chanx_left_in[6:7], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size9_1_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_1_sram_inv[0:7]),
		.out(chany_top_out[12]));

	mux_2level_tapbuf_size9 mux_right_track_8 (
		.in({chany_top_in[0], chany_top_in[3], chany_top_in[5], chany_top_in[10], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_, chany_bottom_in[1], chany_bottom_in[6:7], chany_bottom_in[12]}),
		.sram(mux_2level_tapbuf_size9_2_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_2_sram_inv[0:7]),
		.out(chanx_right_out[4]));

	mux_2level_tapbuf_size9 mux_right_track_16 (
		.in({chany_top_in[1], chany_top_in[6:7], chany_top_in[12], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_, chany_bottom_in[0], chany_bottom_in[3], chany_bottom_in[5], chany_bottom_in[10]}),
		.sram(mux_2level_tapbuf_size9_3_sram[0:7]),
		.sram_inv(mux_2level_tapbuf_size9_3_sram_inv[0:7]),
		.out(chanx_right_out[8]));

	mux_2level_tapbuf_size9_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size9_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_0_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_0_sram_inv[0:7]));

	mux_2level_tapbuf_size9_mem mem_top_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size9_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_1_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_1_sram_inv[0:7]));

	mux_2level_tapbuf_size9_mem mem_right_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size9_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_2_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_2_sram_inv[0:7]));

	mux_2level_tapbuf_size9_mem mem_right_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size9_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size9_3_sram[0:7]),
		.mem_outb(mux_2level_tapbuf_size9_3_sram_inv[0:7]));

	mux_2level_tapbuf_size7 mux_top_track_8 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_right_in[2], chanx_right_in[8], chanx_right_in[11], chanx_left_in[4], chanx_left_in[9], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size7_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_0_sram_inv[0:5]),
		.out(chany_top_out[4]));

	mux_2level_tapbuf_size7 mux_top_track_16 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_right_in[4], chanx_right_in[9], chanx_right_in[13], chanx_left_in[2], chanx_left_in[8], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size7_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_1_sram_inv[0:5]),
		.out(chany_top_out[8]));

	mux_2level_tapbuf_size7 mux_right_track_0 (
		.in({chany_top_in[4], chany_top_in[9], chany_top_in[13], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_, chany_bottom_in[2], chany_bottom_in[8], chany_bottom_in[11]}),
		.sram(mux_2level_tapbuf_size7_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_2_sram_inv[0:5]),
		.out(chanx_right_out[0]));

	mux_2level_tapbuf_size7 mux_right_track_24 (
		.in({chany_top_in[2], chany_top_in[8], chany_top_in[11], right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_, chany_bottom_in[4], chany_bottom_in[9], chany_bottom_in[13]}),
		.sram(mux_2level_tapbuf_size7_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_3_sram_inv[0:5]),
		.out(chanx_right_out[12]));

	mux_2level_tapbuf_size7_mem mem_top_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_0_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_top_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_1_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_right_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_2_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_right_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size9_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_3_sram_inv[0:5]));

	mux_2level_tapbuf_size8 mux_bottom_track_1 (
		.in({chanx_right_in[2], chanx_right_in[8], chanx_right_in[11], bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_left_in[1], chanx_left_in[6:7], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size8_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_0_sram_inv[0:5]),
		.out(chany_bottom_out[0]));

	mux_2level_tapbuf_size8 mux_bottom_track_9 (
		.in({chanx_right_in[1], chanx_right_in[6:7], chanx_right_in[12], bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_left_in[2], chanx_left_in[8], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size8_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_1_sram_inv[0:5]),
		.out(chany_bottom_out[4]));

	mux_2level_tapbuf_size8 mux_bottom_track_17 (
		.in({chanx_right_in[0], chanx_right_in[3], chanx_right_in[5], chanx_right_in[10], bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_left_in[4], chanx_left_in[9], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size8_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_2_sram_inv[0:5]),
		.out(chany_bottom_out[8]));

	mux_2level_tapbuf_size8 mux_bottom_track_25 (
		.in({chanx_right_in[4], chanx_right_in[9], chanx_right_in[13], bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_left_in[0], chanx_left_in[3], chanx_left_in[5], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size8_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_3_sram_inv[0:5]),
		.out(chany_bottom_out[12]));

	mux_2level_tapbuf_size8 mux_left_track_1 (
		.in({chany_top_in[0], chany_top_in[3], chany_top_in[5], chany_top_in[10], chany_bottom_in[4], chany_bottom_in[9], chany_bottom_in[13], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_}),
		.sram(mux_2level_tapbuf_size8_4_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_4_sram_inv[0:5]),
		.out(chanx_left_out[0]));

	mux_2level_tapbuf_size8 mux_left_track_9 (
		.in({chany_top_in[4], chany_top_in[9], chany_top_in[13], chany_bottom_in[0], chany_bottom_in[3], chany_bottom_in[5], chany_bottom_in[10], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_}),
		.sram(mux_2level_tapbuf_size8_5_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_5_sram_inv[0:5]),
		.out(chanx_left_out[4]));

	mux_2level_tapbuf_size8 mux_left_track_17 (
		.in({chany_top_in[2], chany_top_in[8], chany_top_in[11], chany_bottom_in[1], chany_bottom_in[6:7], chany_bottom_in[12], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_}),
		.sram(mux_2level_tapbuf_size8_6_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_6_sram_inv[0:5]),
		.out(chanx_left_out[8]));

	mux_2level_tapbuf_size8 mux_left_track_25 (
		.in({chany_top_in[1], chany_top_in[6:7], chany_top_in[12], chany_bottom_in[2], chany_bottom_in[8], chany_bottom_in[11], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_}),
		.sram(mux_2level_tapbuf_size8_7_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size8_7_sram_inv[0:5]),
		.out(chanx_left_out[12]));

	mux_2level_tapbuf_size8_mem mem_bottom_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_0_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_bottom_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_1_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_bottom_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_2_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_bottom_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_3_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_left_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_4_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_4_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_left_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_5_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_5_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_left_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size8_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_6_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_6_sram_inv[0:5]));

	mux_2level_tapbuf_size8_mem mem_left_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size8_mem_6_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size8_7_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size8_7_sram_inv[0:5]));

endmodule
// ----- END Verilog module for sb_1__1_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_1__1_.v =====

// ===== BEGIN SRC\routing\sb_1__2_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[1][2]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_1__2_ -----
module sb_1__2_(pReset,
                prog_clk,
                chanx_right_in,
                right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_,
                right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                chany_bottom_in,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                chanx_left_in,
                left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                ccff_head,
                chanx_right_out,
                chany_bottom_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;
wire [0:1] mux_2level_tapbuf_size3_0_sram;
wire [0:1] mux_2level_tapbuf_size3_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_1_sram;
wire [0:1] mux_2level_tapbuf_size3_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_2_sram;
wire [0:1] mux_2level_tapbuf_size3_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_3_sram;
wire [0:1] mux_2level_tapbuf_size3_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size3_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_3_ccff_tail;
wire [0:5] mux_2level_tapbuf_size6_0_sram;
wire [0:5] mux_2level_tapbuf_size6_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_1_sram;
wire [0:5] mux_2level_tapbuf_size6_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_2_sram;
wire [0:5] mux_2level_tapbuf_size6_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_3_sram;
wire [0:5] mux_2level_tapbuf_size6_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size6_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_2_ccff_tail;
wire [0:5] mux_2level_tapbuf_size7_0_sram;
wire [0:5] mux_2level_tapbuf_size7_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_1_sram;
wire [0:5] mux_2level_tapbuf_size7_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_2_sram;
wire [0:5] mux_2level_tapbuf_size7_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_3_sram;
wire [0:5] mux_2level_tapbuf_size7_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size7_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_3_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[1] = chanx_right_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[2] = chanx_right_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[3] = chanx_right_in[2];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[5] = chanx_right_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[6] = chanx_right_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[7] = chanx_right_in[6];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[9] = chanx_right_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[10] = chanx_right_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[11] = chanx_right_in[10];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 1 -----
	assign chanx_left_out[13] = chanx_right_in[12];
// ----- Local connection due to Wire 44 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[1] = chanx_left_in[0];
// ----- Local connection due to Wire 45 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[2] = chanx_left_in[1];
// ----- Local connection due to Wire 46 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[3] = chanx_left_in[2];
// ----- Local connection due to Wire 48 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[5] = chanx_left_in[4];
// ----- Local connection due to Wire 49 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[6] = chanx_left_in[5];
// ----- Local connection due to Wire 50 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[7] = chanx_left_in[6];
// ----- Local connection due to Wire 52 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[9] = chanx_left_in[8];
// ----- Local connection due to Wire 53 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[10] = chanx_left_in[9];
// ----- Local connection due to Wire 54 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[11] = chanx_left_in[10];
// ----- Local connection due to Wire 56 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[13] = chanx_left_in[12];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size6 mux_right_track_0 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_, right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_, chany_bottom_in[2], chany_bottom_in[6], chany_bottom_in[10]}),
		.sram(mux_2level_tapbuf_size6_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_0_sram_inv[0:5]),
		.out(chanx_right_out[0]));

	mux_2level_tapbuf_size6 mux_right_track_24 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_, right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_, chany_bottom_in[3], chany_bottom_in[7], chany_bottom_in[11]}),
		.sram(mux_2level_tapbuf_size6_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_1_sram_inv[0:5]),
		.out(chanx_right_out[12]));

	mux_2level_tapbuf_size6 mux_left_track_1 (
		.in({chany_bottom_in[3], chany_bottom_in[7], chany_bottom_in[11], left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_, left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_}),
		.sram(mux_2level_tapbuf_size6_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_2_sram_inv[0:5]),
		.out(chanx_left_out[0]));

	mux_2level_tapbuf_size6 mux_left_track_25 (
		.in({chany_bottom_in[2], chany_bottom_in[6], chany_bottom_in[10], left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_, left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_}),
		.sram(mux_2level_tapbuf_size6_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_3_sram_inv[0:5]),
		.out(chanx_left_out[12]));

	mux_2level_tapbuf_size6_mem mem_right_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_0_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_right_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_1_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_left_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_2_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_left_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_3_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_3_sram_inv[0:5]));

	mux_2level_tapbuf_size7 mux_right_track_8 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_, right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_, chany_bottom_in[1], chany_bottom_in[5], chany_bottom_in[9], chany_bottom_in[13]}),
		.sram(mux_2level_tapbuf_size7_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_0_sram_inv[0:5]),
		.out(chanx_right_out[4]));

	mux_2level_tapbuf_size7 mux_right_track_16 (
		.in({right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_, right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_, right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_, chany_bottom_in[0], chany_bottom_in[4], chany_bottom_in[8], chany_bottom_in[12]}),
		.sram(mux_2level_tapbuf_size7_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_1_sram_inv[0:5]),
		.out(chanx_right_out[8]));

	mux_2level_tapbuf_size7 mux_left_track_9 (
		.in({chany_bottom_in[0], chany_bottom_in[4], chany_bottom_in[8], chany_bottom_in[12], left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_, left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_}),
		.sram(mux_2level_tapbuf_size7_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_2_sram_inv[0:5]),
		.out(chanx_left_out[4]));

	mux_2level_tapbuf_size7 mux_left_track_17 (
		.in({chany_bottom_in[1], chany_bottom_in[5], chany_bottom_in[9], chany_bottom_in[13], left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_, left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_, left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_}),
		.sram(mux_2level_tapbuf_size7_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_3_sram_inv[0:5]),
		.out(chanx_left_out[8]));

	mux_2level_tapbuf_size7_mem mem_right_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_0_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_right_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_1_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_left_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_2_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_left_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_3_sram_inv[0:5]));

	mux_2level_tapbuf_size3 mux_bottom_track_1 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_left_in[1], chanx_left_in[7]}),
		.sram(mux_2level_tapbuf_size3_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_0_sram_inv[0:1]),
		.out(chany_bottom_out[0]));

	mux_2level_tapbuf_size3 mux_bottom_track_3 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_left_in[2], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size3_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_1_sram_inv[0:1]),
		.out(chany_bottom_out[1]));

	mux_2level_tapbuf_size3 mux_bottom_track_5 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_left_in[4], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size3_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_2_sram_inv[0:1]),
		.out(chany_bottom_out[2]));

	mux_2level_tapbuf_size3 mux_bottom_track_7 (
		.in({chanx_right_in[12], bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_left_in[5]}),
		.sram(mux_2level_tapbuf_size3_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_3_sram_inv[0:1]),
		.out(chany_bottom_out[3]));

	mux_2level_tapbuf_size3_mem mem_bottom_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_0_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_bottom_track_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_1_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_bottom_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_2_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_bottom_track_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2 mux_bottom_track_9 (
		.in({chanx_right_in[10], chanx_left_in[6]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chany_bottom_out[4]));

	mux_2level_tapbuf_size2 mux_bottom_track_11 (
		.in({chanx_right_in[9], chanx_left_in[8]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chany_bottom_out[5]));

	mux_2level_tapbuf_size2 mux_bottom_track_13 (
		.in({chanx_right_in[8], chanx_left_in[9]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chany_bottom_out[6]));

	mux_2level_tapbuf_size2 mux_bottom_track_15 (
		.in({chanx_right_in[6], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chany_bottom_out[7]));

	mux_2level_tapbuf_size2 mux_bottom_track_17 (
		.in({chanx_right_in[5], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chany_bottom_out[8]));

	mux_2level_tapbuf_size2 mux_bottom_track_19 (
		.in({chanx_right_in[4], chanx_right_in[13]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chany_bottom_out[9]));

	mux_2level_tapbuf_size2 mux_bottom_track_21 (
		.in({chanx_right_in[2], chanx_right_in[11]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chany_bottom_out[10]));

	mux_2level_tapbuf_size2 mux_bottom_track_23 (
		.in({chanx_right_in[1], chanx_right_in[7]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chany_bottom_out[11]));

	mux_2level_tapbuf_size2 mux_bottom_track_25 (
		.in({chanx_right_in[0], chanx_right_in[3]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(chany_bottom_out[12]));

	mux_2level_tapbuf_size2 mux_bottom_track_27 (
		.in({chanx_left_in[0], chanx_left_in[3]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(chany_bottom_out[13]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_11 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_15 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_19 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_21 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_23 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_27 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_1__2_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_1__2_.v =====

// ===== BEGIN SRC\routing\sb_2__0_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[2][0]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_2__0_ -----
module sb_2__0_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_,
                chanx_left_in,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_,
                ccff_head,
                chany_top_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_10_sram;
wire [0:1] mux_2level_tapbuf_size2_10_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_11_sram;
wire [0:1] mux_2level_tapbuf_size2_11_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_12_sram;
wire [0:1] mux_2level_tapbuf_size2_12_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_13_sram;
wire [0:1] mux_2level_tapbuf_size2_13_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_14_sram;
wire [0:1] mux_2level_tapbuf_size2_14_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_15_sram;
wire [0:1] mux_2level_tapbuf_size2_15_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_16_sram;
wire [0:1] mux_2level_tapbuf_size2_16_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_17_sram;
wire [0:1] mux_2level_tapbuf_size2_17_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_18_sram;
wire [0:1] mux_2level_tapbuf_size2_18_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_19_sram;
wire [0:1] mux_2level_tapbuf_size2_19_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_10_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_11_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_12_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_13_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_14_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_15_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_16_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_17_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_18_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[13] = chany_top_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[12] = chany_top_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[11] = chany_top_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[10] = chany_top_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[9] = chany_top_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[8] = chany_top_in[6];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chanx_left_in[1];
// ----- Local connection due to Wire 28 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[12] = chanx_left_in[2];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_left_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size2 mux_top_track_2 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chany_top_out[1]));

	mux_2level_tapbuf_size2 mux_top_track_4 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chany_top_out[2]));

	mux_2level_tapbuf_size2 mux_top_track_6 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chany_top_out[3]));

	mux_2level_tapbuf_size2 mux_top_track_8 (
		.in({top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_, chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chany_top_out[4]));

	mux_2level_tapbuf_size2 mux_top_track_10 (
		.in({top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_, chanx_left_in[9]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chany_top_out[5]));

	mux_2level_tapbuf_size2 mux_top_track_12 (
		.in({top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_, chanx_left_in[8]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chany_top_out[6]));

	mux_2level_tapbuf_size2 mux_top_track_14 (
		.in({top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_, chanx_left_in[7]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chany_top_out[7]));

	mux_2level_tapbuf_size2 mux_top_track_16 (
		.in({top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_, chanx_left_in[6]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(chany_top_out[8]));

	mux_2level_tapbuf_size2 mux_top_track_18 (
		.in({top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_, chanx_left_in[5]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(chany_top_out[9]));

	mux_2level_tapbuf_size2 mux_top_track_20 (
		.in({top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_, chanx_left_in[4]}),
		.sram(mux_2level_tapbuf_size2_10_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_10_sram_inv[0:1]),
		.out(chany_top_out[10]));

	mux_2level_tapbuf_size2 mux_top_track_22 (
		.in({top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_, chanx_left_in[3]}),
		.sram(mux_2level_tapbuf_size2_11_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_11_sram_inv[0:1]),
		.out(chany_top_out[11]));

	mux_2level_tapbuf_size2 mux_left_track_1 (
		.in({chany_top_in[0], left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_12_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_12_sram_inv[0:1]),
		.out(chanx_left_out[0]));

	mux_2level_tapbuf_size2 mux_left_track_3 (
		.in({chany_top_in[13], left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_13_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_13_sram_inv[0:1]),
		.out(chanx_left_out[1]));

	mux_2level_tapbuf_size2 mux_left_track_5 (
		.in({chany_top_in[12], left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_14_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_14_sram_inv[0:1]),
		.out(chanx_left_out[2]));

	mux_2level_tapbuf_size2 mux_left_track_7 (
		.in({chany_top_in[11], left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_15_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_15_sram_inv[0:1]),
		.out(chanx_left_out[3]));

	mux_2level_tapbuf_size2 mux_left_track_9 (
		.in({chany_top_in[10], left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_16_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_16_sram_inv[0:1]),
		.out(chanx_left_out[4]));

	mux_2level_tapbuf_size2 mux_left_track_11 (
		.in({chany_top_in[9], left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_17_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_17_sram_inv[0:1]),
		.out(chanx_left_out[5]));

	mux_2level_tapbuf_size2 mux_left_track_13 (
		.in({chany_top_in[8], left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_18_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_18_sram_inv[0:1]),
		.out(chanx_left_out[6]));

	mux_2level_tapbuf_size2 mux_left_track_15 (
		.in({chany_top_in[7], left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_19_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_19_sram_inv[0:1]),
		.out(chanx_left_out[7]));

	mux_2level_tapbuf_size2_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_10 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_12 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_14 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_18 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_20 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_10_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_10_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_track_22 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_11_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_11_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_12_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_12_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_13_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_13_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_14_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_14_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_15_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_15_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_15_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_15_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_16_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_16_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_16_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_11 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_16_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_17_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_17_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_17_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_17_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_18_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_18_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_18_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_15 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_18_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_19_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_19_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_2__0_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_2__0_.v =====

// ===== BEGIN SRC\routing\sb_2__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[2][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_2__1_ -----
module sb_2__1_(pReset,
                prog_clk,
                chany_top_in,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_,
                top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_,
                chany_bottom_in,
                bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                chanx_left_in,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                ccff_head,
                chany_top_out,
                chany_bottom_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:1] mux_2level_tapbuf_size3_0_sram;
wire [0:1] mux_2level_tapbuf_size3_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_1_sram;
wire [0:1] mux_2level_tapbuf_size3_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_2_sram;
wire [0:1] mux_2level_tapbuf_size3_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size3_3_sram;
wire [0:1] mux_2level_tapbuf_size3_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size3_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size3_mem_3_ccff_tail;
wire [0:5] mux_2level_tapbuf_size6_0_sram;
wire [0:5] mux_2level_tapbuf_size6_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_1_sram;
wire [0:5] mux_2level_tapbuf_size6_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_2_sram;
wire [0:5] mux_2level_tapbuf_size6_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size6_3_sram;
wire [0:5] mux_2level_tapbuf_size6_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size6_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size6_mem_3_ccff_tail;
wire [0:5] mux_2level_tapbuf_size7_0_sram;
wire [0:5] mux_2level_tapbuf_size7_0_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_1_sram;
wire [0:5] mux_2level_tapbuf_size7_1_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_2_sram;
wire [0:5] mux_2level_tapbuf_size7_2_sram_inv;
wire [0:5] mux_2level_tapbuf_size7_3_sram;
wire [0:5] mux_2level_tapbuf_size7_3_sram_inv;
wire [0:0] mux_2level_tapbuf_size7_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size7_mem_3_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[1] = chany_top_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[2] = chany_top_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[3] = chany_top_in[2];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[5] = chany_top_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[6] = chany_top_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[7] = chany_top_in[6];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[9] = chany_top_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[10] = chany_top_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[11] = chany_top_in[10];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[13] = chany_top_in[12];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[1] = chany_bottom_in[0];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[2] = chany_bottom_in[1];
// ----- Local connection due to Wire 28 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[3] = chany_bottom_in[2];
// ----- Local connection due to Wire 30 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[5] = chany_bottom_in[4];
// ----- Local connection due to Wire 31 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[6] = chany_bottom_in[5];
// ----- Local connection due to Wire 32 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[7] = chany_bottom_in[6];
// ----- Local connection due to Wire 34 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chany_bottom_in[8];
// ----- Local connection due to Wire 35 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chany_bottom_in[9];
// ----- Local connection due to Wire 36 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chany_bottom_in[10];
// ----- Local connection due to Wire 38 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chany_bottom_in[12];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size7 mux_top_track_0 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_, top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_, chanx_left_in[0], chanx_left_in[4], chanx_left_in[8], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size7_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_0_sram_inv[0:5]),
		.out(chany_top_out[0]));

	mux_2level_tapbuf_size7 mux_top_track_24 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_, top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_, chanx_left_in[1], chanx_left_in[5], chanx_left_in[9], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size7_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_1_sram_inv[0:5]),
		.out(chany_top_out[12]));

	mux_2level_tapbuf_size7 mux_bottom_track_1 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_, bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_left_in[1], chanx_left_in[5], chanx_left_in[9], chanx_left_in[13]}),
		.sram(mux_2level_tapbuf_size7_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_2_sram_inv[0:5]),
		.out(chany_bottom_out[0]));

	mux_2level_tapbuf_size7 mux_bottom_track_25 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_, bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_left_in[0], chanx_left_in[4], chanx_left_in[8], chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size7_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size7_3_sram_inv[0:5]),
		.out(chany_bottom_out[12]));

	mux_2level_tapbuf_size7_mem mem_top_track_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size7_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_0_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_top_track_24 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_1_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_bottom_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_2_sram_inv[0:5]));

	mux_2level_tapbuf_size7_mem mem_bottom_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size7_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size7_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size7_3_sram_inv[0:5]));

	mux_2level_tapbuf_size6 mux_top_track_8 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_, top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_, chanx_left_in[3], chanx_left_in[7], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size6_0_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_0_sram_inv[0:5]),
		.out(chany_top_out[4]));

	mux_2level_tapbuf_size6 mux_top_track_16 (
		.in({top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_, top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_, chanx_left_in[2], chanx_left_in[6], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size6_1_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_1_sram_inv[0:5]),
		.out(chany_top_out[8]));

	mux_2level_tapbuf_size6 mux_bottom_track_9 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_, bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_left_in[2], chanx_left_in[6], chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size6_2_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_2_sram_inv[0:5]),
		.out(chany_bottom_out[4]));

	mux_2level_tapbuf_size6 mux_bottom_track_17 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_, bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_, bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_left_in[3], chanx_left_in[7], chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size6_3_sram[0:5]),
		.sram_inv(mux_2level_tapbuf_size6_3_sram_inv[0:5]),
		.out(chany_bottom_out[8]));

	mux_2level_tapbuf_size6_mem mem_top_track_8 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_0_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_0_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_top_track_16 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_1_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_1_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_bottom_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_2_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_2_sram_inv[0:5]));

	mux_2level_tapbuf_size6_mem mem_bottom_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size6_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size6_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size6_3_sram[0:5]),
		.mem_outb(mux_2level_tapbuf_size6_3_sram_inv[0:5]));

	mux_2level_tapbuf_size3 mux_left_track_1 (
		.in({chany_top_in[0], chany_top_in[3], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_}),
		.sram(mux_2level_tapbuf_size3_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_0_sram_inv[0:1]),
		.out(chanx_left_out[0]));

	mux_2level_tapbuf_size3 mux_left_track_3 (
		.in({chany_bottom_in[0], chany_bottom_in[3], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_}),
		.sram(mux_2level_tapbuf_size3_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_1_sram_inv[0:1]),
		.out(chanx_left_out[1]));

	mux_2level_tapbuf_size3 mux_left_track_5 (
		.in({chany_bottom_in[1], chany_bottom_in[7], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_}),
		.sram(mux_2level_tapbuf_size3_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_2_sram_inv[0:1]),
		.out(chanx_left_out[2]));

	mux_2level_tapbuf_size3 mux_left_track_7 (
		.in({chany_bottom_in[2], chany_bottom_in[11], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_}),
		.sram(mux_2level_tapbuf_size3_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size3_3_sram_inv[0:1]),
		.out(chanx_left_out[3]));

	mux_2level_tapbuf_size3_mem mem_left_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size7_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_0_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_left_track_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_1_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_left_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_2_sram_inv[0:1]));

	mux_2level_tapbuf_size3_mem mem_left_track_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size3_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size3_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2 mux_left_track_9 (
		.in({chany_bottom_in[4], chany_bottom_in[13]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chanx_left_out[4]));

	mux_2level_tapbuf_size2 mux_left_track_11 (
		.in({chany_top_in[12], chany_bottom_in[5]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chanx_left_out[5]));

	mux_2level_tapbuf_size2 mux_left_track_13 (
		.in({chany_top_in[10], chany_bottom_in[6]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chanx_left_out[6]));

	mux_2level_tapbuf_size2 mux_left_track_15 (
		.in({chany_top_in[9], chany_bottom_in[8]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chanx_left_out[7]));

	mux_2level_tapbuf_size2 mux_left_track_17 (
		.in({chany_top_in[8], chany_bottom_in[9]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chanx_left_out[8]));

	mux_2level_tapbuf_size2 mux_left_track_19 (
		.in({chany_top_in[6], chany_bottom_in[10]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chanx_left_out[9]));

	mux_2level_tapbuf_size2 mux_left_track_21 (
		.in({chany_top_in[5], chany_bottom_in[12]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chanx_left_out[10]));

	mux_2level_tapbuf_size2 mux_left_track_23 (
		.in({chany_top_in[4], chany_top_in[13]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chanx_left_out[11]));

	mux_2level_tapbuf_size2 mux_left_track_25 (
		.in({chany_top_in[2], chany_top_in[11]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(chanx_left_out[12]));

	mux_2level_tapbuf_size2 mux_left_track_27 (
		.in({chany_top_in[1], chany_top_in[7]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(chanx_left_out[13]));

	mux_2level_tapbuf_size2_mem mem_left_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size3_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_11 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_15 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_19 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_21 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_23 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_25 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_27 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_2__1_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_2__1_.v =====

// ===== BEGIN SRC\routing\sb_2__2_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Switch Blocks[2][2]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for sb_2__2_ -----
module sb_2__2_(pReset,
                prog_clk,
                chany_bottom_in,
                bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_,
                bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_,
                bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_,
                chanx_left_in,
                left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_,
                left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_,
                left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_,
                ccff_head,
                chany_bottom_out,
                chanx_left_out,
                ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_;
//----- INPUT PORTS -----
input [0:0] bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_;
//----- INPUT PORTS -----
input [0:0] left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_10_sram;
wire [0:1] mux_2level_tapbuf_size2_10_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_11_sram;
wire [0:1] mux_2level_tapbuf_size2_11_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_12_sram;
wire [0:1] mux_2level_tapbuf_size2_12_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_13_sram;
wire [0:1] mux_2level_tapbuf_size2_13_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_14_sram;
wire [0:1] mux_2level_tapbuf_size2_14_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_15_sram;
wire [0:1] mux_2level_tapbuf_size2_15_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_16_sram;
wire [0:1] mux_2level_tapbuf_size2_16_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_17_sram;
wire [0:1] mux_2level_tapbuf_size2_17_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_18_sram;
wire [0:1] mux_2level_tapbuf_size2_18_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_19_sram;
wire [0:1] mux_2level_tapbuf_size2_19_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_20_sram;
wire [0:1] mux_2level_tapbuf_size2_20_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_21_sram;
wire [0:1] mux_2level_tapbuf_size2_21_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_22_sram;
wire [0:1] mux_2level_tapbuf_size2_22_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_23_sram;
wire [0:1] mux_2level_tapbuf_size2_23_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_10_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_11_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_12_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_13_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_14_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_15_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_16_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_17_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_18_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_19_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_20_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_21_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_22_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[12] = chany_bottom_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[13] = chany_bottom_in[12];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[13] = chanx_left_in[0];
// ----- Local connection due to Wire 39 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[12] = chanx_left_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_bottom_track_1 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_, chanx_left_in[1]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(chany_bottom_out[0]));

	mux_2level_tapbuf_size2 mux_bottom_track_3 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_, chanx_left_in[2]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(chany_bottom_out[1]));

	mux_2level_tapbuf_size2 mux_bottom_track_5 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_, chanx_left_in[3]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(chany_bottom_out[2]));

	mux_2level_tapbuf_size2 mux_bottom_track_7 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_, chanx_left_in[4]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(chany_bottom_out[3]));

	mux_2level_tapbuf_size2 mux_bottom_track_9 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_, chanx_left_in[5]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(chany_bottom_out[4]));

	mux_2level_tapbuf_size2 mux_bottom_track_11 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_, chanx_left_in[6]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(chany_bottom_out[5]));

	mux_2level_tapbuf_size2 mux_bottom_track_13 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_, chanx_left_in[7]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(chany_bottom_out[6]));

	mux_2level_tapbuf_size2 mux_bottom_track_15 (
		.in({bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_, chanx_left_in[8]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(chany_bottom_out[7]));

	mux_2level_tapbuf_size2 mux_bottom_track_17 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_, chanx_left_in[9]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(chany_bottom_out[8]));

	mux_2level_tapbuf_size2 mux_bottom_track_19 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_, chanx_left_in[10]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(chany_bottom_out[9]));

	mux_2level_tapbuf_size2 mux_bottom_track_21 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_, chanx_left_in[11]}),
		.sram(mux_2level_tapbuf_size2_10_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_10_sram_inv[0:1]),
		.out(chany_bottom_out[10]));

	mux_2level_tapbuf_size2 mux_bottom_track_23 (
		.in({bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_, chanx_left_in[12]}),
		.sram(mux_2level_tapbuf_size2_11_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_11_sram_inv[0:1]),
		.out(chany_bottom_out[11]));

	mux_2level_tapbuf_size2 mux_left_track_1 (
		.in({chany_bottom_in[13], left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_12_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_12_sram_inv[0:1]),
		.out(chanx_left_out[0]));

	mux_2level_tapbuf_size2 mux_left_track_3 (
		.in({chany_bottom_in[0], left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_13_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_13_sram_inv[0:1]),
		.out(chanx_left_out[1]));

	mux_2level_tapbuf_size2 mux_left_track_5 (
		.in({chany_bottom_in[1], left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_14_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_14_sram_inv[0:1]),
		.out(chanx_left_out[2]));

	mux_2level_tapbuf_size2 mux_left_track_7 (
		.in({chany_bottom_in[2], left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_15_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_15_sram_inv[0:1]),
		.out(chanx_left_out[3]));

	mux_2level_tapbuf_size2 mux_left_track_9 (
		.in({chany_bottom_in[3], left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_16_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_16_sram_inv[0:1]),
		.out(chanx_left_out[4]));

	mux_2level_tapbuf_size2 mux_left_track_11 (
		.in({chany_bottom_in[4], left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_17_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_17_sram_inv[0:1]),
		.out(chanx_left_out[5]));

	mux_2level_tapbuf_size2 mux_left_track_13 (
		.in({chany_bottom_in[5], left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_18_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_18_sram_inv[0:1]),
		.out(chanx_left_out[6]));

	mux_2level_tapbuf_size2 mux_left_track_15 (
		.in({chany_bottom_in[6], left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_}),
		.sram(mux_2level_tapbuf_size2_19_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_19_sram_inv[0:1]),
		.out(chanx_left_out[7]));

	mux_2level_tapbuf_size2 mux_left_track_17 (
		.in({chany_bottom_in[7], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_}),
		.sram(mux_2level_tapbuf_size2_20_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_20_sram_inv[0:1]),
		.out(chanx_left_out[8]));

	mux_2level_tapbuf_size2 mux_left_track_19 (
		.in({chany_bottom_in[8], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_}),
		.sram(mux_2level_tapbuf_size2_21_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_21_sram_inv[0:1]),
		.out(chanx_left_out[9]));

	mux_2level_tapbuf_size2 mux_left_track_21 (
		.in({chany_bottom_in[9], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_}),
		.sram(mux_2level_tapbuf_size2_22_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_22_sram_inv[0:1]),
		.out(chanx_left_out[10]));

	mux_2level_tapbuf_size2 mux_left_track_23 (
		.in({chany_bottom_in[10], left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_}),
		.sram(mux_2level_tapbuf_size2_23_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_23_sram_inv[0:1]),
		.out(chanx_left_out[11]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_11 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_15 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_19 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_21 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_10_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_10_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_track_23 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_11_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_11_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_12_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_12_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_13_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_13_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_13_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_14_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_14_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_14_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_15_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_15_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_15_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_9 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_15_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_16_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_16_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_16_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_11 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_16_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_17_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_17_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_17_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_13 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_17_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_18_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_18_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_18_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_15 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_18_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_19_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_19_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_19_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_17 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_19_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_20_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_20_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_20_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_19 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_20_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_21_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_21_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_21_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_21 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_21_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_22_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_22_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_22_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_track_23 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_22_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_23_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_23_sram_inv[0:1]));

endmodule
// ----- END Verilog module for sb_2__2_ -----

//----- Default net type -----
`default_nettype wire




// ===== END sb_2__2_.v =====

// ===== BEGIN SRC\routing\cbx_1__0_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Connection Blocks[1][0]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for cbx_1__0_ -----
module cbx_1__0_(pReset,
                 prog_clk,
                 chanx_left_in,
                 chanx_right_in,
                 ccff_head,
                 chanx_left_out,
                 chanx_right_out,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_,
                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[0] = chanx_left_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[1] = chanx_left_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[2] = chanx_left_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[3] = chanx_left_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[4] = chanx_left_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[5] = chanx_left_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[6] = chanx_left_in[6];
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[7] = chanx_left_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[8] = chanx_left_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[9] = chanx_left_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[10] = chanx_left_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[11] = chanx_left_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[12] = chanx_left_in[12];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[13] = chanx_left_in[13];
// ----- Local connection due to Wire 14 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[0] = chanx_right_in[0];
// ----- Local connection due to Wire 15 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[1] = chanx_right_in[1];
// ----- Local connection due to Wire 16 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[2] = chanx_right_in[2];
// ----- Local connection due to Wire 17 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[3] = chanx_right_in[3];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[4] = chanx_right_in[4];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[5] = chanx_right_in[5];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[6] = chanx_right_in[6];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[7] = chanx_right_in[7];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[8] = chanx_right_in[8];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[9] = chanx_right_in[9];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[10] = chanx_right_in[10];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[11] = chanx_right_in[11];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[12] = chanx_right_in[12];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[13] = chanx_right_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_top_ipin_0 (
		.in({chanx_left_in[0], chanx_right_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_1 (
		.in({chanx_left_in[1], chanx_right_in[1]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_2 (
		.in({chanx_left_in[2], chanx_right_in[2]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_3 (
		.in({chanx_left_in[3], chanx_right_in[3]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_4 (
		.in({chanx_left_in[4], chanx_right_in[4]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_5 (
		.in({chanx_left_in[5], chanx_right_in[5]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_6 (
		.in({chanx_left_in[6], chanx_right_in[6]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_7 (
		.in({chanx_left_in[7], chanx_right_in[7]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_));

	mux_2level_tapbuf_size2_mem mem_top_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

endmodule
// ----- END Verilog module for cbx_1__0_ -----

//----- Default net type -----
`default_nettype wire





// ===== END cbx_1__0_.v =====

// ===== BEGIN SRC\routing\cbx_1__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Connection Blocks[1][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for cbx_1__1_ -----
module cbx_1__1_(pReset,
                 prog_clk,
                 chanx_left_in,
                 chanx_right_in,
                 ccff_head,
                 chanx_left_out,
                 chanx_right_out,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_,
                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[0] = chanx_left_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[1] = chanx_left_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[2] = chanx_left_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[3] = chanx_left_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[4] = chanx_left_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[5] = chanx_left_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[6] = chanx_left_in[6];
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[7] = chanx_left_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[8] = chanx_left_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[9] = chanx_left_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[10] = chanx_left_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[11] = chanx_left_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[12] = chanx_left_in[12];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[13] = chanx_left_in[13];
// ----- Local connection due to Wire 14 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[0] = chanx_right_in[0];
// ----- Local connection due to Wire 15 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[1] = chanx_right_in[1];
// ----- Local connection due to Wire 16 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[2] = chanx_right_in[2];
// ----- Local connection due to Wire 17 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[3] = chanx_right_in[3];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[4] = chanx_right_in[4];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[5] = chanx_right_in[5];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[6] = chanx_right_in[6];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[7] = chanx_right_in[7];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[8] = chanx_right_in[8];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[9] = chanx_right_in[9];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[10] = chanx_right_in[10];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[11] = chanx_right_in[11];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[12] = chanx_right_in[12];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[13] = chanx_right_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_top_ipin_0 (
		.in({chanx_left_in[0], chanx_right_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_));

	mux_2level_tapbuf_size2 mux_top_ipin_1 (
		.in({chanx_left_in[1], chanx_right_in[1]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_));

	mux_2level_tapbuf_size2 mux_top_ipin_2 (
		.in({chanx_left_in[2], chanx_right_in[2]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_));

	mux_2level_tapbuf_size2 mux_top_ipin_3 (
		.in({chanx_left_in[3], chanx_right_in[3]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_));

	mux_2level_tapbuf_size2 mux_top_ipin_4 (
		.in({chanx_left_in[4], chanx_right_in[4]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_));

	mux_2level_tapbuf_size2 mux_top_ipin_5 (
		.in({chanx_left_in[5], chanx_right_in[5]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_));

	mux_2level_tapbuf_size2_mem mem_top_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

endmodule
// ----- END Verilog module for cbx_1__1_ -----

//----- Default net type -----
`default_nettype wire





// ===== END cbx_1__1_.v =====

// ===== BEGIN SRC\routing\cbx_1__2_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Connection Blocks[1][2]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for cbx_1__2_ -----
module cbx_1__2_(pReset,
                 prog_clk,
                 chanx_left_in,
                 chanx_right_in,
                 ccff_head,
                 chanx_left_out,
                 chanx_right_out,
                 top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_,
                 top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_,
                 bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_,
                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chanx_left_in;
//----- INPUT PORTS -----
input [0:13] chanx_right_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chanx_left_out;
//----- OUTPUT PORTS -----
output [0:13] chanx_right_out;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_;
//----- OUTPUT PORTS -----
output [0:0] bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_10_sram;
wire [0:1] mux_2level_tapbuf_size2_10_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_11_sram;
wire [0:1] mux_2level_tapbuf_size2_11_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_12_sram;
wire [0:1] mux_2level_tapbuf_size2_12_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_13_sram;
wire [0:1] mux_2level_tapbuf_size2_13_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_10_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_11_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_12_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[0] = chanx_left_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[1] = chanx_left_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[2] = chanx_left_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[3] = chanx_left_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[4] = chanx_left_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[5] = chanx_left_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[6] = chanx_left_in[6];
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[7] = chanx_left_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[8] = chanx_left_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[9] = chanx_left_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[10] = chanx_left_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[11] = chanx_left_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[12] = chanx_left_in[12];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_right_out[13] = chanx_left_in[13];
// ----- Local connection due to Wire 14 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[0] = chanx_right_in[0];
// ----- Local connection due to Wire 15 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[1] = chanx_right_in[1];
// ----- Local connection due to Wire 16 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[2] = chanx_right_in[2];
// ----- Local connection due to Wire 17 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[3] = chanx_right_in[3];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[4] = chanx_right_in[4];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[5] = chanx_right_in[5];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[6] = chanx_right_in[6];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[7] = chanx_right_in[7];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[8] = chanx_right_in[8];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[9] = chanx_right_in[9];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[10] = chanx_right_in[10];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[11] = chanx_right_in[11];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[12] = chanx_right_in[12];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chanx_left_out[13] = chanx_right_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_bottom_ipin_0 (
		.in({chanx_left_in[0], chanx_right_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_1 (
		.in({chanx_left_in[1], chanx_right_in[1]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_2 (
		.in({chanx_left_in[2], chanx_right_in[2]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_3 (
		.in({chanx_left_in[3], chanx_right_in[3]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_4 (
		.in({chanx_left_in[4], chanx_right_in[4]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_5 (
		.in({chanx_left_in[5], chanx_right_in[5]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_6 (
		.in({chanx_left_in[6], chanx_right_in[6]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_bottom_ipin_7 (
		.in({chanx_left_in[7], chanx_right_in[7]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_top_ipin_0 (
		.in({chanx_left_in[8], chanx_right_in[8]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_));

	mux_2level_tapbuf_size2 mux_top_ipin_1 (
		.in({chanx_left_in[9], chanx_right_in[9]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_));

	mux_2level_tapbuf_size2 mux_top_ipin_2 (
		.in({chanx_left_in[10], chanx_right_in[10]}),
		.sram(mux_2level_tapbuf_size2_10_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_10_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_));

	mux_2level_tapbuf_size2 mux_top_ipin_3 (
		.in({chanx_left_in[11], chanx_right_in[11]}),
		.sram(mux_2level_tapbuf_size2_11_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_11_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_));

	mux_2level_tapbuf_size2 mux_top_ipin_4 (
		.in({chanx_left_in[12], chanx_right_in[12]}),
		.sram(mux_2level_tapbuf_size2_12_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_12_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_));

	mux_2level_tapbuf_size2 mux_top_ipin_5 (
		.in({chanx_left_in[13], chanx_right_in[13]}),
		.sram(mux_2level_tapbuf_size2_13_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_13_sram_inv[0:1]),
		.out(bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_bottom_ipin_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_10_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_10_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_11_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_11_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_12_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_12_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_top_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_13_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_13_sram_inv[0:1]));

endmodule
// ----- END Verilog module for cbx_1__2_ -----

//----- Default net type -----
`default_nettype wire





// ===== END cbx_1__2_.v =====

// ===== BEGIN SRC\routing\cby_0__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Connection Blocks[0][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for cby_0__1_ -----
module cby_0__1_(pReset,
                 prog_clk,
                 chany_bottom_in,
                 chany_top_in,
                 ccff_head,
                 chany_bottom_out,
                 chany_top_out,
                 left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_,
                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[0] = chany_bottom_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[1] = chany_bottom_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[2] = chany_bottom_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[3] = chany_bottom_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[4] = chany_bottom_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[5] = chany_bottom_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[6] = chany_bottom_in[6];
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[7] = chany_bottom_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[8] = chany_bottom_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chany_bottom_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chany_bottom_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chany_bottom_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[12] = chany_bottom_in[12];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chany_bottom_in[13];
// ----- Local connection due to Wire 14 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[0] = chany_top_in[0];
// ----- Local connection due to Wire 15 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[1] = chany_top_in[1];
// ----- Local connection due to Wire 16 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[2] = chany_top_in[2];
// ----- Local connection due to Wire 17 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[3] = chany_top_in[3];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[4] = chany_top_in[4];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[5] = chany_top_in[5];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[6] = chany_top_in[6];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[7] = chany_top_in[7];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[8] = chany_top_in[8];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[9] = chany_top_in[9];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[10] = chany_top_in[10];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[11] = chany_top_in[11];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[12] = chany_top_in[12];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[13] = chany_top_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_right_ipin_0 (
		.in({chany_bottom_in[0], chany_top_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_1 (
		.in({chany_bottom_in[1], chany_top_in[1]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_2 (
		.in({chany_bottom_in[2], chany_top_in[2]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_3 (
		.in({chany_bottom_in[3], chany_top_in[3]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_4 (
		.in({chany_bottom_in[4], chany_top_in[4]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_5 (
		.in({chany_bottom_in[5], chany_top_in[5]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_6 (
		.in({chany_bottom_in[6], chany_top_in[6]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_7 (
		.in({chany_bottom_in[7], chany_top_in[7]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_));

	mux_2level_tapbuf_size2_mem mem_right_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

endmodule
// ----- END Verilog module for cby_0__1_ -----

//----- Default net type -----
`default_nettype wire





// ===== END cby_0__1_.v =====

// ===== BEGIN SRC\routing\cby_1__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Connection Blocks[1][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for cby_1__1_ -----
module cby_1__1_(pReset,
                 prog_clk,
                 chany_bottom_in,
                 chany_top_in,
                 ccff_head,
                 chany_bottom_out,
                 chany_top_out,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_0_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_1_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_2_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_3_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_4_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_5_,
                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_1_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_2_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_3_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_4_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_5_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[0] = chany_bottom_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[1] = chany_bottom_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[2] = chany_bottom_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[3] = chany_bottom_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[4] = chany_bottom_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[5] = chany_bottom_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[6] = chany_bottom_in[6];
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[7] = chany_bottom_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[8] = chany_bottom_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chany_bottom_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chany_bottom_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chany_bottom_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[12] = chany_bottom_in[12];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chany_bottom_in[13];
// ----- Local connection due to Wire 14 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[0] = chany_top_in[0];
// ----- Local connection due to Wire 15 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[1] = chany_top_in[1];
// ----- Local connection due to Wire 16 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[2] = chany_top_in[2];
// ----- Local connection due to Wire 17 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[3] = chany_top_in[3];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[4] = chany_top_in[4];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[5] = chany_top_in[5];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[6] = chany_top_in[6];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[7] = chany_top_in[7];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[8] = chany_top_in[8];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[9] = chany_top_in[9];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[10] = chany_top_in[10];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[11] = chany_top_in[11];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[12] = chany_top_in[12];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[13] = chany_top_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_right_ipin_0 (
		.in({chany_bottom_in[0], chany_top_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_1 (
		.in({chany_bottom_in[1], chany_top_in[1]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_1_));

	mux_2level_tapbuf_size2 mux_right_ipin_2 (
		.in({chany_bottom_in[2], chany_top_in[2]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_2_));

	mux_2level_tapbuf_size2 mux_right_ipin_3 (
		.in({chany_bottom_in[3], chany_top_in[3]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_3_));

	mux_2level_tapbuf_size2 mux_right_ipin_4 (
		.in({chany_bottom_in[4], chany_top_in[4]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_4_));

	mux_2level_tapbuf_size2 mux_right_ipin_5 (
		.in({chany_bottom_in[5], chany_top_in[5]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_5_));

	mux_2level_tapbuf_size2_mem mem_right_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

endmodule
// ----- END Verilog module for cby_1__1_ -----

//----- Default net type -----
`default_nettype wire





// ===== END cby_1__1_.v =====

// ===== BEGIN SRC\routing\cby_2__1_.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Verilog modules for Unique Connection Blocks[2][1]
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for cby_2__1_ -----
module cby_2__1_(pReset,
                 prog_clk,
                 chany_bottom_in,
                 chany_top_in,
                 ccff_head,
                 chany_bottom_out,
                 chany_top_out,
                 right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_,
                 right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_0_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_1_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_2_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_3_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_4_,
                 left_grid_right_width_0_height_0_subtile_0__pin_I_5_,
                 ccff_tail);
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- INPUT PORTS -----
input [0:13] chany_bottom_in;
//----- INPUT PORTS -----
input [0:13] chany_top_in;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:13] chany_bottom_out;
//----- OUTPUT PORTS -----
output [0:13] chany_top_out;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_0_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_1_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_2_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_3_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_4_;
//----- OUTPUT PORTS -----
output [0:0] left_grid_right_width_0_height_0_subtile_0__pin_I_5_;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:1] mux_2level_tapbuf_size2_0_sram;
wire [0:1] mux_2level_tapbuf_size2_0_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_10_sram;
wire [0:1] mux_2level_tapbuf_size2_10_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_11_sram;
wire [0:1] mux_2level_tapbuf_size2_11_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_12_sram;
wire [0:1] mux_2level_tapbuf_size2_12_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_13_sram;
wire [0:1] mux_2level_tapbuf_size2_13_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_1_sram;
wire [0:1] mux_2level_tapbuf_size2_1_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_2_sram;
wire [0:1] mux_2level_tapbuf_size2_2_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_3_sram;
wire [0:1] mux_2level_tapbuf_size2_3_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_4_sram;
wire [0:1] mux_2level_tapbuf_size2_4_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_5_sram;
wire [0:1] mux_2level_tapbuf_size2_5_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_6_sram;
wire [0:1] mux_2level_tapbuf_size2_6_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_7_sram;
wire [0:1] mux_2level_tapbuf_size2_7_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_8_sram;
wire [0:1] mux_2level_tapbuf_size2_8_sram_inv;
wire [0:1] mux_2level_tapbuf_size2_9_sram;
wire [0:1] mux_2level_tapbuf_size2_9_sram_inv;
wire [0:0] mux_2level_tapbuf_size2_mem_0_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_10_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_11_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_12_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_1_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_2_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_3_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_4_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_5_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_6_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_7_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_8_ccff_tail;
wire [0:0] mux_2level_tapbuf_size2_mem_9_ccff_tail;

// ----- BEGIN Local short connections -----
// ----- Local connection due to Wire 0 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[0] = chany_bottom_in[0];
// ----- Local connection due to Wire 1 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[1] = chany_bottom_in[1];
// ----- Local connection due to Wire 2 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[2] = chany_bottom_in[2];
// ----- Local connection due to Wire 3 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[3] = chany_bottom_in[3];
// ----- Local connection due to Wire 4 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[4] = chany_bottom_in[4];
// ----- Local connection due to Wire 5 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[5] = chany_bottom_in[5];
// ----- Local connection due to Wire 6 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[6] = chany_bottom_in[6];
// ----- Local connection due to Wire 7 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[7] = chany_bottom_in[7];
// ----- Local connection due to Wire 8 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[8] = chany_bottom_in[8];
// ----- Local connection due to Wire 9 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[9] = chany_bottom_in[9];
// ----- Local connection due to Wire 10 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[10] = chany_bottom_in[10];
// ----- Local connection due to Wire 11 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[11] = chany_bottom_in[11];
// ----- Local connection due to Wire 12 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[12] = chany_bottom_in[12];
// ----- Local connection due to Wire 13 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_top_out[13] = chany_bottom_in[13];
// ----- Local connection due to Wire 14 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[0] = chany_top_in[0];
// ----- Local connection due to Wire 15 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[1] = chany_top_in[1];
// ----- Local connection due to Wire 16 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[2] = chany_top_in[2];
// ----- Local connection due to Wire 17 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[3] = chany_top_in[3];
// ----- Local connection due to Wire 18 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[4] = chany_top_in[4];
// ----- Local connection due to Wire 19 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[5] = chany_top_in[5];
// ----- Local connection due to Wire 20 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[6] = chany_top_in[6];
// ----- Local connection due to Wire 21 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[7] = chany_top_in[7];
// ----- Local connection due to Wire 22 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[8] = chany_top_in[8];
// ----- Local connection due to Wire 23 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[9] = chany_top_in[9];
// ----- Local connection due to Wire 24 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[10] = chany_top_in[10];
// ----- Local connection due to Wire 25 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[11] = chany_top_in[11];
// ----- Local connection due to Wire 26 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[12] = chany_top_in[12];
// ----- Local connection due to Wire 27 -----
// ----- Net source id 0 -----
// ----- Net sink id 0 -----
	assign chany_bottom_out[13] = chany_top_in[13];
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	mux_2level_tapbuf_size2 mux_left_ipin_0 (
		.in({chany_bottom_in[0], chany_top_in[0]}),
		.sram(mux_2level_tapbuf_size2_0_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_0_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_1 (
		.in({chany_bottom_in[1], chany_top_in[1]}),
		.sram(mux_2level_tapbuf_size2_1_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_1_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_2 (
		.in({chany_bottom_in[2], chany_top_in[2]}),
		.sram(mux_2level_tapbuf_size2_2_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_2_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_3 (
		.in({chany_bottom_in[3], chany_top_in[3]}),
		.sram(mux_2level_tapbuf_size2_3_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_3_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_4 (
		.in({chany_bottom_in[4], chany_top_in[4]}),
		.sram(mux_2level_tapbuf_size2_4_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_4_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_5 (
		.in({chany_bottom_in[5], chany_top_in[5]}),
		.sram(mux_2level_tapbuf_size2_5_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_5_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_6 (
		.in({chany_bottom_in[6], chany_top_in[6]}),
		.sram(mux_2level_tapbuf_size2_6_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_6_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_left_ipin_7 (
		.in({chany_bottom_in[7], chany_top_in[7]}),
		.sram(mux_2level_tapbuf_size2_7_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_7_sram_inv[0:1]),
		.out(right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_0 (
		.in({chany_bottom_in[8], chany_top_in[8]}),
		.sram(mux_2level_tapbuf_size2_8_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_8_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_0_));

	mux_2level_tapbuf_size2 mux_right_ipin_1 (
		.in({chany_bottom_in[9], chany_top_in[9]}),
		.sram(mux_2level_tapbuf_size2_9_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_9_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_1_));

	mux_2level_tapbuf_size2 mux_right_ipin_2 (
		.in({chany_bottom_in[10], chany_top_in[10]}),
		.sram(mux_2level_tapbuf_size2_10_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_10_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_2_));

	mux_2level_tapbuf_size2 mux_right_ipin_3 (
		.in({chany_bottom_in[11], chany_top_in[11]}),
		.sram(mux_2level_tapbuf_size2_11_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_11_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_3_));

	mux_2level_tapbuf_size2 mux_right_ipin_4 (
		.in({chany_bottom_in[12], chany_top_in[12]}),
		.sram(mux_2level_tapbuf_size2_12_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_12_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_4_));

	mux_2level_tapbuf_size2 mux_right_ipin_5 (
		.in({chany_bottom_in[13], chany_top_in[13]}),
		.sram(mux_2level_tapbuf_size2_13_sram[0:1]),
		.sram_inv(mux_2level_tapbuf_size2_13_sram_inv[0:1]),
		.out(left_grid_right_width_0_height_0_subtile_0__pin_I_5_));

	mux_2level_tapbuf_size2_mem mem_left_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(ccff_head),
		.ccff_tail(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_0_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_0_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_0_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_1_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_1_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_1_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_2_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_2_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_2_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_3_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_3_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_3_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_4_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_4_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_4_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_5_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_5_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_6 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_5_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_6_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_6_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_left_ipin_7 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_6_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_7_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_7_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_0 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_7_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_8_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_8_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_1 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_8_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_9_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_9_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_2 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_9_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_10_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_10_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_3 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_10_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_11_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_11_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_4 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_11_ccff_tail),
		.ccff_tail(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_12_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_12_sram_inv[0:1]));

	mux_2level_tapbuf_size2_mem mem_right_ipin_5 (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.ccff_head(mux_2level_tapbuf_size2_mem_12_ccff_tail),
		.ccff_tail(ccff_tail),
		.mem_out(mux_2level_tapbuf_size2_13_sram[0:1]),
		.mem_outb(mux_2level_tapbuf_size2_13_sram_inv[0:1]));

endmodule
// ----- END Verilog module for cby_2__1_ -----

//----- Default net type -----
`default_nettype wire





// ===== END cby_2__1_.v =====

// ------ Include tile module netlists -----

// ------ Include fabric top-level netlists -----

// ===== BEGIN SRC\fpga_top.v =====
//-------------------------------------------
//	FPGA Synthesizable Verilog Netlist
//	Description: Top-level Verilog module for FPGA
//	Author: Xifan TANG
//	Organization: University of Utah
//	Date: Sat Apr 25 14:33:57 2026
//-------------------------------------------
//----- Default net type -----
`default_nettype wire

// ----- Verilog module for fpga_top -----
module fpga_top(op_clk,
                op_reset,
                pReset,
                prog_clk,
                gfpga_pad_GPIO_PAD,
                ccff_head,
                ccff_tail,
                fabric_led);
//----- GLOBAL PORTS -----
input [0:0] op_clk;
//----- GLOBAL PORTS -----
input [0:0] op_reset;
//----- GLOBAL PORTS -----
input [0:0] pReset;
//----- GLOBAL PORTS -----
input [0:0] prog_clk;
//----- GPIO PORTS -----
inout [0:63] gfpga_pad_GPIO_PAD;
//----- INPUT PORTS -----
input [0:0] ccff_head;
//----- OUTPUT PORTS -----
output [0:0] ccff_tail;
//----- BOARD-LEVEL DEBUG OUTPUTS -----
output [3:0] fabric_led;

//----- BEGIN wire-connection ports -----
//----- END wire-connection ports -----


//----- BEGIN Registered ports -----
//----- END Registered ports -----


wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cbx_1__0__0_ccff_tail;
wire [0:13] cbx_1__0__0_chanx_left_out;
wire [0:13] cbx_1__0__0_chanx_right_out;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cbx_1__0__1_ccff_tail;
wire [0:13] cbx_1__0__1_chanx_left_out;
wire [0:13] cbx_1__0__1_chanx_right_out;
wire [0:0] cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_;
wire [0:0] cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_;
wire [0:0] cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_;
wire [0:0] cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_;
wire [0:0] cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_;
wire [0:0] cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_;
wire [0:0] cbx_1__1__0_ccff_tail;
wire [0:13] cbx_1__1__0_chanx_left_out;
wire [0:13] cbx_1__1__0_chanx_right_out;
wire [0:0] cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_;
wire [0:0] cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_;
wire [0:0] cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_;
wire [0:0] cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_;
wire [0:0] cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_;
wire [0:0] cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_;
wire [0:0] cbx_1__1__1_ccff_tail;
wire [0:13] cbx_1__1__1_chanx_left_out;
wire [0:13] cbx_1__1__1_chanx_right_out;
wire [0:0] cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_;
wire [0:0] cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_;
wire [0:0] cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_;
wire [0:0] cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_;
wire [0:0] cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_;
wire [0:0] cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_;
wire [0:0] cbx_1__2__0_ccff_tail;
wire [0:13] cbx_1__2__0_chanx_left_out;
wire [0:13] cbx_1__2__0_chanx_right_out;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_;
wire [0:0] cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_;
wire [0:0] cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_;
wire [0:0] cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_;
wire [0:0] cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_;
wire [0:0] cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_;
wire [0:0] cbx_1__2__1_ccff_tail;
wire [0:13] cbx_1__2__1_chanx_left_out;
wire [0:13] cbx_1__2__1_chanx_right_out;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cby_0__1__0_ccff_tail;
wire [0:13] cby_0__1__0_chany_bottom_out;
wire [0:13] cby_0__1__0_chany_top_out;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cby_0__1__0_left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cby_0__1__1_ccff_tail;
wire [0:13] cby_0__1__1_chany_bottom_out;
wire [0:13] cby_0__1__1_chany_top_out;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cby_0__1__1_left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cby_1__1__0_ccff_tail;
wire [0:13] cby_1__1__0_chany_bottom_out;
wire [0:13] cby_1__1__0_chany_top_out;
wire [0:0] cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_0_;
wire [0:0] cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_1_;
wire [0:0] cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_2_;
wire [0:0] cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_3_;
wire [0:0] cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_4_;
wire [0:0] cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_5_;
wire [0:0] cby_1__1__1_ccff_tail;
wire [0:13] cby_1__1__1_chany_bottom_out;
wire [0:13] cby_1__1__1_chany_top_out;
wire [0:0] cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_0_;
wire [0:0] cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_1_;
wire [0:0] cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_2_;
wire [0:0] cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_3_;
wire [0:0] cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_4_;
wire [0:0] cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_5_;
wire [0:0] cby_2__1__0_ccff_tail;
wire [0:13] cby_2__1__0_chany_bottom_out;
wire [0:13] cby_2__1__0_chany_top_out;
wire [0:0] cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_0_;
wire [0:0] cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_1_;
wire [0:0] cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_2_;
wire [0:0] cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_3_;
wire [0:0] cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_4_;
wire [0:0] cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_5_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cby_2__1__0_right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] cby_2__1__1_ccff_tail;
wire [0:13] cby_2__1__1_chany_bottom_out;
wire [0:13] cby_2__1__1_chany_top_out;
wire [0:0] cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_0_;
wire [0:0] cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_1_;
wire [0:0] cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_2_;
wire [0:0] cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_3_;
wire [0:0] cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_4_;
wire [0:0] cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_5_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_;
wire [0:0] cby_2__1__1_right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_;
wire [0:0] grid_clb_0_ccff_tail;
wire [0:0] grid_clb_0_right_width_0_height_0_subtile_0__pin_O_0_;
wire [0:0] grid_clb_0_right_width_0_height_0_subtile_0__pin_O_1_;
wire [0:0] grid_clb_0_right_width_0_height_0_subtile_0__pin_O_2_;
wire [0:0] grid_clb_0_right_width_0_height_0_subtile_0__pin_O_3_;
wire [0:0] grid_clb_0_top_width_0_height_0_subtile_0__pin_O_4_;
wire [0:0] grid_clb_0_top_width_0_height_0_subtile_0__pin_O_5_;
wire [0:0] grid_clb_0_top_width_0_height_0_subtile_0__pin_O_6_;
wire [0:0] grid_clb_0_top_width_0_height_0_subtile_0__pin_O_7_;
wire [0:0] grid_clb_1_right_width_0_height_0_subtile_0__pin_O_0_;
wire [0:0] grid_clb_1_right_width_0_height_0_subtile_0__pin_O_1_;
wire [0:0] grid_clb_1_right_width_0_height_0_subtile_0__pin_O_2_;
wire [0:0] grid_clb_1_right_width_0_height_0_subtile_0__pin_O_3_;
wire [0:0] grid_clb_1_top_width_0_height_0_subtile_0__pin_O_4_;
wire [0:0] grid_clb_1_top_width_0_height_0_subtile_0__pin_O_5_;
wire [0:0] grid_clb_1_top_width_0_height_0_subtile_0__pin_O_6_;
wire [0:0] grid_clb_1_top_width_0_height_0_subtile_0__pin_O_7_;
wire [0:0] grid_clb_2_ccff_tail;
wire [0:0] grid_clb_2_right_width_0_height_0_subtile_0__pin_O_0_;
wire [0:0] grid_clb_2_right_width_0_height_0_subtile_0__pin_O_1_;
wire [0:0] grid_clb_2_right_width_0_height_0_subtile_0__pin_O_2_;
wire [0:0] grid_clb_2_right_width_0_height_0_subtile_0__pin_O_3_;
wire [0:0] grid_clb_2_top_width_0_height_0_subtile_0__pin_O_4_;
wire [0:0] grid_clb_2_top_width_0_height_0_subtile_0__pin_O_5_;
wire [0:0] grid_clb_2_top_width_0_height_0_subtile_0__pin_O_6_;
wire [0:0] grid_clb_2_top_width_0_height_0_subtile_0__pin_O_7_;
wire [0:0] grid_clb_3_ccff_tail;
wire [0:0] grid_clb_3_right_width_0_height_0_subtile_0__pin_O_0_;
wire [0:0] grid_clb_3_right_width_0_height_0_subtile_0__pin_O_1_;
wire [0:0] grid_clb_3_right_width_0_height_0_subtile_0__pin_O_2_;
wire [0:0] grid_clb_3_right_width_0_height_0_subtile_0__pin_O_3_;
wire [0:0] grid_clb_3_top_width_0_height_0_subtile_0__pin_O_4_;
wire [0:0] grid_clb_3_top_width_0_height_0_subtile_0__pin_O_5_;
wire [0:0] grid_clb_3_top_width_0_height_0_subtile_0__pin_O_6_;
wire [0:0] grid_clb_3_top_width_0_height_0_subtile_0__pin_O_7_;
wire [0:0] grid_io_bottom_0_ccff_tail;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_bottom_0_top_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_ccff_tail;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_bottom_1_top_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_left_0_ccff_tail;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_left_0_right_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_left_1_ccff_tail;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_left_1_right_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_right_0_ccff_tail;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_right_0_left_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_right_1_ccff_tail;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_right_1_left_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_top_0_bottom_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_top_0_ccff_tail;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_0__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_1__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_2__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_3__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_4__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_5__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_6__pin_inpad_0_;
wire [0:0] grid_io_top_1_bottom_width_0_height_0_subtile_7__pin_inpad_0_;
wire [0:0] grid_io_top_1_ccff_tail;
wire [0:0] sb_0__0__0_ccff_tail;
wire [0:13] sb_0__0__0_chanx_right_out;
wire [0:13] sb_0__0__0_chany_top_out;
wire [0:0] sb_0__1__0_ccff_tail;
wire [0:13] sb_0__1__0_chanx_right_out;
wire [0:13] sb_0__1__0_chany_bottom_out;
wire [0:13] sb_0__1__0_chany_top_out;
wire [0:0] sb_0__2__0_ccff_tail;
wire [0:13] sb_0__2__0_chanx_right_out;
wire [0:13] sb_0__2__0_chany_bottom_out;
wire [0:0] sb_1__0__0_ccff_tail;
wire [0:13] sb_1__0__0_chanx_left_out;
wire [0:13] sb_1__0__0_chanx_right_out;
wire [0:13] sb_1__0__0_chany_top_out;
wire [0:0] sb_1__1__0_ccff_tail;
wire [0:13] sb_1__1__0_chanx_left_out;
wire [0:13] sb_1__1__0_chanx_right_out;
wire [0:13] sb_1__1__0_chany_bottom_out;
wire [0:13] sb_1__1__0_chany_top_out;
wire [0:0] sb_1__2__0_ccff_tail;
wire [0:13] sb_1__2__0_chanx_left_out;
wire [0:13] sb_1__2__0_chanx_right_out;
wire [0:13] sb_1__2__0_chany_bottom_out;
wire [0:0] sb_2__0__0_ccff_tail;
wire [0:13] sb_2__0__0_chanx_left_out;
wire [0:13] sb_2__0__0_chany_top_out;
wire [0:0] sb_2__1__0_ccff_tail;
wire [0:13] sb_2__1__0_chanx_left_out;
wire [0:13] sb_2__1__0_chany_bottom_out;
wire [0:13] sb_2__1__0_chany_top_out;
wire [0:0] sb_2__2__0_ccff_tail;
wire [0:13] sb_2__2__0_chanx_left_out;
wire [0:13] sb_2__2__0_chany_bottom_out;

// ----- BEGIN Local short connections -----
// ----- END Local short connections -----
// ----- BEGIN Local output short connections -----
// ----- END Local output short connections -----

	grid_io_top grid_io_top_1__3_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[0:7]),
		.bottom_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(grid_io_top_1_ccff_tail),
		.bottom_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_top_0_ccff_tail));

	grid_io_top grid_io_top_2__3_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[8:15]),
		.bottom_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_),
		.bottom_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(grid_io_right_0_ccff_tail),
		.bottom_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.bottom_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_top_1_ccff_tail));

	grid_io_right grid_io_right_3__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[16:23]),
		.left_width_0_height_0_subtile_0__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_),
		.left_width_0_height_0_subtile_1__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_),
		.left_width_0_height_0_subtile_2__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_),
		.left_width_0_height_0_subtile_3__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_),
		.left_width_0_height_0_subtile_4__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_),
		.left_width_0_height_0_subtile_5__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_),
		.left_width_0_height_0_subtile_6__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_),
		.left_width_0_height_0_subtile_7__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(grid_io_right_1_ccff_tail),
		.left_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_0__pin_inpad_0_),
		.left_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_1__pin_inpad_0_),
		.left_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_2__pin_inpad_0_),
		.left_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_3__pin_inpad_0_),
		.left_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_4__pin_inpad_0_),
		.left_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_5__pin_inpad_0_),
		.left_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_6__pin_inpad_0_),
		.left_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_right_0_ccff_tail));

	grid_io_right grid_io_right_3__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[24:31]),
		.left_width_0_height_0_subtile_0__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_),
		.left_width_0_height_0_subtile_1__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_),
		.left_width_0_height_0_subtile_2__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_),
		.left_width_0_height_0_subtile_3__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_),
		.left_width_0_height_0_subtile_4__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_),
		.left_width_0_height_0_subtile_5__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_),
		.left_width_0_height_0_subtile_6__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_),
		.left_width_0_height_0_subtile_7__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(grid_io_bottom_0_ccff_tail),
		.left_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_0__pin_inpad_0_),
		.left_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_1__pin_inpad_0_),
		.left_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_2__pin_inpad_0_),
		.left_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_3__pin_inpad_0_),
		.left_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_4__pin_inpad_0_),
		.left_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_5__pin_inpad_0_),
		.left_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_6__pin_inpad_0_),
		.left_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_right_1_ccff_tail));

	grid_io_bottom grid_io_bottom_2__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[32:39]),
		.top_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_),
		.top_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_),
		.top_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_),
		.top_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_),
		.top_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_),
		.top_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_),
		.top_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_),
		.top_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(cbx_1__0__1_ccff_tail),
		.top_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_0__pin_inpad_0_),
		.top_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_1__pin_inpad_0_),
		.top_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_2__pin_inpad_0_),
		.top_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_3__pin_inpad_0_),
		.top_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_4__pin_inpad_0_),
		.top_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_5__pin_inpad_0_),
		.top_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_6__pin_inpad_0_),
		.top_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_bottom_0_ccff_tail));

	grid_io_bottom grid_io_bottom_1__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[40:47]),
		.top_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_),
		.top_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_),
		.top_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_),
		.top_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_),
		.top_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_),
		.top_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_),
		.top_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_),
		.top_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(cbx_1__0__0_ccff_tail),
		.top_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_0__pin_inpad_0_),
		.top_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_1__pin_inpad_0_),
		.top_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_2__pin_inpad_0_),
		.top_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_3__pin_inpad_0_),
		.top_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_4__pin_inpad_0_),
		.top_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_5__pin_inpad_0_),
		.top_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_6__pin_inpad_0_),
		.top_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_bottom_1_ccff_tail));

	grid_io_left grid_io_left_0__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[48:55]),
		.right_width_0_height_0_subtile_0__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_),
		.right_width_0_height_0_subtile_1__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_),
		.right_width_0_height_0_subtile_2__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_),
		.right_width_0_height_0_subtile_3__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_),
		.right_width_0_height_0_subtile_4__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_),
		.right_width_0_height_0_subtile_5__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_),
		.right_width_0_height_0_subtile_6__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_),
		.right_width_0_height_0_subtile_7__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(cby_0__1__0_ccff_tail),
		.right_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_0__pin_inpad_0_),
		.right_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_1__pin_inpad_0_),
		.right_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_2__pin_inpad_0_),
		.right_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_3__pin_inpad_0_),
		.right_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_4__pin_inpad_0_),
		.right_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_5__pin_inpad_0_),
		.right_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_6__pin_inpad_0_),
		.right_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_left_0_ccff_tail));

	grid_io_left grid_io_left_0__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.gfpga_pad_GPIO_PAD(gfpga_pad_GPIO_PAD[56:63]),
		.right_width_0_height_0_subtile_0__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_),
		.right_width_0_height_0_subtile_1__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_),
		.right_width_0_height_0_subtile_2__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_),
		.right_width_0_height_0_subtile_3__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_),
		.right_width_0_height_0_subtile_4__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_),
		.right_width_0_height_0_subtile_5__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_),
		.right_width_0_height_0_subtile_6__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_),
		.right_width_0_height_0_subtile_7__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_head(cby_0__1__1_ccff_tail),
		.right_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_0__pin_inpad_0_),
		.right_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_1__pin_inpad_0_),
		.right_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_2__pin_inpad_0_),
		.right_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_3__pin_inpad_0_),
		.right_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_4__pin_inpad_0_),
		.right_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_5__pin_inpad_0_),
		.right_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_6__pin_inpad_0_),
		.right_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_tail(grid_io_left_1_ccff_tail));

	grid_clb grid_clb_1__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.right_width_0_height_0_subtile_0__pin_I_0_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.right_width_0_height_0_subtile_0__pin_I_1_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.right_width_0_height_0_subtile_0__pin_I_2_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.right_width_0_height_0_subtile_0__pin_I_3_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.right_width_0_height_0_subtile_0__pin_I_4_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.right_width_0_height_0_subtile_0__pin_I_5_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.right_width_0_height_0_subtile_0__pin_reset_0_(op_reset),
		.right_width_0_height_0_subtile_0__pin_clk_0_(op_clk),
		.ccff_head(cby_1__1__0_ccff_tail),
		.top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_4_),
		.top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_5_),
		.top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_6_),
		.top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_7_),
		.right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_0_),
		.right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_1_),
		.right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_2_),
		.right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_3_),
		.ccff_tail(grid_clb_0_ccff_tail));

	grid_clb grid_clb_1__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.right_width_0_height_0_subtile_0__pin_I_0_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.right_width_0_height_0_subtile_0__pin_I_1_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.right_width_0_height_0_subtile_0__pin_I_2_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.right_width_0_height_0_subtile_0__pin_I_3_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.right_width_0_height_0_subtile_0__pin_I_4_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.right_width_0_height_0_subtile_0__pin_I_5_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.right_width_0_height_0_subtile_0__pin_reset_0_(op_reset),
		.right_width_0_height_0_subtile_0__pin_clk_0_(op_clk),
		.ccff_head(cby_1__1__1_ccff_tail),
		.top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_4_),
		.top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_5_),
		.top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_6_),
		.top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_7_),
		.right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_0_),
		.right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_1_),
		.right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_2_),
		.right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_3_),
		.ccff_tail(ccff_tail));

	grid_clb grid_clb_2__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.right_width_0_height_0_subtile_0__pin_I_0_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.right_width_0_height_0_subtile_0__pin_I_1_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.right_width_0_height_0_subtile_0__pin_I_2_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.right_width_0_height_0_subtile_0__pin_I_3_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.right_width_0_height_0_subtile_0__pin_I_4_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.right_width_0_height_0_subtile_0__pin_I_5_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.right_width_0_height_0_subtile_0__pin_reset_0_(op_reset),
		.right_width_0_height_0_subtile_0__pin_clk_0_(op_clk),
		.ccff_head(cby_2__1__0_ccff_tail),
		.top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_4_),
		.top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_5_),
		.top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_6_),
		.top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_7_),
		.right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_0_),
		.right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_1_),
		.right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_2_),
		.right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_3_),
		.ccff_tail(grid_clb_2_ccff_tail));

	grid_clb grid_clb_2__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.right_width_0_height_0_subtile_0__pin_I_0_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.right_width_0_height_0_subtile_0__pin_I_1_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.right_width_0_height_0_subtile_0__pin_I_2_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.right_width_0_height_0_subtile_0__pin_I_3_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.right_width_0_height_0_subtile_0__pin_I_4_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.right_width_0_height_0_subtile_0__pin_I_5_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.right_width_0_height_0_subtile_0__pin_reset_0_(op_reset),
		.right_width_0_height_0_subtile_0__pin_clk_0_(op_clk),
		.ccff_head(cby_2__1__1_ccff_tail),
		.top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_4_),
		.top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_5_),
		.top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_6_),
		.top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_7_),
		.right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_0_),
		.right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_1_),
		.right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_2_),
		.right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_3_),
		.ccff_tail(grid_clb_3_ccff_tail));

	sb_0__0_ sb_0__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_top_in(cby_0__1__0_chany_bottom_out[0:13]),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_0__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_1__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_2__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_3__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_4__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_5__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_6__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_7__pin_inpad_0_),
		.chanx_right_in(cbx_1__0__0_chanx_left_out[0:13]),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_0__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_1__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_2__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_3__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_4__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_5__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_6__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_head(ccff_head),
		.chany_top_out(sb_0__0__0_chany_top_out[0:13]),
		.chanx_right_out(sb_0__0__0_chanx_right_out[0:13]),
		.ccff_tail(sb_0__0__0_ccff_tail));

	sb_0__1_ sb_0__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_top_in(cby_0__1__1_chany_bottom_out[0:13]),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_0__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_1__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_2__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_3__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_4__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_5__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_6__pin_inpad_0_),
		.top_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_7__pin_inpad_0_),
		.chanx_right_in(cbx_1__1__0_chanx_left_out[0:13]),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_4_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_5_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_6_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_7_),
		.chany_bottom_in(cby_0__1__0_chany_top_out[0:13]),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_0__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_1__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_2__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_3__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_4__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_5__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_6__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_left_0_right_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_head(grid_io_left_1_ccff_tail),
		.chany_top_out(sb_0__1__0_chany_top_out[0:13]),
		.chanx_right_out(sb_0__1__0_chanx_right_out[0:13]),
		.chany_bottom_out(sb_0__1__0_chany_bottom_out[0:13]),
		.ccff_tail(sb_0__1__0_ccff_tail));

	sb_0__2_ sb_0__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_right_in(cbx_1__2__0_chanx_left_out[0:13]),
		.right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_4_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_5_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_6_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_7_),
		.chany_bottom_in(cby_0__1__1_chany_top_out[0:13]),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_0__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_1__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_2__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_3__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_4__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_5__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_6__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_left_1_right_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_head(grid_io_top_0_ccff_tail),
		.chanx_right_out(sb_0__2__0_chanx_right_out[0:13]),
		.chany_bottom_out(sb_0__2__0_chany_bottom_out[0:13]),
		.ccff_tail(sb_0__2__0_ccff_tail));

	sb_1__0_ sb_1__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_top_in(cby_1__1__0_chany_bottom_out[0:13]),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_0_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_1_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_2_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_3_),
		.chanx_right_in(cbx_1__0__1_chanx_left_out[0:13]),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_0__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_1__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_2__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_3__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_4__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_5__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_6__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_7__pin_inpad_0_),
		.chanx_left_in(cbx_1__0__0_chanx_right_out[0:13]),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_0__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_1__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_2__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_3__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_4__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_5__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_6__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_bottom_1_top_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_head(sb_0__0__0_ccff_tail),
		.chany_top_out(sb_1__0__0_chany_top_out[0:13]),
		.chanx_right_out(sb_1__0__0_chanx_right_out[0:13]),
		.chanx_left_out(sb_1__0__0_chanx_left_out[0:13]),
		.ccff_tail(sb_1__0__0_ccff_tail));

	sb_1__1_ sb_1__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_top_in(cby_1__1__1_chany_bottom_out[0:13]),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_0_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_1_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_2_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_3_),
		.chanx_right_in(cbx_1__1__1_chanx_left_out[0:13]),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_4_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_5_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_6_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_7_),
		.chany_bottom_in(cby_1__1__0_chany_top_out[0:13]),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_1_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_2_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_0_right_width_0_height_0_subtile_0__pin_O_3_),
		.chanx_left_in(cbx_1__1__0_chanx_right_out[0:13]),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_4_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_5_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_6_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_0_top_width_0_height_0_subtile_0__pin_O_7_),
		.ccff_head(grid_io_left_0_ccff_tail),
		.chany_top_out(sb_1__1__0_chany_top_out[0:13]),
		.chanx_right_out(sb_1__1__0_chanx_right_out[0:13]),
		.chany_bottom_out(sb_1__1__0_chany_bottom_out[0:13]),
		.chanx_left_out(sb_1__1__0_chanx_left_out[0:13]),
		.ccff_tail(sb_1__1__0_ccff_tail));

	sb_1__2_ sb_1__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_right_in(cbx_1__2__1_chanx_left_out[0:13]),
		.right_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.right_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_4_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_5_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_6_),
		.right_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_7_),
		.chany_bottom_in(cby_1__1__1_chany_top_out[0:13]),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_1_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_2_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_1_right_width_0_height_0_subtile_0__pin_O_3_),
		.chanx_left_in(cbx_1__2__0_chanx_right_out[0:13]),
		.left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_top_0_bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_4_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_5_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_6_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_1_top_width_0_height_0_subtile_0__pin_O_7_),
		.ccff_head(grid_clb_3_ccff_tail),
		.chanx_right_out(sb_1__2__0_chanx_right_out[0:13]),
		.chany_bottom_out(sb_1__2__0_chany_bottom_out[0:13]),
		.chanx_left_out(sb_1__2__0_chanx_left_out[0:13]),
		.ccff_tail(sb_1__2__0_ccff_tail));

	sb_2__0_ sb_2__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_top_in(cby_2__1__0_chany_bottom_out[0:13]),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_0_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_1_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_2_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_3_),
		.top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_0__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_1__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_2__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_3__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_4__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_5__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_6__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_7__pin_inpad_0_),
		.chanx_left_in(cbx_1__0__1_chanx_right_out[0:13]),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_0__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_1__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_2__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_3__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_4__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_5__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_6__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_bottom_0_top_width_0_height_0_subtile_7__pin_inpad_0_),
		.ccff_head(grid_io_bottom_1_ccff_tail),
		.chany_top_out(sb_2__0__0_chany_top_out[0:13]),
		.chanx_left_out(sb_2__0__0_chanx_left_out[0:13]),
		.ccff_tail(sb_2__0__0_ccff_tail));

	sb_2__1_ sb_2__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_top_in(cby_2__1__1_chany_bottom_out[0:13]),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_0_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_1_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_2_),
		.top_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_3_),
		.top_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_0__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_1__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_2__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_3__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_4__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_5__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_6__pin_inpad_0_),
		.top_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_7__pin_inpad_0_),
		.chany_bottom_in(cby_2__1__0_chany_top_out[0:13]),
		.bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_0__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_1__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_2__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_3__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_4__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_5__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_6__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_right_1_left_width_0_height_0_subtile_7__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_1_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_2_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_2_right_width_0_height_0_subtile_0__pin_O_3_),
		.chanx_left_in(cbx_1__1__1_chanx_right_out[0:13]),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_4_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_5_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_6_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_2_top_width_0_height_0_subtile_0__pin_O_7_),
		.ccff_head(grid_clb_0_ccff_tail),
		.chany_top_out(sb_2__1__0_chany_top_out[0:13]),
		.chany_bottom_out(sb_2__1__0_chany_bottom_out[0:13]),
		.chanx_left_out(sb_2__1__0_chanx_left_out[0:13]),
		.ccff_tail(sb_2__1__0_ccff_tail));

	sb_2__2_ sb_2__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(cby_2__1__1_chany_top_out[0:13]),
		.bottom_right_grid_left_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_0__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_1__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_2__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_3__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_4__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_5__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_6__pin_inpad_0_),
		.bottom_right_grid_left_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_right_0_left_width_0_height_0_subtile_7__pin_inpad_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_0_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_0_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_1_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_1_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_2_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_2_),
		.bottom_left_grid_right_width_0_height_0_subtile_0__pin_O_3_(grid_clb_3_right_width_0_height_0_subtile_0__pin_O_3_),
		.chanx_left_in(cbx_1__2__1_chanx_right_out[0:13]),
		.left_top_grid_bottom_width_0_height_0_subtile_0__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_0__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_1__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_1__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_2__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_2__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_3__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_3__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_4__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_4__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_5__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_5__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_6__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_6__pin_inpad_0_),
		.left_top_grid_bottom_width_0_height_0_subtile_7__pin_inpad_0_(grid_io_top_1_bottom_width_0_height_0_subtile_7__pin_inpad_0_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_4_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_4_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_5_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_5_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_6_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_6_),
		.left_bottom_grid_top_width_0_height_0_subtile_0__pin_O_7_(grid_clb_3_top_width_0_height_0_subtile_0__pin_O_7_),
		.ccff_head(grid_clb_2_ccff_tail),
		.chany_bottom_out(sb_2__2__0_chany_bottom_out[0:13]),
		.chanx_left_out(sb_2__2__0_chanx_left_out[0:13]),
		.ccff_tail(sb_2__2__0_ccff_tail));

	cbx_1__0_ cbx_1__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_left_in(sb_0__0__0_chanx_right_out[0:13]),
		.chanx_right_in(sb_1__0__0_chanx_left_out[0:13]),
		.ccff_head(sb_1__0__0_ccff_tail),
		.chanx_left_out(cbx_1__0__0_chanx_left_out[0:13]),
		.chanx_right_out(cbx_1__0__0_chanx_right_out[0:13]),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__0__0_bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_tail(cbx_1__0__0_ccff_tail));

	cbx_1__0_ cbx_2__0_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_left_in(sb_1__0__0_chanx_right_out[0:13]),
		.chanx_right_in(sb_2__0__0_chanx_left_out[0:13]),
		.ccff_head(sb_2__0__0_ccff_tail),
		.chanx_left_out(cbx_1__0__1_chanx_left_out[0:13]),
		.chanx_right_out(cbx_1__0__1_chanx_right_out[0:13]),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_1__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_3__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_5__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_tail(cbx_1__0__1_ccff_tail));

	cbx_1__1_ cbx_1__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_left_in(sb_0__1__0_chanx_right_out[0:13]),
		.chanx_right_in(sb_1__1__0_chanx_left_out[0:13]),
		.ccff_head(sb_1__1__0_ccff_tail),
		.chanx_left_out(cbx_1__1__0_chanx_left_out[0:13]),
		.chanx_right_out(cbx_1__1__0_chanx_right_out[0:13]),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__1__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.ccff_tail(cbx_1__1__0_ccff_tail));

	cbx_1__1_ cbx_2__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_left_in(sb_1__1__0_chanx_right_out[0:13]),
		.chanx_right_in(sb_2__1__0_chanx_left_out[0:13]),
		.ccff_head(sb_2__1__0_ccff_tail),
		.chanx_left_out(cbx_1__1__1_chanx_left_out[0:13]),
		.chanx_right_out(cbx_1__1__1_chanx_right_out[0:13]),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__1__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.ccff_tail(cbx_1__1__1_ccff_tail));

	cbx_1__2_ cbx_1__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_left_in(sb_0__2__0_chanx_right_out[0:13]),
		.chanx_right_in(sb_1__2__0_chanx_left_out[0:13]),
		.ccff_head(sb_1__2__0_ccff_tail),
		.chanx_left_out(cbx_1__2__0_chanx_left_out[0:13]),
		.chanx_right_out(cbx_1__2__0_chanx_right_out[0:13]),
		.top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__2__0_top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__2__0_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.ccff_tail(cbx_1__2__0_ccff_tail));

	cbx_1__2_ cbx_2__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chanx_left_in(sb_1__2__0_chanx_right_out[0:13]),
		.chanx_right_in(sb_2__2__0_chanx_left_out[0:13]),
		.ccff_head(sb_2__2__0_ccff_tail),
		.chanx_left_out(cbx_1__2__1_chanx_left_out[0:13]),
		.chanx_right_out(cbx_1__2__1_chanx_right_out[0:13]),
		.top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_0__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_1__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_2__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_3__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_4__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_5__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_6__pin_outpad_0_),
		.top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_(cbx_1__2__1_top_grid_bottom_width_0_height_0_subtile_7__pin_outpad_0_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_6_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_7_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_8_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_9_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_10_),
		.bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_(cbx_1__2__1_bottom_grid_top_width_0_height_0_subtile_0__pin_I_11_),
		.ccff_tail(cbx_1__2__1_ccff_tail));

	cby_0__1_ cby_0__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(sb_0__0__0_chany_top_out[0:13]),
		.chany_top_in(sb_0__1__0_chany_bottom_out[0:13]),
		.ccff_head(sb_0__1__0_ccff_tail),
		.chany_bottom_out(cby_0__1__0_chany_bottom_out[0:13]),
		.chany_top_out(cby_0__1__0_chany_top_out[0:13]),
		.left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_(cby_0__1__0_left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_tail(cby_0__1__0_ccff_tail));

	cby_0__1_ cby_0__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(sb_0__1__0_chany_top_out[0:13]),
		.chany_top_in(sb_0__2__0_chany_bottom_out[0:13]),
		.ccff_head(sb_0__2__0_ccff_tail),
		.chany_bottom_out(cby_0__1__1_chany_bottom_out[0:13]),
		.chany_top_out(cby_0__1__1_chany_top_out[0:13]),
		.left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_0__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_1__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_2__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_3__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_4__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_5__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_6__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_(cby_0__1__1_left_grid_right_width_0_height_0_subtile_7__pin_outpad_0_),
		.ccff_tail(cby_0__1__1_ccff_tail));

	cby_1__1_ cby_1__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(sb_1__0__0_chany_top_out[0:13]),
		.chany_top_in(sb_1__1__0_chany_bottom_out[0:13]),
		.ccff_head(cbx_1__1__0_ccff_tail),
		.chany_bottom_out(cby_1__1__0_chany_bottom_out[0:13]),
		.chany_top_out(cby_1__1__0_chany_top_out[0:13]),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_0_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_1_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_2_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_3_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_4_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_5_(cby_1__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.ccff_tail(cby_1__1__0_ccff_tail));

	cby_1__1_ cby_1__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(sb_1__1__0_chany_top_out[0:13]),
		.chany_top_in(sb_1__2__0_chany_bottom_out[0:13]),
		.ccff_head(cbx_1__2__0_ccff_tail),
		.chany_bottom_out(cby_1__1__1_chany_bottom_out[0:13]),
		.chany_top_out(cby_1__1__1_chany_top_out[0:13]),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_0_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_1_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_2_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_3_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_4_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_5_(cby_1__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.ccff_tail(cby_1__1__1_ccff_tail));

	cby_2__1_ cby_2__1_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(sb_2__0__0_chany_top_out[0:13]),
		.chany_top_in(sb_2__1__0_chany_bottom_out[0:13]),
		.ccff_head(cbx_1__1__1_ccff_tail),
		.chany_bottom_out(cby_2__1__0_chany_bottom_out[0:13]),
		.chany_top_out(cby_2__1__0_chany_top_out[0:13]),
		.right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_(cby_2__1__0_right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_0_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_1_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_2_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_3_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_4_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_5_(cby_2__1__0_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.ccff_tail(cby_2__1__0_ccff_tail));

	cby_2__1_ cby_2__2_ (
		.pReset(pReset),
		.prog_clk(prog_clk),
		.chany_bottom_in(sb_2__1__0_chany_top_out[0:13]),
		.chany_top_in(sb_2__2__0_chany_bottom_out[0:13]),
		.ccff_head(cbx_1__2__1_ccff_tail),
		.chany_bottom_out(cby_2__1__1_chany_bottom_out[0:13]),
		.chany_top_out(cby_2__1__1_chany_top_out[0:13]),
		.right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_0__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_1__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_2__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_3__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_4__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_5__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_6__pin_outpad_0_),
		.right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_(cby_2__1__1_right_grid_left_width_0_height_0_subtile_7__pin_outpad_0_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_0_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_0_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_1_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_1_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_2_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_2_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_3_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_3_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_4_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_4_),
		.left_grid_right_width_0_height_0_subtile_0__pin_I_5_(cby_2__1__1_left_grid_right_width_0_height_0_subtile_0__pin_I_5_),
		.ccff_tail(cby_2__1__1_ccff_tail));


// ----- Direct board-level observation points for TD synthesis -----
assign fabric_led[0] = cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_6__pin_outpad_0_[0];
assign fabric_led[1] = cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_0__pin_outpad_0_[0];
assign fabric_led[2] = cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_2__pin_outpad_0_[0];
assign fabric_led[3] = cbx_1__0__1_bottom_grid_top_width_0_height_0_subtile_4__pin_outpad_0_[0];

endmodule
// ----- END Verilog module for fpga_top -----

//----- Default net type -----
`default_nettype wire





// ===== END fpga_top.v =====


// ===== END fabric_netlists_local.v =====

module anlogic_openfpga_wrapper(
    input  wire       CLOCK,
    output wire [3:0] LED
);

    localparam integer BITSTREAM_LENGTH = 1946;
    localparam [0:BITSTREAM_LENGTH-1] FABRIC_BITSTREAM = {
        64'b1000000000100000000010000000001000000000100000000010000000001000,
        64'b0000001000000000100000000010000000001000000000100000000010000000,
        64'b0010000000001000000000100000000010010000100000000000000000001001,
        64'b0000100000000000000000001001000010000000000000000000100100001000,
        64'b0000000000000000000000000000000000000000000000000000000000101010,
        64'b0010001001100000001000101000000000000000000001001010001010001001,
        64'b0010000010100000010000010001000010000100010010000000001000000000,
        64'b1000000000100000000010000000001000000000100000000010000000001000,
        64'b0000001000000000100000000010000000001000100000100000000111111110,
        64'b1001000010000000000000000000100100001000000000000000000010010000,
        64'b1000000000000000000010001100000000000000000000000000000011100000,
        64'b0000000000001100111100111111110011001000000000000000000000100100,
        64'b0000010100000010010000010000100100001000000000100000000000010000,
        64'b1000100010001000000000010000000110000000000010010000100000000000,
        64'b1001000001000000010100000010100010000010000000000000000100100100,
        64'b0101001100110101010100100100010101011010101010100101000010010101,
        64'b0110000000000000000000000000000000000000000000000011001000000000,
        64'b0000100000011011100001010100010100010010001001010001010001010010,
        64'b0100000010001000010000100010000001001000100000000001000001000010,
        64'b0100000100001000001000100001000000100001001000001000010010000000,
        64'b0000100010000010000100000100100010001000001000000000000000010010,
        64'b0100010101011010001100111000100000100000111100011110001001000101,
        64'b0001111001100110000000000000000000100000100100100010010001100100,
        64'b1001000100101001000010011000011000000000100001001010100000001000,
        64'b1010001000100010101110110010000000110000100000001010001001001010,
        64'b0000010100000000011000001011010010100000010001010100111111110000,
        64'b0000000000001111110000110011000000100000000000000010111111111111,
        64'b1111111111111111111110101010001000110011001100110000001111110010,
        64'b1000001010101111110011011011000011000010000001000110000010000000,
        64'b1100100000010001001001001100001001000000001010000000001001000011,
        26'b11000011000000000000100000
    };

    localparam [1:0] ST_RESET  = 2'd0;
    localparam [1:0] ST_LOAD   = 2'd1;
    localparam [1:0] ST_SETTLE = 2'd2;
    localparam [1:0] ST_RUN    = 2'd3;

    reg [1:0]  state = ST_RESET;
    reg [7:0]  reset_cnt = 8'd0;
    reg [11:0] bit_index = 12'd0;
    reg [15:0] settle_cnt = 16'd0;
    reg [23:0] op_div_cnt = 24'd0;
    reg        op_clk_r = 1'b0;
    reg        prog_clk_r = 1'b0;
    reg        pReset_r = 1'b1;
    reg        op_reset_r = 1'b1;
    reg        ccff_head_r = 1'b0;

    wire [0:0] op_clk;
    wire [0:0] op_reset;
    wire [0:0] pReset;
    wire [0:0] prog_clk;
    wire [0:0] ccff_tail;
    wire [0:63] gfpga_pad_GPIO_PAD;
    wire [3:0] fabric_led;

    assign op_clk[0] = op_clk_r;
    assign op_reset[0] = op_reset_r;
    assign pReset[0] = pReset_r;
    assign prog_clk[0] = prog_clk_r;

    // User design IO mapping generated by OpenFPGA run026.
    assign gfpga_pad_GPIO_PAD[52] = op_clk_r;
    assign gfpga_pad_GPIO_PAD[1]  = op_reset_r;

    // Decode the soft-FPGA counter output into a one-hot chase pattern for HX4S20 LEDs.
    assign LED = (fabric_led[1:0] == 2'd0) ? 4'b0001 :
                 (fabric_led[1:0] == 2'd1) ? 4'b0010 :
                 (fabric_led[1:0] == 2'd2) ? 4'b0100 :
                                             4'b1000;

    fpga_top u_fpga_top (
        op_clk[0],
        op_reset[0],
        pReset[0],
        prog_clk[0],
        gfpga_pad_GPIO_PAD[0:63],
        ccff_head_r,
        ccff_tail[0],
        fabric_led
    );

    always @(posedge CLOCK) begin
        case (state)
            ST_RESET: begin
                pReset_r <= 1'b1;
                prog_clk_r <= 1'b0;
                op_reset_r <= 1'b1;
                op_clk_r <= 1'b0;
                ccff_head_r <= 1'b0;
                bit_index <= 12'd0;
                if (reset_cnt == 8'd31) begin
                    reset_cnt <= 8'd0;
                    pReset_r <= 1'b0;
                    ccff_head_r <= FABRIC_BITSTREAM[0];
                    state <= ST_LOAD;
                end else begin
                    reset_cnt <= reset_cnt + 8'd1;
                end
            end

            ST_LOAD: begin
                if (prog_clk_r == 1'b0) begin
                    prog_clk_r <= 1'b1;
                end else begin
                    prog_clk_r <= 1'b0;
                    if (bit_index == BITSTREAM_LENGTH - 1) begin
                        state <= ST_SETTLE;
                        settle_cnt <= 16'd0;
                        op_reset_r <= 1'b1;
                    end else begin
                        bit_index <= bit_index + 12'd1;
                        ccff_head_r <= FABRIC_BITSTREAM[bit_index + 12'd1];
                    end
                end
            end

            ST_SETTLE: begin
                prog_clk_r <= 1'b0;
                pReset_r <= 1'b0;
                op_clk_r <= 1'b0;
                op_reset_r <= 1'b1;
                if (settle_cnt == 16'd50000) begin
                    settle_cnt <= 16'd0;
                    state <= ST_RUN;
                end else begin
                    settle_cnt <= settle_cnt + 16'd1;
                end
            end

            ST_RUN: begin
                op_reset_r <= 1'b0;
                if (op_div_cnt == 24'd12_499_999) begin
                    op_div_cnt <= 24'd0;
                    op_clk_r <= ~op_clk_r;
                end else begin
                    op_div_cnt <= op_div_cnt + 24'd1;
                end
            end

            default: state <= ST_RESET;
        endcase
    end

endmodule
`default_nettype wire
