// DAV Lab4 FFT
`timescale 1ns/1ns
module FFT_design(clk_in, reset, new_t, pt0, pt1, pt2, pt3, 
						freq0, freq1, freq2, freq3, done);
	input clk_in, reset, new_t;
	input [9:0] pt0, pt1, pt2, pt3;
	output reg [15:0] freq0, freq1, freq2, freq3;
	output reg done; // 0: false; 1: true
	
	reg [31:0] butterfly_in0, butterfly_in1, butterfly_in2, butterfly_in3;
	reg [31:0] twiddle_in0, twiddle_in1;
	wire [31:0] out0, out1, out2, out3;
	integer counter = 1;
	
	butterfly_design myButterfly1(.a(butterfly_in0), .b(butterfly_in1), .w(twiddle_in0),
											.out1(out0), .out2(out1));
	butterfly_design myButterfly2(.a(butterfly_in2), .b(butterfly_in3), .w(twiddle_in1),
											.out1(out2), .out2(out3));
	
	always @ (posedge clk_in) begin
		if (~reset) begin
			// set the twiddle inputs and value inputs to 0
			butterfly_in0 = 0;
			butterfly_in1 = 0;
			butterfly_in2 = 0;
			butterfly_in3 = 0;
			twiddle_in0 = 0;
			twiddle_in1 = 0;
			// you’re at your max value of the cycle counter
			counter = 1;
			// show that the calculation is “done”
			done = 1;
		end
		else begin
			// cycle 0: load the inputs into the reg
			if (counter == 1 && new_t == 1) begin
				butterfly_in0 = {{6{pt0[9]}}, pt0, 16'b0};
				butterfly_in1 = {{6{pt2[9]}}, pt2, 16'b0};
				butterfly_in2 = {{6{pt1[9]}}, pt1, 16'b0};
				butterfly_in3 = {{6{pt3[9]}}, pt3, 16'b0};
				twiddle_in0 = 'h00010000;
				twiddle_in1 = 'h00010000;
				counter = 0;
				done = 0;
			end
			// cycle 2: save the output of stage 2
			else if (counter == 0) begin
				butterfly_in0 = out0;
				butterfly_in1 = out2;
				butterfly_in2 = out1;
				butterfly_in3 = out3;
				twiddle_in0 = 'h00010000;
				twiddle_in1 = 'h00000001;
				counter = 1;
				done = 1;
			end
		end
	end
	
	always @ (posedge done) begin
		freq0 = out0[31:16];
		freq1 = out2[31:16];
		freq2 = out1[31:16];
		freq3 = out3[31:16];
	end

endmodule 