#!/bin/bash
ffmpeg -i $1 -map 0:0 -map 0:1 -map_metadata -1 -vcodec copy -acodec copy $2
