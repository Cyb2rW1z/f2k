# F2K File 2 Kyle

## Overview

This Bash script sends HTTP requests to a list of hosts and paths, saves the output, and stores only the responses with a 200 HTTP status code. The script is designed to read host and path information from specified files and store the outputs in a designated directory.

## Prerequisites

- Bash
- curl

## Usage

1. Clone the repository

   ```bash
   git clone https://github.com/your-username/your-repository.git
   cd your-repository

    Make the script executable

chmod +x your_script.sh
```
### Run the script
```
    ./your_script.sh
```
## Configuration

    hosts: Create a file named hosts with a list of host URLs, one per line.
    paths: Create a file named paths with a list of paths to append to each host URL, one per line.
    outputs: The script will save the outputs of successful requests with a 200 status code in a directory named outputs.

## Example

Assuming the following content in hosts and paths files:

### hosts

plaintext

https://cache.marriott.com
https://www.marriott.com
https://www.emea.marriott.com
http://cache.marriott.com

### paths

plaintext
```
/path1
/path2
/path3
```
The script will generate requests like
```
    https://cache.marriott.com/path1
    https://cache.marriott.com/path2
    http://cache.marriott.com/path3
```
The outputs of successful requests (HTTP status code 200) will be stored in the outputs directory.
