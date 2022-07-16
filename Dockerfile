FROM debian:stable-slim@sha256:b39539708b62ae6810c07d164781ec48e411368f088b3112b5e3113e0ad5bf5b AS build

ARG CNI_PLUGIN_VER=v1.1.1
ARG CNI_PLUGIN_ARCH=amd64
ENV baseURL=https://github.com/containernetworking/plugins/releases/download/${CNI_PLUGIN_VER}
ENV destFile=cni-plugins-linux-${CNI_PLUGIN_ARCH}-${CNI_PLUGIN_VER}.tgz
ENV shaFile=${destFile}.sha512
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /tmp
RUN apt update -y \
 && apt install -y --no-install-recommends \
      ca-certificates \
      wget \
 && wget -q "$baseURL/$destFile" -O "$destFile" \
 && wget -q "$baseURL/$shaFile" -O "$shaFile" \
 && sha512sum -c "$shaFile" \
 && mkdir /plugins \
 && tar xzf "$destFile" -C /plugins \
 && rm "$destFile" "$shaFile"

FROM busybox:stable@sha256:dcdf379c574e1773d703f0c0d56d67594e7a91d6b84d11ff46799f60fb081c52 AS deploy

WORKDIR /plugins
COPY --from=build /plugins /plugins
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

LABEL cni.dev.plugins.version=$CNI_PLUGIN_VER
