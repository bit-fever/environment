#!/bin/sh
 
# Create a key for the server
openssl genrsa -out server.key 2048

# Generate the Certificate Signing Request 
openssl req -new -key server.key -out server.csr -subj "/C=EU/ST=Italy/L=Rome/O=BitFever/OU=BitFeverServer/CN=bitfever-server" 

# Sign it with the CA

echo "subjectAltName=DNS:bitfever-server" > altsubj.ext

openssl x509  -req -in server.csr \
    -CA ca.crt -CAkey ca.key \
    -days 20000 -sha256 -CAcreateserial \
    -extfile altsubj.ext \
    -out server.crt 

rm altsubj.ext

#-newkey rsa:2048 -nodes 
