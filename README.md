# HTTP Lab 1: Virtual Hosts / Jose Antonio Santiago Cabrera

Name-based virtual hosts with Apache on a Debian 12 virtual machine, plus an
authoritative DNS server (BIND9) for the domain `olimpo.test`. The whole
environment is deployed with Vagrant.

## Network layout

| Machine | Vagrant name | Role | Address |
|---|---|---|---|
| `ns1.olimpo.test` | `dns` | DNS server (master) | 192.168.57.10/24 |
| `mercurio.olimpo.test` | `web` | Apache web server | 192.168.57.11/24 |

Both machines use `ns1` as their DNS server and the search suffix `olimpo.test`.

## DNS configuration summary

- Authoritative for `olimpo.test` and for the reverse zone `57.168.192.in-addr.arpa`.
- `dnssec-validation yes` and forwarder `1.1.1.1` (Cloudflare).
- Aliases (CNAME): `apolo.olimpo.test` and `atenea.olimpo.test` point to `mercurio.olimpo.test`.

## Virtual hosts summary

| | apolo.olimpo.test | atenea.olimpo.test |
|---|---|---|
| Document root | `/var/www/apolo.olimpo.test` | `/var/www/atenea.olimpo.test` |
| Directory listing | allowed (inherited from `/var/www/`) | not allowed (`Options -Indexes`) |
| Error 403 | custom message | custom message |
| Error 404 | `messages/404.html` | `messages/404.html` |
| Log files | `apolo.olimpo.test.{access,error}.log` | `atenea.olimpo.test.{access,error}.log` |

## Repository structure

```
.
├── Vagrantfile                 # dns and web machines
├── dns-provision.sh            # provisioning of the DNS server
├── apache2-provision.sh        # provisioning of the web server
├── weblab-1-en.hurl            # HURL test file (provided by the instructor)
├── files/
│   ├── apolo.olimpo.test/      # document root of apolo
│   ├── atenea.olimpo.test/     # document root of atenea
│   ├── mercurio.olimpo.test/   # Apache configuration and resolv.conf
│   └── ns1.olimpo.test/        # BIND configuration and zone files
└── doc/                        # documentation of each step, with commands and outputs
    └── img/                    # screenshots
```

## How to run it

```bash
vagrant up
```

This creates the `dns` machine first and then `web`.

## Testing

DNS (from both machines): `dig apolo.olimpo.test +short` and
`nslookup atenea.olimpo.test`.

Web: open `http://apolo.olimpo.test` and `http://atenea.olimpo.test` in a
browser, and run the HURL test file:

```bash
hurl --test weblab-1-en.hurl
```

## Documentation

| Step | Document |
|---|---|
| 1. Initial deployment | [doc/01-initial-setup.md](doc/01-initial-setup.md) |
| 2. DNS checks | [doc/02-dns-checks.md](doc/02-dns-checks.md) |
## Status

- [ ] DNS server and aliases
- [ ] apolo.olimpo.test virtual host
- [ ] atenea.olimpo.test virtual host
- [ ] HURL test
- [ ] Deployment from scratch with `vagrant up`