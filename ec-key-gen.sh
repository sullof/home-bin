#!/usr/bin/env bash

# If you don't have done yet, install sha3sum. On Mac:
#    brew install sha3sum

# Generate the private and public keys
openssl ecparam -name secp256k1 -genkey -noout |
  openssl ec -text -noout > Key

# Extract the public key and remove the EC prefix 0x04
cat Key | grep pub -A 5 | tail -n +2 |
            tr -d '\n[:space:]:' | sed 's/^04//' > pub

# Extract the private key and remove the leading zero byte
cat Key | grep priv -A 3 | tail -n +2 |
            tr -d '\n[:space:]:' | sed 's/^00//' > priv

# Generate the hash and take the address part
cat pub | keccak-256sum -x -l | tr -d ' -' | tail -c 41 > address
