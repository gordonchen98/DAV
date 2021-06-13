`timescale 1 ns/1 ns
//DAV Lab4
module butterfly_testbench(out1, out2);
	reg [31:0] a, b, w;
	output [31:0] out1, out2;
	
	butterfly_design myButterfly(.a(a), .b(b), .w(w), .out1(out1), .out2(out2));
	
	initial begin
		a = 32'b00010010001101000000000000000001;
		b = 32'b01000011001000010000000000000000;
		w = 32'b00000000000000010000000000000000;
		#50;
		w = 32'b00000000000000001111111111111111;
		#50;
		w = 32'b11111111111111110000000000000000;
		#50;
		w = 32'b00000000000000000000000000000001;
		#50;
	end

endmodule 