#!/bin/bash

# Define the host and paths files
hosts_file="hosts"
paths_file="paths"

# Output directory
output_dir="outputs"

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Check if hosts and paths files exist
if [ ! -f "$hosts_file" ] || [ ! -f "$paths_file" ]; then
    echo "Error: hosts or paths file not found."
    exit 1
fi

# Loop through each line in the hosts file
while IFS= read -r host; do
    # Loop through each line in the paths file
    while IFS= read -r path; do
        # Construct the URL
        url="$host/$path"

        # Use curl to send a request and save the output to a file
        output_file="$output_dir/$(echo "$host" | tr -d '/').$(echo "$path" | tr -d '/')"
        response_code=$(curl -s -o "$output_file" -w "%{http_code}" "$url")

        if [ "$response_code" == "200" ]; then
            echo "Request sent to: $url"
            echo "Response code: $response_code"
            echo "Output saved to: $output_file"
        else
            echo "Request to $url did not return a 200 response code. Response code: $response_code"
            # Remove the output file if the response code is not 200
            rm -f "$output_file"
        fi
    done < "$paths_file"
done < "$hosts_file"

echo "Script execution completed."
