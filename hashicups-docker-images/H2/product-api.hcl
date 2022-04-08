service {
  name = "product-api"
  id = "product-api"
  port = 19572
  tags = ["app"]
 
  check {
     id =  "Product API",
     name = "Product API status check",
     service_id = "product-api",
     tcp  = "localhost:19572",
     interval = "1s",
     timeout = "3s"
  }

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "product-db"
            local_bind_port = 9567
          }
        ]
      }
    }
  }
}