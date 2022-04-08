#! /usr/bin/python

import json

def read_json_file(file_name):
    with open(file_name, "r") as f:
        return json.loads(f.read())

def fetch_services():
    return read_json_file("responses/services.json")

def fetch_service(service_name):
    return read_json_file(f"responses/{service_name}.json")

def get_app_services(app_tag):
    services = fetch_services()
    return list(filter(lambda x: not x.endswith("proxy") and "app" in services[x], services))

def main():
    app_services = get_app_services("app")
    print(app_services)

if __name__ == "__main__":
    main()