// DAV Lab4 FFT
`timescale 1ns/1ns

module FFT_testbench(freq0, freq1, freq2, freq3, done); 
	reg clk_in = 0;
	reg reset = 0; 
	reg new_t = 1;
	reg [9:0] pt0, pt1, pt2, pt3;
	
	output [15:0] freq0, freq1, freq2, freq3;
	output done; // 0: false; 1: true
	
	integer i;

	FFT_design myFFT(.clk_in(clk_in), .reset(reset), .new_t(new_t), 
						  .pt0(pt0), .pt1(pt1), .pt2(pt2), .pt3(pt3), 
						  .freq0(freq0), .freq1(freq1), .freq2(freq2), 
						  .freq3(freq3), .done(done));
	always begin
		pt0 = 10'b0000001010; // 8
		pt1 = 10'b0000000101; // 2
		pt2 = 10'b0000000011; // 3
		pt3 = 10'b0000000100; // 4
		
		for(i=0;i<24;i=i+1) begin
			if (i == 1) begin
				reset = ~reset;
			end
			clk_in = ~clk_in;
			//reset = ~reset;
			#30;
		end
		$stop;
	end
	
	

endmodule 