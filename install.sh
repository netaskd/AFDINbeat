#!/bin/sh
# Install from functions config
# Load functions from installer 
for i in $(ls -1 ./functions/);do echo -ne ". ./functions/$i \n";done > ./temp/include
. ./temp/include ;rm ./temp/include
# SETS
#Set colors
GRE="\\033[1;32m";RED="\\033[1;31m";YEL="\\033[1;33m";NORM="\\033[0;39m";
FHOME=$(pwd)
ASTCONF="/etc/asterisk"
drbdver="8.4.0" #Only 8.4.? version
freepbx="2.9.0"
dahdi="dahdi_2.4.1.2+2.4.1-parabel_2.4.3"
timezone="Europe/Moscow"
# Open access to the Internet from mac
webaccess
# Update Centos6 packages
update_pkg
# Configure network
configure_network
# Remove (if exist) lv_home standart installation
remove_lv_home
# Get source from git or assker dir
copy_HiPBX
# Disable selinux with reboot
disable_selinux
# Install dahdi
dahdi_install
dahdi_systemconf
# Set hosname
fix_hostname
fix_hosts
# Install DRBD-4.8.0
drbd_install
# Install nfs (server or client) 
install_nfs
# Install asterisk 1.6.17
install_asterisk
# Install Mysql
install_mysql
# Install Freepbx version set up
install_freepbx
# Move asterisk config to nfs volume
move_astconf
# fix GUID and UID for NFS
fix_uidgid
# Remove all files from temp dir
remove_temp
# Final restart
amportal_restart
#EOF