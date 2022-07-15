FROM busybox:stable

ARG CNI_PLUGIN_VER=v1.1.1
ARG CNI_PLUGIN_ARCH=amd64
ENV baseURL=https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGIN_VER}
ENV destFile=cni-plugins-linux-${CNI_PLUGIN_ARCH}-${CNI_PLUGIN_VER}.tgz
ENV shaFile=${destFile}.sha512

WORKDIR /tmp
RUN wget -q "$baseURL/$destFile" -O "$destFile" \
 && wget -q "$baseURL/$shaFile" -O "$shaFile" \
 && sha512sum -c "$shaFile" \
 && mkdir /plugins \
 && tar xzf "$destFile" -C /plugins \
 && rm "$destFile" "$shaFile"

WORKDIR /plugins
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

LABEL cni.dev.plugins.version=$CNI_PLUGIN_VER
