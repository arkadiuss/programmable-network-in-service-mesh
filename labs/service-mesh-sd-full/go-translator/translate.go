package main

import (
	"fmt"
	"os"

	"github.com/hashicorp/hcl"
)

// HCL types start

type Upstream struct {
	DestinationName string `hcl:"destination_name"`
	LocalBindPort   string `hcl:"local_bind_port"`
}

type Proxy struct {
	Upstreams []Upstream `hcl:"upstreams"`
}

type SidecarService struct {
	Proxy Proxy `hcl:"proxy"`
}

type Connect struct {
	SidecarService SidecarService `hcl:"sidecar_service"`
}

type Service struct {
	Id   string `hcl:"id"`
	Name string `hcl:"name"`
	Port string `hcl:"port"`

	Connect Connect `hcl:"connect"`
}

type ConsulRegistration struct {
	Service Service `hcl:"service"`
}

// HCL types end

// HOST types start

type HostService struct {
	Name string
	Port string
}

type Host struct {
	IP         string
	MACADdress string

	Services []HostService
}

// HOST types ends

func main() {
	// hosts := [4]Host{
	// 	Host{"192.168.1.11", "00:00:00:00:00:01", []HostService{
	// 		HostService{"frontend", ""},
	// 		HostService{"public-api", ""},
	// 	}},
	// 	Host{"192.168.1.12", "00:00:00:00:00:02", []HostService{
	// 		HostService{"frontend", ""},
	// 		HostService{"public-api", ""},
	// 	}},
	// 	Host{"192.168.1.13", "00:00:00:00:00:03", []HostService{
	// 		HostService{"frontend", ""},
	// 		HostService{"public-api", ""},
	// 	}},
	// 	Host{"192.168.1.14", "00:00:00:00:00:04", []HostService{
	// 		HostService{"db", ""},
	// 	}},
	// }

	var t ConsulRegistration
	dat, err := os.ReadFile("./frontend.hcl")
	err = hcl.Decode(&t, string(dat))
	fmt.Println(t, err)

}
