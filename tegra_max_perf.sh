#!/bin/sh
#
# Turn on / off performance Tegra TK1
#
# !!DISCLAIMER!!
#
# THE SCRIPT CHANGES CPU, GPU AND THEIR FREQUENIES,
# LEADING TO POSSIBLE HEATING OR ELECTRICAL ISSUES.
# MAKE SURE YOUR CHIP HAS ENOUGH COOLING.
# USE AT YOUR OWN RISK!
#
# Version control system: See Git
#
# Run as ./tegra_max_perf.sh <option1> <option2>
#
# Options:
#
# fan -> enable fan if possible
# off -> put CPUs 1-3 (0,1,2,3) offline
#


# Turn on cooling fan for safety
if [ "$1" = "fan" ]
then

	echo "Enabling fan for safety."
	if [ ! -w /sys/kernel/debug/tegra_fan/target_pwm ] ; then
	echo "Cannot set fan -- exiting"
	fi
	echo 255 > /sys/kernel/debug/tegra_fan/target_pwm

else

if [ "$1" = "off" ]
then

# Offline all CPUs
	
	echo 1 > /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
	echo 0 > /sys/kernel/cluster/immediate
	echo 0 > /sys/kernel/cluster/force
	echo Cluster: $(cat /sys/kernel/cluster/active)
	
	echo "Offlining CPUs: ignore errors..."
	for i in 0 1 2 3 ; do
		echo 0 > /sys/devices/system/cpu/cpu${i}/online
	done
	echo Online  CPUs: $(cat /sys/devices/system/cpu/online)
	echo Offline CPUs: $(cat /sys/devices/system/cpu/offline)

else

	echo 0 > /sys/devices/system/cpu/cpuquiet/tegra_cpuquiet/enable
	echo 1 > /sys/kernel/cluster/immediate
	echo 1 > /sys/kernel/cluster/force
	echo G > /sys/kernel/cluster/active #G?
	echo Cluster: $(cat /sys/kernel/cluster/active)

# Online all CPUs

echo "Onlining CPUs: ignore errors..."
for i in 0 1 2 3 ; do
	echo 1 > /sys/devices/system/cpu/cpu${i}/online
done
echo Online  CPUs: $(cat /sys/devices/system/cpu/online)
echo Offline CPUs: $(cat /sys/devices/system/cpu/offline)

# set CPUs to max freq (perf governor not enabled on L4T yet)

echo userspace > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
cpumax=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_frequencies | awk '{print $NF}')
echo "${cpumax}" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
for i in 0 1 2 3 ; do
	echo CPU${i}: $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
done

# max GPU clock (should read from debugfs)
cat /sys/kernel/debug/clock/gbus/max > /sys/kernel/debug/clock/override.gbus/rate
echo 1 > /sys/kernel/debug/clock/override.gbus/state
echo GPU: $(cat /sys/kernel/debug/clock/gbus/rate)

# max EMC clock (should read from debugfs)
cat /sys/kernel/debug/clock/emc/max > /sys/kernel/debug/clock/override.emc/rate
echo 1 > /sys/kernel/debug/clock/override.emc/state
echo EMC: $(cat /sys/kernel/debug/clock/emc/rate)


	fi
fi