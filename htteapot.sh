#!/bin/bash

#Github: EarlyOwl/HTTeaPot
#ver 1.1.0 -- This script is licensed under the MIT License

# Usage function to display help
function usage() {
    echo "Usage: $0 [-p port] [-s status code] [-b response body | -f response file] [-h custom headers]"
    echo "Options:"
    echo "  -p  Set the port to listen on (Default is 8080)."
    echo "  -s  Set the HTTP status code (Default is '418 I'm a Teapot')."
    echo "  -b  Set the response body directly (Default is HTTeaPot!)."
    echo "  -f  Set the response body from a file."
    echo "  -h  Set custom headers. Multiple headers should be separated by '|'. (Default is Content-Type: text/plain; charset=utf-8)."
    echo "Examples:"
    echo "  $0 -p 8081 -s 200 -b \"Hello, world!\""
    echo "  $0 -f ./response.html -h \"Content-Type: text/html|Cache-Control: no-cache\""
}

# Signal handler for graceful shutdown
function cleanup() {
    echo "Shutting down HTTeaPot..."
    exit 0
}

# Trap SIGINT for graceful shutdown
trap cleanup SIGINT

# Default values
port=8080
statuscode="418 I'm a Teapot"
responsebody="HTTeaPot!"
headers="Content-Type: text/plain; charset=utf-8"

# Parse options
while getopts ":p:s:b:f:h:" flag; do
    case "${flag}" in
        p) port=${OPTARG};;
        s) statuscode=${OPTARG};;
        b) responsebody=${OPTARG};;
        f) responsebody=$(cat ${OPTARG});;
        h) headers=${OPTARG//|/$'\n'};;  # Replace '|' with newline for headers
        *) usage; exit 1 ;;
    esac
done

# Validate port number and check if it's in use
if ! [[ $port =~ ^[0-9]+$ ]] || [ $port -le 0 ] || [ $port -gt 65535 ]; then
    echo "Error: Invalid port number."
    exit 1
fi
if nc -z localhost $port; then
    echo "Error: Port $port is already in use."
    exit 1
fi

# Check for root privileges if trying to use ports below 1024
if [ "$port" -lt 1024 ]; then
    if [ "$(id -u)" -ne 0 ]; then
        echo "Warning: Listening on ports below 1024 requires root privileges."
        echo "Please run the script as root or use sudo."
        exit 1
    fi
fi

# Show configuration
echo -e "🫖  \e[32mHTTeaPot running...\e[0m"
echo -e "\e[33mPort:\e[0m $port"
echo -e "\e[33mHTTP status code:\e[0m $statuscode"
echo -e "\e[33mResponse body:\e[0m $responsebody"

# Serve the response till an interrupt is received
while : ; do
    echo -e "HTTP/1.1 $statuscode\r\n$headers\r\n\r\n$responsebody\r\n" | nc -lvN "$port"
done