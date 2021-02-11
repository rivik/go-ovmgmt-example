package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"time"

	"github.com/rivik/go-aux/pkg/appver"
	"github.com/rivik/go-ovmgmt/ovmgmt"
)

const OVmgmtEventsChanSize = 1_000

var (
	addr        string
	printAppVer bool
)

var (
	ovm     *ovmgmt.MgmtClient
	eventCh chan ovmgmt.Event
)

var logger = log.New(os.Stderr, "main:", log.LUTC|log.Ldate|log.Ltime|log.Lmicroseconds|log.Lmsgprefix)

func init() {
	flag.BoolVar(&printAppVer, "version", false, "print app version and exit")

	flag.StringVar(&addr, "ovpn", "/var/run/openvpn-server/mgmt.sock", "addr:port or sock path of openvpn management interface")
	flag.Parse()
}

func main() {
	if printAppVer {
		fmt.Printf("%+v\n", appver.Version)
		return
	}

	ovmgmt.SetLogger(logger)

	eventCh = make(chan ovmgmt.Event, OVmgmtEventsChanSize)

	var err error
	ovm, err = ovmgmt.Dial(addr, eventCh)
	if err != nil {
		log.Fatal(err)
	}

	ovm.SetStatus3Events(5 * time.Second)
	_ = ovm.SetByteCountEvents(5 * time.Second)

	//go func() {
	for evt := range eventCh {
		fmt.Fprintf(os.Stderr, "RECEIVED EVENT: %s\n", evt)
	}
	//}()
}
