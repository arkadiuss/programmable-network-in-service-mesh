service {
  name = "public-api"
  id = "public-api"
  port = 20863

  check {
    id =  "Public_API_Check",
    name = "public-api status check",
    service_id = "public-api",
    tcp  = "localhost:20863",
    interval = "1s",
    timeout = "1s"
  }
}