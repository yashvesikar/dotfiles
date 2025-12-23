#!/bin/bash

# Exit on any error
set -e

# Parse command line options
ADD_SSH_KEY=false
DISABLE_PASSWORD_AUTH=false

print_usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -k, --add-ssh-key           Add SSH public key"
    echo "  -d, --disable-password-auth  Disable password authentication for SSH"
    echo "  -h, --help                   Display this help message"
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -k|--add-ssh-key)
            ADD_SSH_KEY=true
            shift
            ;;
        -d|--disable-password-auth)
            DISABLE_PASSWORD_AUTH=true
            shift
            ;;
        -h|--help)
            print_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            print_usage
            exit 1
            ;;
    esac
done

# Update and upgrade all packages
echo "Updating and upgrading all packages..."
apt-get update && apt-get upgrade -y

# Prompt for new username
read -p "Enter username for new non-root user: " NEW_USER

# Check if user already exists
if id "$NEW_USER" &>/dev/null; then
    echo "User $NEW_USER already exists."
else
    # Create new user
    adduser --gecos "" "$NEW_USER"
    
    # Add user to sudo group
    usermod -aG sudo "$NEW_USER"
    
    echo "User $NEW_USER created and added to sudo group."
fi

# Add SSH key if requested
if [ "$ADD_SSH_KEY" = true ]; then
    # Create .ssh directory for the new user if it doesn't exist
    USER_HOME=$(eval echo ~$NEW_USER)
    SSH_DIR="$USER_HOME/.ssh"

    if [ ! -d "$SSH_DIR" ]; then
        mkdir -p "$SSH_DIR"
        chmod 700 "$SSH_DIR"
        chown "$NEW_USER:$NEW_USER" "$SSH_DIR"
    fi

    # Prompt for SSH public key
    echo "Please paste the content of your id_rsa.pub file (Ctrl+D when done):"
    PUBLIC_KEY=$(cat)

    # Write public key to authorized_keys
    echo "$PUBLIC_KEY" > "$SSH_DIR/authorized_keys"
    chmod 600 "$SSH_DIR/authorized_keys"
    chown "$NEW_USER:$NEW_USER" "$SSH_DIR/authorized_keys"

    echo "SSH public key added to authorized_keys."
fi

    # Disable password authentication for SSH if requested
if [ "$DISABLE_PASSWORD_AUTH" = true ]; then
    echo "Disabling password authentication for SSH for all users including root..."
    
    # Disable password authentication
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
    
    # Prohibit root password login (allow only key-based)
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
    sed -i 's/PermitRootLogin yes/PermitRootLogin prohibit-password/' /etc/ssh/sshd_config
    
    # Ensure PubkeyAuthentication is enabled
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config
    
    # Make sure ChallengeResponseAuthentication is disabled
    sed -i 's/ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
    sed -i 's/#ChallengeResponseAuthentication yes/ChallengeResponseAuthentication no/' /etc/ssh/sshd_config
    
    # Restart SSH service
    systemctl restart sshd
    
    echo "Password authentication for SSH has been disabled for all users including root."
fi

echo "Setup complete!"
