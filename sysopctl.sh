#!/bin/bash

VERSION="1.0.0"

function show_help {
  echo "Usage: sysopctl [COMMAND] [OPTIONS]"
  echo "A command-line utility for managing system services, processes, and system health."
  echo ""
  echo "Commands:"
  echo "  service list                List all active services."
  echo "  service start <service-name> Start the specified service."
  echo "  service stop <service-name>  Stop the specified service."
  echo "  system load                 View current system load."
  echo "  disk usage                  Check disk usage."
  echo "  process monitor             Monitor system processes."
  echo "  logs analyze                Analyze system logs."
  echo "  backup <path>               Backup system files from <path>."
  echo ""
  echo "Options:"
  echo "  --help                      Show this help message."
  echo "  --version                   Show version information."
}

function show_version {
  echo "sysopctl version $VERSION"
}

# Function to List Running Services
function list_services {
  echo "Active Services:"
  brew services list
}

# Function to View System Load
function view_system_load {
  echo "Current System Load:"
  uptime
}

# Function to Start a Service
function start_service {
  if [ -z "$1" ]; then
    echo "Usage: sysopctl service start <service-name>"
    return
  fi
  sudo brew services start "$1"
  echo "Service $1 started."
}

# Function to Stop a Service
function stop_service {
  if [ -z "$1" ]; then
    echo "Usage: sysopctl service stop <service-name>"
    return
  fi
  sudo brew services stop "$1"
  echo "Service $1 stopped."
}

# Function to Check Disk Usage
function check_disk_usage {
  echo "Disk Usage Statistics:"
  df -h
}

# Function to Monitor System Processes
function monitor_processes {
  echo "Monitoring System Processes (Press Ctrl+C to stop):"
  top
}

# Function to Analyze System Logs for macOS
function analyze_logs {
  echo "Recent Critical Log Entries:"
  log show --predicate 'eventMessage contains "error" OR eventMessage contains "critical"' --info --last 1h | tail -n 10
}

# Function to Backup System Files
function backup_files {
  if [ -z "$1" ]; then
    echo "Usage: sysopctl backup <path>"
    return
  fi
  rsync -a --progress "$1" ~/backup/
  echo "Backup of $1 initiated."
}

# Command-line parsingcase "$1" in
  --help)
    show_help
    ;;
  --version)
    show_version
    ;;
  service)
    case "$2" in
      list)
        list_services
        ;;
      start)
        start_service "$3"
        ;;
      stop)
        stop_service "$3"
        ;;
      *)
        echo "Unknown service command: $2"
        show_help
        ;;
    esac
    ;;
  system)
    case "$2" in
      load)
        view_system_load
        ;;
      *)
        echo "Unknown system command: $2"
        show_help
        ;;
    esac
    ;;
  disk)
    case "$2" in
      usage)
        check_disk_usage
        ;;
      *)
        echo "Unknown disk command: $2"
        show_help
        ;;
    esac
    ;;
  process)
    case "$2" in
      monitor)
        monitor_processes
        ;;
      *)
        echo "Unknown process command: $2"
        show_help
        ;;
    esac
    ;;
  logs)
    case "$2" in
      analyze)
        analyze_logs
        ;;
      *)
        echo "Unknown logs command: $2"
        show_help
        ;;
    esac
    ;;
  backup)
    backup_files "$2"
    ;;
  *)
    echo "Unknown command: $1"
    show_help
    ;;
esac