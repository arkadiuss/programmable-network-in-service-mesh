service {
  name = "frontend"
  id = "frontend"
  port = 17564

  check {
     id =  "Frontend",
     name = "Frontend status check",
     service_id = "frontend",
     tcp  = "localhost:17564",
     interval = "1s",
     timeout = "3s"
  }
}