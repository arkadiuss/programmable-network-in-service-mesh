service {
  name = "payments"
  id = "payments"
  port = 13427

  check {
    id =  "Payment",
    name = "Payment status check",
    service_id = "payments",
    tcp  = "localhost:13427",
    interval = "1s",
    timeout = "1s"
  }
}