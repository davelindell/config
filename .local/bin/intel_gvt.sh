#!/bin/sh
GVT_GUID=76f2f238-ea1e-404b-b20e-0ebd7821c701
echo "${GVT_GUID}" > /sys/devices/pci0000:00/0000:00:02.0/mdev_supported_types/i915-GVTg_V5_4/create
