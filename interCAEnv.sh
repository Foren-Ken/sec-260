#!/bin/bash
# basic setup
mkdir /root/ca/intermediate
cd /root/ca/intermediate
mkdir certs crl csr newcerts private
chmod 700 private # Gotta keep it private
touch index.txt
echo 1000 > serial # 1000 isnt required, any number is fine. 

echo 1000 > /root/ca/intermediate/crlnumber
curl https://jamielinux.com/docs/openssl-certificate-authority/_downloads/intermediate-config.txt > openssl.cnf
