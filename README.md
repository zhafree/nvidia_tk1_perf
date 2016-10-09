#  Scope
This script enables maximum performance for NVIDIA's Tegra TK1.

# Activation

Before:

ubuntu@tegra-ubuntu:~$ ./tegrastats 
RAM 598/1892MB (lfb 209x4MB) cpu [0%,off,off,off]@-1 VDE 0 EDP limit 0

After:

ubuntu@tegra-ubuntu:~$ ./tegrastats 
RAM 601/1892MB (lfb 207x4MB) cpu [0%,0%,0%,0%]@-1 VDE 0 EDP limit 0 

:rocket:

# References

https://devtalk.nvidia.com/default/topic/901337/jetson-tx1/cuda-7-0-jetson-tx1-performance-and-benchmarks/1

http://elinux.org/Jetson/Performance

http://www.nvidia.com/object/jetson-tk1-embedded-dev-kit.html
