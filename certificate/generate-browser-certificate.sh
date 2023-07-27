#!/bin/sh
 
# Create a key for the client
openssl genrsa -out browser.key 2048

# Generate the Certificate Signing Request 
openssl req -new -key browser.key -out browser.csr -subj "/C=EU/ST=Italy/L=Rome/O=BitFever/OU=BitFeverBrowser/CN=bitfever-server"

# Sign it with the CA

echo "subjectAltName=DNS:bitfever-server" > altsubj.ext

openssl x509  -req -in browser.csr \
    -CA ca.crt -CAkey ca.key \
    -days 20000 -sha256 -CAcreateserial \
    -extfile altsubj.ext \
    -out browser.crt 

rm altsubj.ext

openssl pkcs12 -export -inkey browser.key -in browser.crt -out browser.p12
