# DNS

Examples for working with DNS.  

* AWS Route 53 querying examples can be found [here](../33_awscli/ROUTE_53.md)  
* An example CoreDNS setup for testing [here](https://github.com/chrisguest75/sysadmin_examples/blob/master/07_coredns_tcpdump/README.md)  

## Tools

* Dig
* nslookup
* CoreDNS

## NOTES

### Records

DNS (Domain Name System) uses different types of records for various functions. Here are some of the commonly used record types:

* A Record (Address Record): Maps a hostname to a 32-bit IPv4 address.

* AAAA Record (Quad A Record): Maps a hostname to a 128-bit IPv6 address.

* CNAME Record (Canonical Name Record): Used to alias one name to another. For example, www.example.com might be an alias for example.com.

* MX Record (Mail Exchange Record): Directs email to a mail server. It also contains a priority value to manage multiple mail servers for a single domain.

* NS Record (Name Server Record): Delegates a DNS zone to use the given authoritative name servers.

* PTR Record (Pointer Record): Provides the reverse DNS lookup, mapping an IP address to a hostname.

* SOA Record (Start of Authority Record): Contains information about the DNS zone, like the primary name server, the email of the domain administrator, the domain serial number, and several timers relating to refreshing the zone.

* SRV Record (Service Record): Defines the location, i.e., the hostname and port number, of servers for specified services.

* TXT Record (Text Record): Typically used to hold machine-readable data, like SPF data to prevent email spam, or domain ownership verification for services like Google Webmaster Tools.

* CAA Record (Certification Authority Authorization): Allows a DNS domain name holder to specify one or more Certification Authorities (CAs) authorized to issue certificates for that domain.

* DS Record (Delegation Signer): Used to secure delegations in DNSSEC.

### Public & Private

Public DNS servers generally don't give out private IP addresses in response to DNS queries.

Private IP addresses are within specific ranges defined by the Internet Assigned Numbers Authority (IANA) and are meant to be used within private networks, such as local area networks (LANs) inside a home, business, or organization. These include:

* 10.0.0.0 to 10.255.255.255 (10.0.0.0/8)
* 172.16.0.0 to 172.31.255.255 (172.16.0.0/12)
* 192.168.0.0 to 192.168.255.255 (192.168.0.0/16)

### Protocols

* UDP (User Datagram Protocol): DNS primarily uses UDP for communication between servers. It's the default protocol, and for most of the typical DNS queries, you'll find it in use. The reason for this is that UDP is a connectionless protocol, which makes it faster than TCP because it doesn't require a handshake to establish a connection. However, UDP is limited to 512 bytes in the payload size of the packet (excluding IPv6 jumbograms), which means larger DNS packets have to be handled differently.

* TCP (Transmission Control Protocol): DNS uses TCP for tasks that can't be accomplished with UDP. This includes zone transfers, where entire zones are transferred between servers, and cases where the response data size exceeds 512 bytes (UDP's limit). TCP is connection-based, so it's more reliable (it provides data receipt confirmation and re-transmission in case of lost packets), but it's also slower than UDP because of the time it takes to establish a connection.

### NXDOMAIN

NXDOMAIN stands for "Non-Existent Domain." It is a DNS response code that the domain name queried does not exist. This might mean that the domain has never been registered or that it was once active but has been deleted.  

## Troubleshooting

* If missing an answer section when using `dig`.  Check if the DNS server is public or private? Then connect to the VPN if private. 😊  

## DNS Server

```sh
# macos get my current dns server
scutil --dns
```

## Dig

```sh
dig -h
```

### TXT

```sh
# Get a TXT record 
dig TXT google.com    

dig @8.8.8.8 -p 53 google.com TXT
dig @1.1.1.1 -p 53 google.com TXT
```

### IPV6

```sh
# google has an ipv6 endpoint
open https://ipv6.google.com/

# look for AAAA records
dig ipv6.google.com
dig www.google.com AAAA
```

## nslookup

```sh
nslookup google.com
```

## Resources

* DNS RR [here](https://www.netmeister.org/blog/dns-rrs.html)  
* Alpine Linux 3.18 fixes DNS over TCP issue [here](https://www.theregister.com/2023/05/16/alpine_linux_318/)  
* eCHO episode 7: DNS with Laurent Bernaille [here](https://www.youtube.com/watch?v=mo0RIJZypbQ)  
* Anatomy of a Linux DNS Lookup – Part I-IV [here](https://zwischenzugs.com/2018/06/08/anatomy-of-a-linux-dns-lookup-part-i/)  
* root-servers.org [here](https://root-servers.org/)  
