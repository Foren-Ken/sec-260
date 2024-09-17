#!/bin/bash
# Create the Client's key (In my case, the address of my webserver is 10.0.17.29)
cd /root/ca
openssl genrsa -aes256 -out intermediate/private/10.0.17.29.key.pem 2048
chmod 400 intermediate/private/10.0.17.29.key.pem

# Create Cert
openssl req -config intermediate/openssl.cnf -key intermediate/private/10.0.17.29.key.pem -new -sha256 -out intermediate/csr/10.0.17.29.csr.pem
openssl ca -config intermediate/openssl.cnf -extensions server_cert -days 375 -notext -md sha256 -in intermediate/csr/w10.0.17.29.csr.pem -out intermediate/certs/10.0.17.29.cert.pem
chmod 444 intermediate/certs/www.example.com.cert.pem

# Verify Cert:
openssl x509 -noout -text -in intermediate/certs/www.example.com.cert.pem | more
openssl verify -CAfile intermediate/certs/ca-chain.cert.pem intermediate/certs/www.example.com.cert.pem

mkdir /root/serverPackage
chmod 400 /root/serverPackage
cp /root/ca/intermediate/10.0.17.29.key.pem /root/ca/intermediate/certs/10.0.17.29.cert.pem /root/ca/intermediate/certs/ca-chain.cert.pem /root/serverPackage
