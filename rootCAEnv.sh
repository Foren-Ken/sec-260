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

# altering the openssl.cnf file
nano openssl.cnf

# creating the root key
openssl genrsa -aes256 -out private/ca.key.pem 4096
chmod 400 private/ca.key.pem

# Creating root cert
openssl req -config openssl.cnf -key private/ca.key.pem -new -x509 -days 7300 -sha256 -extensions v3_ca -out certs/ca.cert.pem
chmod 444 certs/ca.cert.pem

# verification of root cert. 
openssl x509 -noout -text -in certs/ca.cert.pem | more
