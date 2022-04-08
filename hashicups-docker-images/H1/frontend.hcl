service {
  name = "frontend"
  id = "frontend"
  port = 17564
  tags = ["app"]

  check {
    id =  "Frontend"
    name = "Frontend status check"
    service_id = "frontend"
    tcp  = "localhost:17564"
    interval = "1s"
    timeout = "3s"
  }

  connect {
    sidecar_service {
      proxy {
        upstreams = [
          {
            destination_name = "public-api"
            local_bind_port = 9191
          }
        ]
      }
    }
  }
}