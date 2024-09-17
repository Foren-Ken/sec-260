#!/bin/bash
# basic setup
mkdir /root/ca/intermediate
cd /root/ca/intermediate
mkdir certs crl csr newcerts private
chmod 700 private # Gotta keep it private
touch index.txt
echo 1000 > serial # 1000 isnt required, any number is fine. 

# Will keep track of certification revocation lists. (If someone was denied) 
echo 1000 > crlnumber

# Retrieving Conf file
curl https://jamielinux.com/docs/openssl-certificate-authority/_downloads/intermediate-config.txt > openssl.cnf

# Editing Conf file
nano openssl.cnf
cd /root/ca/

# Creating intermediate key
openssl genrsa -aes256 -out intermediate/private/intermediate.key.pem 4096
chmod 400 intermediate/private/intermediate.key.pem

# Creating intermediate certificate
openssl req -config intermediate/openssl.cnf -new -sha256 -key intermediate/private/intermediate.key.pem -out intermediate/csr/intermediate.csr.pem
openssl ca -config openssl.cnf -extensions v3_intermediate_ca -days 3650 -notext -md sha256 -in intermediate/csr/intermediate.csr.pem -out intermediate/certs/intermediate.cert.pem
chmod 444 intermediate/certs/intermediate.cert.pem

# Verify intermediate cert
openssl x509 -noout -text -in intermediate/certs/intermediate.cert.pem | more
openssl verify -CAfile certs/ca.cert.pem intermediate/certs/intermediate.cert.pem

# Create certificate chain 
cat intermediate/certs/intermediate.cert.pem certs/ca.cert.pem > intermediate/certs/ca-chain.cert.pem
chmod 444 intermediate/certs/ca-chain.cert.pem
