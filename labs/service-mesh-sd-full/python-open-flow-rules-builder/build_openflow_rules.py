#! /usr/bin/python

import json
from sys import stderr
from inf import VIRTUAL_PROXY_IP, Host, Switch, get_infrastructure

def log(level, text):
    print(f"[{level}] {text}", file=stderr)

def read_json_file(file_name):
    try:
        with open(file_name, "r") as f:
            return json.loads(f.read())
    except FileNotFoundError as e:
        return None 

def fetch_services():
    return read_json_file("responses/services.json")

def fetch_service(service_name):
    return read_json_file(f"responses/{service_name}.json")

def get_app_services(app_tag):
    services = fetch_services()
    return list(filter(lambda x: not x.endswith("proxy") and app_tag in services[x], services))

def get_host_by_name(hosts: list, name):
    fil = [h for h in hosts if h.name == name]
    return None if len(fil) == 0 else fil[0]

def get_host_by_ip(hosts: list, ip):
    fil = [h for h in hosts if h.ip == ip]
    return None if len(fil) == 0 else fil[0]

def get_instances_by_host(app_instances, host: Host):
    return [ s for s in app_instances if s["Address"] == host.ip ]


# ovs-ofctl add-flow s1 "priority=50,tcp,in_port=1,ip_dst=192.168.1.250,tp_dst=8000,action=ct(commit,zone=1,nat(dst=192.168.1.12:13427)),mod_dl_dst:00:00:00:00:00:02,output:2"
# ovs-ofctl add-flow s1 "priority=50,tcp,in_port=2,ct_state=-trk,action=ct(table=0,zone=1,nat)"
# ovs-ofctl add-flow s1 "priority=50,tcp,in_port=2,ip_dst=192.168.1.11,ct_state=+est,ct_zone=1,action=1"

def build_instance(instance, switch: Switch, port: str, src_host: Host, hosts: list):
    service_name = instance["ServiceName"]
    proxy_instances = fetch_service(service_name+"-sidecar-proxy")
    if proxy_instances == None:
        log("INFO",f"No proxy for {service_name}")
        return

    instance_proxy = [p for p in proxy_instances if p["Address"] == src_host.ip][0]
    proxy = instance_proxy["ServiceProxy"]
    for upstream in proxy["Upstreams"]:
        dst_service_name = upstream["DestinationName"]
        local_bind_port = upstream["LocalBindPort"]
        log("INFO", f"Building rules for {service_name}'s upstream {dst_service_name} on host {src_host.name} through proxy on switch {switch.name}")
        dst_instance = fetch_service(dst_service_name)[0] # no load balancing for now
        dst_address = dst_instance["Address"]
        dst_port = dst_instance["ServicePort"]
        dst_host = get_host_by_ip(hosts, dst_address)
        via_port = switch.route_table[dst_host.name]
        print(f"""ovs-ofctl add-flow {switch.name} \
"priority=60,tcp,ip_dst={VIRTUAL_PROXY_IP},tp_dst={local_bind_port},\
action=ct(commit,zone=1,nat(dst={dst_address}:{dst_port})),mod_dl_dst:{dst_host.mac},NORMAL"\
        """)
        print(f"""ovs-ofctl add-flow {switch.name} \
"priority=50,tcp,ct_state=-trk,\
action=ct(table=0,zone=1,nat)"\
        """)
        print(f"""ovs-ofctl add-flow s1 \
"priority=50,tcp,ip_dst={src_host.ip},ct_state=+est,ct_zone=1,\
action={port}"\
        """)

        

def build_switch(s: Switch, hosts, app_instances):
    log("INFO",f"Building rules for {s.name}")
    for p in s.ports:
        src_host_name = s.ports[p]
        src_host = get_host_by_name(hosts, src_host_name)
        if src_host == None:
            continue # not a host type
        host_instances = get_instances_by_host(app_instances, src_host)
        log("INFO",f"{s.name} on port {p} has {src_host.name} with {len(host_instances)} instances")
        for instance in host_instances:
            build_instance(instance, s, p, src_host, hosts)
        


def build():
    app_services_names = get_app_services("app")
    app_instances = [ i for name in app_services_names for i in fetch_service(name) ]
    inf = get_infrastructure()
    hosts = inf.hosts
    switches = inf.switches
    
    for s in switches:
        build_switch(s, hosts, app_instances)

if __name__ == "__main__":
    build()