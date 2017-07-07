# Networking and Security

To see all interface, use:

 `ifconfig`.

 You can see all you need to see.

- To see the IP address for a DNS.

`host www.example.com`

We can also get similar results with:

`nslookup www.google.com`

We can also get IP address using:

`dig www.google.com`

## Utilities:

**ping** ping to get response from an ip address.

`ping <ip address>`

`ping www.googlecom`

**traceroute**: trace the path of packets through network.

`traceroute <ip address>`

OR

`traceroute <web address>`

It will show path to the location and where failure occurs.

**arp** Address resolution protocol

MAC address is attached to network interface.

ARP is a protocol that matches IP address to MAC address.

`arp -a` would show mapping table.

We can see local route using

`route`.

Anything local goes to local default destination. External requests go to gateway addess provided.

We can also use `netstat` to see the communication on local system.

We can see routing table using `netstat -rn`.

## SSH: Secure Shell

There was older protocol called 'telnet'.

Install `openssh` using:

`sudo apt-get install openssh-server`

It is encrypted system.

**netcat** used to communicate using tcp protocol.

`nc www.google.com 80
GET / HTTP/1.1
Host: www.google.com`

We can communicate with different types of network servers using net-cat (nc).
