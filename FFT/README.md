# Fast Fourier Transform

This is an implementation of 4-point fast fourier transform.

The implementation can be found in `FFT_design` file.

## Miscellaneous
1. In the file `FFT_design`, the first/second twiddle factor in stage one is supposed to be multiplied by 2^15, or shift right by 15; however, due to 16-bit two's compliment number constant, we need to make it `0x7FFF`, which is 2^15-1 to maintain it as a positive number.
2. In the file `FFT_design`, the first twiddle factor in stage two is the same as the one descibed in stage one, and the second twiddle factor in stage two is being multiplied by 2^15, or shift right by 15, which is `0x8000`.
3. You might ask why do we need the shifting of 15-bit to the original twiddle factor. Since we are dealing with 16-bit number, the product of two 16-bit number will be a 32-bits number. Therefore, we need to truncate the 32-bits product into a 16-bit number, namely [30:15] of the 32-bit product (since the two most significant bits will be the same in a product, we can ignore the most significant bit of the 32-bit product).

The following graph is a visual representation of a 4-point fft.

![plot](./4_point_fft.png)