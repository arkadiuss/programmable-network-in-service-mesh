#! /usr/bin/python


class Host:
    def __init__(self, name, ip, mac):
        self.name = name
        self.ip = ip
        self.mac = mac

class Switch:
    def __init__(self, name, ports, route_table):
        self.name = name
        self.ports = ports
        self.route_table = route_table

H1 = "h1"
H2 = "h2"
H3 = "h3"
DB1 = "db1"
S1 = "s1"
S2 = "s2"
S3 = "s3"

VIRTUAL_PROXY_IP = "192.168.1.250"

class Infrastructure:
    def __init__(self, hosts: list, switches: list):
        self.hosts = hosts
        self.switches = switches

def get_infrastructure() -> Infrastructure:
    return Infrastructure([
            Host(H1, "192.168.1.11", "00:00:00:00:00:01"),
            Host(H2, "192.168.1.12", "00:00:00:00:00:02"),
            Host(H3, "192.168.1.13", "00:00:00:00:00:03"),
            Host(DB1, "192.168.1.21", "00:00:00:00:00:04"),
        ], [
            Switch("s1", {
                1: H1,
                2: H2,
                3: S3
            }, {
                H1: 1,
                H2: 2,
                H3: 3,
                DB1: 3
            }),
            Switch("s2", {
                1: H3,
                2: DB1,
                3: S3
            }, {
                H1: 3,
                H2: 3,
                H3: 1,
                DB1: 2
            }),
            Switch("s3", {
                1: S1,
                2: S2,
                3: "consul"
            }, {
                H1: 1,
                H2: 1,
                H3: 2,
                DB1: 2
            }),
        ])

def main():
    print(get_infrastructure())