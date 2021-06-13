`timescale 1 ns/1 ns
// DAV lab4 FFT
module butterfly_design(a, b, w, out1, out2);
	input [31:0] a, b, w;
	output [31:0] out1, out2;
	wire [15:0] realA = a[31:16];
	wire [15:0] imagA = a[15:0];
	wire [15:0] realB = b[31:16];
	wire [15:0] imagB = b[15:0];
	wire [15:0] realW = w[31:16];
	wire [15:0] imagW = w[15:0];
	wire [15:0] realResult, imagResult;
	
	// compute w*b
	assign realResult = realB*realW - imagB*imagW;
	assign imagResult = realB*imagW + imagB*realW;
	
	// find the outputs
	assign out1 = {(realA + realResult), (imagA + imagResult)};
	assign out2 = {(realA - realResult), (imagA - imagResult)};

endmodule 