#!/usr/bin/env bash

cd ~/AWS/dynamodb_local_latest
java -Djava.library.path=./DynamoDBLocal_lib -jar DynamoDBLocal.jar -sharedDb
