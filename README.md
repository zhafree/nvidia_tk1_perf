#  Scope
This script enables maximum performance for NVIDIA's Tegra TK1.

# Activate CPUs, GPU, etc.

sudo ./tegra_max_perf.sh

# Deactivate CPUs (not GPU)

sudo ./tegra_max_perf.sh off

# Activate fan (if available - not tested due to passive cooling setup)

sudo ./tegra_max_perf.sh fan


# Stats

Check stats with NVIDIA's original tegrastats:

./tegrastats 

:rocket:

# References

https://devtalk.nvidia.com/default/topic/901337/jetson-tx1/cuda-7-0-jetson-tx1-performance-and-benchmarks/1

http://elinux.org/Jetson/Performance

http://www.nvidia.com/object/jetson-tk1-embedded-dev-kit.html


[![Codacy Badge](https://api.codacy.com/project/badge/Grade/385cf436939047a5b8e803b3578561e1)](https://www.codacy.com/app/ludwig-schreier/nvidia_tk1_perf?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=ludwigschreier/nvidia_tk1_perf&amp;utm_campaign=Badge_Grade)
