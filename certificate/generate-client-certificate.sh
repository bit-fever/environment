#!/bin/sh
 
# Create a key for the client
openssl genrsa -out client.key 2048

# Generate the Certificate Signing Request 
openssl req -new -key client.key -out client.csr -subj "/C=EU/ST=Italy/L=Rome/O=BitFever/OU=BitFeverClient/CN=bitfever-server"

# Sign it with the CA

echo "subjectAltName=DNS:bitfever-server" > altsubj.ext

openssl x509  -req -in client.csr \
    -CA ca.crt -CAkey ca.key \
    -days 20000 -sha256 -CAcreateserial \
    -extfile altsubj.ext \
    -out client.crt 

rm altsubj.ext
 

