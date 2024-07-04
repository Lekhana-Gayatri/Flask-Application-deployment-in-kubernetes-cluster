#!/bin/bash
INVENTORY_FILE="inventory"

function ssh_copy_id_to_host {
    local host="$1"
    echo "Copying SSH key to $host ..."
    ssh-copy-id -f "-o IdentityFile new_key.pem" ubuntu@$host
    # Check the result of ssh-copy-id command
    if [ $? -eq 0 ]; then
        echo "SSH key successfully copied to $host."
    else
        echo "Failed to copy SSH key to $host. Check your SSH key or permissions."
    fi
}


while IFS= read -r line; do
    # Skip empty lines or lines starting with #
    if [[ -n "$line" && ! "$line" =~ ^\s*# ]]; then
        # Check for group header
        if [[ "$line" =~ ^\[.*\]$ ]]; then
            group=$(echo "$line" | tr -d '[]')
            echo "Group: $group"
        else
            # Split line into host and group
            host=$(echo "$line" | awk '{print $1}')
            group=$(echo "$line" | awk '{print $2}')

            # Assuming your SSH private key is in keya.pem (adjust as needed)
            ssh_copy_id_to_host "$host" "keya.pem"
        fi
    fi
done < "$INVENTORY_FILE"
