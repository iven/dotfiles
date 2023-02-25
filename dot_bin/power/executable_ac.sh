#!/bin/bash

sudo cpupower frequency-set -g performance
sudo wrmsr -a 0x19a 0x0
