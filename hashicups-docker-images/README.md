This is a reference architecture on which I'm going to implement proposed service mesh concept. It leverages HashiCorp's demo-app because it is a great example of modern microservices application. Services are "randomly" distributed between hosts. One docker container simulates on node in a datacenter network. More info in the thesis.

To run the app:
```
docker-compose up
```

Best proof it works:
```
sudo docker exec <container_id> curl -Ss -X POST localhost:20863/api -H "Content-Type: application/json" --data '{"operationName":"GetCoffees", "variables":{},"query":"query GetCoffees {\n  coffees {\n    id\n    name\n    image\n    __typename\n  }\n}"}'
```