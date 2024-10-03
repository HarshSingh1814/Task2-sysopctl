# Task2-sysopctl
# sysopctl

## Overview
`sysopctl` is a command-line utility for managing system services, processes, and system health on macOS.

## Features
- List running services.
- Start and stop system services.
- View current system load.
- Check disk usage.
- Monitor system processes in real-time.
- Analyze system logs for errors.
- Backup system files.

## Usage
```bash
# List all active services
./sysopctl service list

# Start a service
./sysopctl service start <service-name>

# Stop a service
./sysopctl service stop <service-name>

# View current system load
./sysopctl system load

# Check disk usage
./sysopctl disk usage

# Monitor system processes
./sysopctl process monitor

# Analyze system logs
./sysopctl logs analyze

# Backup system files
./sysopctl backup <path>
