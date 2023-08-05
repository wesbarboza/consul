services {
    name = "web"
    tags = [
        "web-server"
    port = 80
    ]
}

services {
    name = "proxy"
    tags = [
        "proxy-server"
    ]
    port = 3128
    address = "10.1.1.1",
}