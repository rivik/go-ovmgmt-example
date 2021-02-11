#!/bin/bash
set -euxo pipefail

. test/ovpn-common.sh
docker kill -sINT "$cname.ovpn-client1"
docker kill -sINT "$cname.ovpn-client2"
docker kill -sINT "$cname.ovpn-server"

set +e
docker stop "$cname.ovpn-client1"
docker stop "$cname.ovpn-client2"
docker stop "$cname.ovpn-server"
