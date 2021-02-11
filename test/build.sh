#!/bin/bash
set -euxo pipefail

cd "test/ovpn-testenv-docker"
docker build --tag local/testenv-openvpn:latest -f Dockerfile .
