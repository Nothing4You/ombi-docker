FROM curlimages/curl:7.84.0@sha256:5a2a25d96aa941ea2fc47acc50122f7c3d007399a075df61a82d6d2c3a567a2b AS builder

# renovate: datasource=github-releases depName=Ombi-app/Ombi
ENV OMBI_VERSION=v4.25.0

RUN curl -L -o /home/curl_user/ombi.tar.gz "https://github.com/Ombi-app/Ombi/releases/download/${OMBI_VERSION}/linux-x64.tar.gz" \
&& mkdir /home/curl_user/ombi /home/curl_user/storage \
&& tar xvf /home/curl_user/ombi.tar.gz -C /home/curl_user/ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:7.0@sha256:5244ffdab9eabea1c955343af5616039e92f17e1d1b5235bc3fa5a1af81e6e4a

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /home/curl_user/ombi /ombi
COPY --from=builder --chown=0:0 /home/curl_user/storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
