# docker-cni-plugins

WIP Docker container and k8s daemonset to install [cni.dev
plugins](https://github.com/containernetworking/plugins) and run the
DHCP daemon (required for the IPAM DHCP plugin).

This is useful when using
[Multus](https://github.com/k8snetworkplumbingwg/multus-cni) to add additional
network interfaces to k8s containers on bare-metal/homelab networks.

## Versions

* cni.dev plugins version: v1.1.1
* docker-cni-plugins version: 0.4

* release version: 1.1.1-0.4

## TODO
- [x] use build image with working TLS ca-certs for validation
- [ ] confirm dhcp plugin handles signals
- [x] pin base images with sha tags
- [ ] add arm64 build
- [ ] reduce privileges for dhcp-daemon container
- [ ] link to example config/usage


Inspired by:
- https://github.com/OpenSourceLAN/dhcp-cni-plugin
- https://github.com/containernetworking/plugins
- https://github.com/k8snetworkplumbingwg/multus-cni
- 
