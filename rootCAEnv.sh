#!/bin/bash
# This script was made because I kept cutting corners, and I am so done cutting corners now.
dnf install openssl
mkdir /root/ca
cd /root/ca
mkdir certs crl newcerts private
chmod 700 private
touch index.txt
echo 1000 > serial
curl https://jamielinux.com/docs/openssl-certificate-authority/_downloads/root-config.txt > openssl.cnf
