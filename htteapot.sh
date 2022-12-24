#!/bin/bash

#Github: EarlyOwl/HTTeaPot
#ver 1.0.0 -- This script is licensed under the MIT License

#Define the options ([p]port], [s]status code, [b]response body)
while getopts p:s:b: flag
do
    case "${flag}" in
        p) port=${OPTARG};;
        s) statuscode=${OPTARG};;
        b) responsebody=${OPTARG};;
        *) echo "usage: $0 [-p port] [-s \"status code\"] [-b \"response body\"]"
           echo "e.g. $0 -p 8081 -s 200 -b \"Hello, world!\""
           echo "e.g. $0 -s \"403 Forbidden\" -b \"Goodbye, world!\""
           exit 1 ;;
    esac
done

#Setting the default values if no arguments are provided for p,s and b
if [[ $port = "" ]]; then
  port=8080
fi

if [[ $statuscode = "" ]]; then
  statuscode="418 I'm a Teapot"
fi

if [[ $responsebody = "" ]]; then
  responsebody="HTTeaPot!"
fi

#Show a visual confirmation of the provided parameters
echo -e "🫖  \e[32mHTTeaPot running...\e[0m"
echo -e "\e[33mHTTP status code:\e[0m $statuscode"
echo -e "\e[33mResponse body:\e[0m $responsebody"

#Serve the response till an interrupt is received
while : ; do
  echo -e "HTTP/1.1 $statuscode\r\nContent-Type: text/plain; charset=utf-8\r\n\r\n$responsebody\r\n" | nc -lvN "$port"
done
