`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Project: VLSI Design of FIR Filter for DSP Applications
//
// Module: fir_filter
//
// Description:
// 8-tap FIR filter using a shift-register structure.
// The filter coefficients are:
//
// h0 = 1
// h1 = 6
// h2 = 21
// h3 = 36
// h4 = 36
// h5 = 21
// h6 = 6
// h7 = 1
//
//////////////////////////////////////////////////////////////////////////////////

module fir_filter(
    input  clk,
    input  rst,
    input signed [15:0] x_in,
    output reg signed [31:0] y_out
);

    // =========================================================
    // FIR Coefficients
    // Generated/documented using MATLAB
    // =========================================================

    parameter signed [15:0] h0 = 16'sd1;
    parameter signed [15:0] h1 = 16'sd6;
    parameter signed [15:0] h2 = 16'sd21;
    parameter signed [15:0] h3 = 16'sd36;
    parameter signed [15:0] h4 = 16'sd36;
    parameter signed [15:0] h5 = 16'sd21;
    parameter signed [15:0] h6 = 16'sd6;
    parameter signed [15:0] h7 = 16'sd1;

    // =========================================================
    // Shift Register
    // =========================================================

    reg signed [15:0] shift_reg [0:7];

    integer i;

    // =========================================================
    // FIR Filter Operation
    // =========================================================

    always @(posedge clk)
    begin

        // -----------------------------------------------------
        // Reset
        // -----------------------------------------------------

        if (rst)
        begin

            for (i = 0; i < 8; i = i + 1)
                shift_reg[i] <= 16'sd0;

            y_out <= 32'sd0;

        end

        // -----------------------------------------------------
        // Normal FIR Operation
        // -----------------------------------------------------

        else
        begin

            // Shift input samples

            shift_reg[7] <= shift_reg[6];
            shift_reg[6] <= shift_reg[5];
            shift_reg[5] <= shift_reg[4];
            shift_reg[4] <= shift_reg[3];
            shift_reg[3] <= shift_reg[2];
            shift_reg[2] <= shift_reg[1];
            shift_reg[1] <= shift_reg[0];
            shift_reg[0] <= x_in;

            // FIR convolution

            y_out <=
                shift_reg[0] * h0 +
                shift_reg[1] * h1 +
                shift_reg[2] * h2 +
                shift_reg[3] * h3 +
                shift_reg[4] * h4 +
                shift_reg[5] * h5 +
                shift_reg[6] * h6 +
                shift_reg[7] * h7;

        end

    end

endmodule
