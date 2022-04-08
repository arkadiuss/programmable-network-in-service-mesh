service {
  name = "product-db"
  id = "product-db"
  port = 5432
  tags = ["app"]


  check {
    id =  "Product DB"
    name = "Product DB status check"
    service_id = "product-db"
    tcp  = "localhost:5432"
    interval = "1s"
    timeout = "1s"
  }

}