# Networking and Firewalls

Each hosts talk to other hosts and applications using networking. A firewall is a series of rules that control access to host through the network. Netfilter is a firewall common to all Linux distributions. To write firewall rules, Netfilter's management interface, iptables is used. **iptables** is used to protect network services.

Networks are made up of hardwares and softwares and it can be complex. STartups will have DHCP, DNS, file, mail and web server all rolled into one. As business grows, it will probably begin to move some of the combined function to its own hosts. 

There are a few ways you can assign an IP address to a computer. It can be configured manually or allowing it to request a random IP in a pool addresses. For important IP addresses like network gateways, this should be configured manually.

In IP like 192.168.10.0/24 address, this is IPv4. Now these IP addresses are limited and that's how the idea of carving up the address space into smaller chunks, or subnetting came about. IPv4 are made up of 32 binary bits only and they are broken into 4 octets. Each position in each octet represents a value with the leading position 128. Total of all those bits equal to 255. A network address is made up of Network ID and a host. First 24 bits of the address is Network ID.

With IPv6 each address cahracter we see is actually 4 bits. fe80::a00:27ff:fea4:da6b/64 is an example of IPv6 addresss. The full IPv6 address is 128 bits. IPv6 is intended to be world routable, unlike the private address space we are using in IPv4. For example, when we configure network for our virtual cluster, we have to use Source Network Address Translation (SNAT) to route our connections originating from our private address space into the world routable public address space. In IPv6, the full IP address is made up of local link address and network address and will always be unique.

In this lesson, we will configure headoffice.example.com as mail, web and DNS service to the public and will use gateway.example.com firewall host to accept and route traffic from the Internet thorugh our internal network to our main host.

**Network interface** will be available on each of the network card on hosts. Interfaces are generally in two major states - up means active and down means not connected to the network. An interface can have many aliases or we can bond or team two or more interfaces together to appear as one interface. Linux allows to have multiple IP on a single interface. The interface uses same mac address for all IP addresses. A bonded interface consists of two or more network interfaces appearing as a single interface. This can be used to provide greater fault tolerance or increased bandwidth for the interface. `iproute` on CentOS can be used to view or change the status and configuration of interfaces. The `ip` command is a powerful utlity and can be used to configure all networking. Type `ip help` to get a list of different components we can manage.

Here is a list of objects we can work with `ip` command.

| Object | Description |
|:------|:-------------|
| link | network device |
| address | address of the interface IPv4 or IPv6 |
| addrlabel | allows to apply labels to addresses |
| l2tp | tunneling Ethernet over IP |
| maddress | Multicast address |
| monitor | netlink message monitoring |
| mroute | multicast routing cache entry |
| mrule | managing rules in multicast routing policy | 
|  neighbor | ARP or NDISC cache entry |
|netns | manage network namespaces |
| ntable | manage the neighbor cache's operation |
| route | routint table entry |
| rule | Rule in the routing policy database |
| tcp_metrics | manage tcp metrics |
| tunnel | Tunnel over IP |
| tuntap | Manage TUN/TAP devices |


`ip address show` displays all interfaces on host and their current status and configuration. This command shows the status of interface. The number 2 is just an ordering number. In between <> are the interface flags. BROADCAST means we can send traffic to all other hosts on the link, MULTICAST means we can send and receive multicast packets, UP means the device is functioning. LOWER UP indicates that the cable or underlying link is up. This means that interface can receive traffic if it is properly configured. The output also shows ipv4 address, ipv6 address and MAC (Media Access Control) address of this host.

The IPv6 address can be used to communicate with other hosts using stateless address autoconfiguration (SLAAC). SLAAC is used quite often by devices like PDAs and mobile phones which require a less complicated infrastructure to communicate with other devices on the local network. 

If we see an output with only MAC address assigned and interface not up, we can enable it using `sudo ip link set dev enp0s8 up`. This makes device enp0s8 up. To remove an interface, we can issue `sudo ip addr del 192.168.10.1/24 enp0s8`

CentOS uses NetworkManager to manage its networks. NetworkManager is a daemon process that manages the network connections and services. NetworkManager integrates and configures Domain Name System (DNS) resolution via the Dnsmasq program and handles configuring and setting up VPN and wireless connections. The management of these interfaces via NetworkManager can be disabled  by setting the NM_CONTROLLED='no' in the network connection profile file. NetworkManager provides CLI for configuration. `nmcli` controls and reports status of NetworkManager. `nmtui` is text based interface for managing NetworkManager. We can manually configure network or they can be configured automatically using DHCP.

We can find device name for new interface with the use of `dmesg`.

`sudo dmesg | grep enp`

To start configuration using nmtui, use `sudo nmtui`. Different devices get their names from the helper utility. Systemd provides names from this if the biosdevname is not available. 

eno1 - onboard devices
ens1 - PCI slot index number
enp0s8 - physical location of the connector
enx7f91992 - combining the MAC address
eth0 - the classic

There is another way to configure network interfaces with `nmcli` tool. To display the current connection information using nmcli,

```shell
sudo nmcli connection show
# to actually check the device status 
sudo nmcli d status # shortcut d for device
# to manage connection use connection suboptions
# to see help for adding connection.
nmcli connection add help
```

CentOS stores network configuration files in `/etc/sysconfig/network-scripts` and Ubuntu stores under the `/etc/networks` directory.

### Network Configuration files

The main places to find information for networking are `/etc/sysconfig/network` file and `/etc/syconfig/network-scripts` directory. The file contains global settigns like HOSTNAME and default GATEWAY.