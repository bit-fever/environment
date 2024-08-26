#!/bin/sh

# Create a key for the CA
openssl genrsa -out ca.key 2048

# Generate CA certificate 
openssl req -new -x509 -days 20000 -key ca.key -subj "/C=EU/ST=Italy/L=Rome/O=BitFever/CN=bitfever.com" -out ca.crt
