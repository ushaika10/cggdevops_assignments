#!/bin/env bash

#display the top processes according to the cpu usage. limit the output to 6 lines.
#first line for header and 5 lines for top processes. 

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
