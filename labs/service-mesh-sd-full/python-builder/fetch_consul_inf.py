#! /usr/bin/python

import requests

consul_address="http://localhost:8500"

def cache(file_name, content):
    print(f"Caching: {file_name}")
    with open(f"responses/{file_name}.json", "w") as f:
        f.write(content)

def fetch_services():
    services = requests.get(consul_address + "/v1/catalog/services")
    cache("services", services.text)
    return services.json().keys()

def fetch_service(service_name):
    service = requests.get(consul_address + f"/v1/catalog/service/{service_name}").text
    cache(service_name, service)
    return service

def main():
    services = fetch_services()
    for service_name in services:
        service = fetch_service(service_name)
        print(f"Cached: {service_name}")

if __name__ == "__main__":
    main()