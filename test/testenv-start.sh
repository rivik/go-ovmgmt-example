#!/bin/bash
set -euxo pipefail

./test/build.sh

./test/run-server.sh

./test/run-client.sh client1
./test/run-client.sh client2

echo "testenv started"
