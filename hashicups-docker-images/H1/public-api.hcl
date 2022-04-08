service {
  name = "public-api"
  id = "public-api"
  port = 20863
  tags = ["app"]

  check {
    id =  "Public_API_Check"
    name = "public-api status check"
    service_id = "public-api"
    tcp  = "localhost:20863"
    interval = "1s"
    timeout = "1s"
  }
  
  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "payments"
            local_bind_port = 9340
          },
          {
            destination_name = "product-api"
            local_bind_port = 9341
          }
        ]
      }
    }
  }
}