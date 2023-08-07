# consul

## Consul Cluster - Service Mesh

### Register service on client

Create a file on */etc/consul.d*

```bash
vim web.hcl
```

```hcl
services {
    name = "web"
    tags = [
        "web-server"
    port = 80
    ]
}
```

Restart agent

```bash
systemctl restart consul
```

On server node list catalog:

```bash
consul catalog services
```

```bash
dig @127.0.0.1 -p 80 web.service.consul
```

### Register service on server node  

create file:

```bash
vim proxy.hcl
```

```hcl
services {
    name = "proxy"
    tags = [
        "proxy-server"
    ]
    port = 3128
    address = "10.1.1.1",
}
```

## register

```bash
consul services register proxy.hcl
```

## deregister  

```bash
consul services deregister proxy.hcl
```

### Register service API

create a json:

```bash
vim apache.json
```

```json
{
    "ID": "apachepayload",
    "Name": "apache",
    "Tags": ["main", "v2.2"],
    "Address": "10.1.1.1",
    "Port": 8000
}
```

```bash
curl -X PUT -d @apache.json http://127.0.0.1:8500/v1/agent/service/register
```

if curl returns error, ensure the configuration file contains this line:

```text
enable_script_checks = true
```

check

```bash
dig @127.0.0.1 -p 8600 main.apache.service.consul
```

## Deregister via API  

```bash
curl -X PUT http://127.0.0.1:8500/v1/agent/service/deregister/apachepayload
```

## Consul Connect is Service Mesh  
