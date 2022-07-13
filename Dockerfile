FROM registry.access.redhat.com/ubi8/ubi-minimal

ARG CNI_PLUGIN_VER=v1.1.1
ARG CNI_PLUGIN_ARCH=amd64
WORKDIR /plugins
RUN curl -fsSL "https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGIN_VER}/cni-plugins-linux-${CNI_PLUGIN_ARCH}-${CNI_PLUGIN_VER}.tgz" \
  | tar xzf -

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
