FROM curlimages/curl:8.2.1@sha256:bb0843a1307b1aa73f65f24379d11dde881c16db62ba50810de0c64d48e740ed AS builder

# renovate: datasource=github-releases depName=Ombi-app/Ombi
ENV OMBI_VERSION=v4.45.0

RUN curl -L -o /home/curl_user/ombi.tar.gz "https://github.com/Ombi-app/Ombi/releases/download/${OMBI_VERSION}/linux-x64.tar.gz" \
&& mkdir /home/curl_user/ombi /home/curl_user/storage \
&& tar xvf /home/curl_user/ombi.tar.gz -C /home/curl_user/ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:7.0@sha256:711cdb90ab771b2c90f9aae2178777e71deff6076b965b6ac86d30613acfea6d

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /home/curl_user/ombi /ombi
COPY --from=builder --chown=0:0 /home/curl_user/storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
