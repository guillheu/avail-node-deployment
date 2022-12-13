# Use the latest version of the nestybox/ubuntu-bionic-systemd-docker base image
FROM nestybox/ubuntu-bionic-systemd-docker:latest

# Define an ARG variable named GITHUB_USERNAME with a default value
ARG GITHUB_USERNAME

# Update the package index and install the openssh-server, sudo, and python3 packages
RUN apt update && apt upgrade -y && apt install  openssh-server sudo python3 -y

# Create a new user with the name specified by the GITHUB_USERNAME ARG variable
RUN useradd -m -s /bin/bash $GITHUB_USERNAME

# Give a default password to the new user
RUN echo "$GITHUB_USERNAME:password" | chpasswd

# Adding the new user to the sudoers file
RUN usermod -aG sudo $GITHUB_USERNAME

# Download the ssh keys for the specified GitHub user and add them to the authorized_keys file for the new user
ADD https://github.com/$GITHUB_USERNAME.keys /home/$GITHUB_USERNAME/.ssh/authorized_keys

# Set the permission for the authorized_keys file to 600
RUN chmod 600 /home/$GITHUB_USERNAME/.ssh/authorized_keys

# Set the owner of the authorized_keys file to the new user
RUN chown $GITHUB_USERNAME /home/$GITHUB_USERNAME/.ssh/authorized_keys

# Restart the ssh service
RUN service ssh restart

# Expose port 22 for ssh connections
EXPOSE 22