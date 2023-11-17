#!/bin/bash

hosts_file="hosts"
paths_file="paths"
output_dir="outputs"

mkdir -p "$output_dir"

if [ ! -f "$hosts_file" ] || [ ! -f "$paths_file" ]; then
    echo "Error: hosts or paths file not found."
    exit 1
fi

while IFS= read -r host; do
    while IFS= read -r path; do
        url="$host/$path"

        output_file="$output_dir/$(echo "$host" | tr -d '/').$(echo "$path" | tr -d '/')"
        response_code=$(curl -s -o "$output_file" -w "%{http_code}" "$url")

        if [ "$response_code" == "200" ]; then
            echo "Request sent to: $url"
            echo "Response code: $response_code"
            echo "Output saved to: $output_file"
        else
            echo "Request to $url did not return a 200 response code. Response code: $response_code"
            rm -f "$output_file"
        fi
    done < "$paths_file"
done < "$hosts_file"

echo "Script execution completed."
