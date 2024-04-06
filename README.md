![htteapot](https://user-images.githubusercontent.com/49495410/209414246-9ca235c9-0528-4907-9b04-cf6a10d3a663.png)


[![ShellCheck](https://github.com/EarlyOwl/HTTeaPot/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/EarlyOwl/HTTeaPot/actions/workflows/shellcheck.yml)

Simple HTTP responder with netcat for testing purposes

## Contents
- [What is this?](#what-is-this)
- [How does it work?](#how-does-it-work)
- [Installation](#installation)
- [Usage](#usage)
- [Useful resources](#useful-resources)
- [Misc](#misc)

## What is this?
This is a super simple script that will answer all the HTTP requests received with your custom response. This is intended to be used as a quick way to test how an application handles different status codes.

## How does it work?
Basically ```nc``` and a ```while``` loop! HTTeaPot will answer every request received with your custom response until stopped.

|HTTeaPot|curl|
|-|-|
|<img width="507" alt="teapot" src="https://user-images.githubusercontent.com/49495410/209422870-0eff9f93-4a3f-4e66-b8e5-978cb74a2fd7.png">|<img width="507" alt="curl" src="https://user-images.githubusercontent.com/49495410/209422869-0316f139-c46e-4134-8589-d9e83dbbab62.png">


## Installation

1. Download htteapoth.sh from the main branch to your local machine:

```shell
wget https://raw.githubusercontent.com/EarlyOwl/HTTeaPot/main/htteapot.sh
```

2. Make it executable:

```shell
chmod +x htteapot.sh
```

3. Run the script (see [usage](#usage))

## Usage

```shell
./htteapot.sh [-p port] [-s status code] [-b response body | -f response file] [-h custom headers]
```

Where (*all parameters are optional*):

- ```--help```: show the command usage.

- ```-p```: specify the port for the listener (*default is 8080*). E.g. ```-p 8081```. Running on ports below 1024 requires root privileges.

- ```-s```: specify the HTTP status code. Valid examples are ```-s 200``` or ```-s "200 OK"``` (*default is 418 I'm a Teapot*).

- ```-b```: specify the response body. Valid examples are ```-b Hello!``` or ```-b "Hello, world!"``` (*default is HTTeaPot!*).

- ```-f```: specify the response body from a file. Valid examples are ```-f webpage.html``` or ```-f "file.txt"```.

- ```-h```: specify custom headers. Multiple headers should be separated by '|'. Valid examples are ```-h "Content-Type: text/plain"``` or ```-h "Content-Type: text/html|Cache-Control: no-cache"``` (*default is Content-Type: text/plain; charset=utf-8*).

Some examples:

Serve a text response on the default port.
 ```shell
./htteapot.sh -s 200 -b "Hello, world!"
```

Serve a text response on port 8888.
```shell
./htteapot.sh -s "200 OK" -b "Hello, world!" -p 8888
```

Serve the default response with a custom HTTP status code.
```shell
./htteapot.sh -s "404 Not found"
```

Serve an HTML file on port 80.
```shell
sudo ./htteapot.sh -p 80 -s "200 OK" -f "response.html" -h "Content-Type: text/html|Cache-Control: no-cache"
```

To terminate HTTeaPot just send an interrupt (<kbd>Ctrl</kbd> + <kbd>C</kbd>)

## Useful resources
- List of HTTP response status codes ([MDN Web Docs](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status))
- Overview of HTTP status codes ([HTTPWG](https://httpwg.org/specs/rfc9110.html#overview.of.status.codes))
- Online tool to check status codes and response headers ([httpstatus.io](https://httpstatus.io/))

## Misc

##### Can I contribute? Can I reuse all/part of this script for other purposes?
Yes and yes.

##### This sucks / You could have done X instead of X!
I'm eager to learn, open an issue or a  pull request to suggest an improvement / fix.
