#! /usr/bin/env bash
openssl req -x509 -newkey rsa:2048 -sha256 -nodes -keyout security.pem -out security.crt -subj "/CN=*.$1" -days 365
openssl pkcs12 -export -out security.pfx -inkey security.pem -in security.crt -passout pass:foobar
rm security.pem
rm security.crt