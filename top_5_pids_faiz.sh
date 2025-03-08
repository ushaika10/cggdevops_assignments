#!/bin/env bash

#display the os version on the vm

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
