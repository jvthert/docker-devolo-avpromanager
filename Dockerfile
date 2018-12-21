# Pull base image
FROM jlesage/baseimage-gui:ubuntu-16.04

LABEL maintainer="Alex <ualex73@gmail.com>"

# Copy the start script
COPY rootfs/ /

# Set work directory
WORKDIR /config

# Set the name of the application
ENV APP_NAME="AVpro Manager"

# Restart app if something happens
ENV KEEP_APP_RUNNING=1

# Set permissions, app can only run under 'root'
ENV USER_ID=0
ENV GROUP_ID=0

# Define the deb file to install
ENV INSTALL_DEB software-dlan-avpro-manager-ubuntu64-6-10-0.deb

# Update debs and install the AVpro Manager
RUN DEBIAN_FRONTEND=noninteractive apt update \
  && apt -y install gdebi \
  && gdebi --non-interactive /${INSTALL_DEB}

