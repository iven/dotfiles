#!/bin/bash

sudo modprobe -r nvidia_modeset
sudo modprobe -r nvidia
echo OFF | sudo tee /proc/acpi/bbswitch > /dev/null
cat /proc/acpi/bbswitch
