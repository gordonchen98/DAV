# Fast Fourier Transform

This is an implementation of 4-point fast fourier transform.

The implementation can be found in `FFT_design` file.

## Miscellaneous
1. In the file `FFT_design`, the first/second twiddle factor in stage one is supposed to be multiplied by 2^15; however, due to 16-bits two's compliment number constant, we need to make it `0x7FFF`, which is 2^15-1 to maintain it as a positive number.
2. In the file `FFT_design`, the second twiddle factor in stage two is being multiplied by 2^15, which is `0x8000`.
3. You might ask why we need to do the shifting with 2^15 of the twiddle factor. Since we are dealing with 16-bits number, the product of two 16-bits number will be a 32-bits number. Therefore, we need to truncate the 32-bits product into a 16-bits number, namely [30:15] since the two most significant bits will be the same in a product.

The following graph is a visual representation of a 4-point fft.

![plot](./4_point_fft.png)