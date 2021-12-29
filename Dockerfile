FROM curlimages/curl:7.80.0@sha256:d588ff348c251f8e4d1b2053125c34d719a98ff3ef20895c49684b3743995073 AS builder

# renovate: datasource=github-tags depName=Ombi-app/Ombi
ENV OMBI_VERSION=v4.8.0

RUN curl -L -o /home/curl_user/ombi.tar.gz "https://github.com/Ombi-app/Ombi/releases/download/${OMBI_VERSION}/linux-x64.tar.gz" \
&& mkdir /home/curl_user/ombi /home/curl_user/storage \
&& tar xvf /home/curl_user/ombi.tar.gz -C /home/curl_user/ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:6.0@sha256:f55d8bf7c4a23730c02a1635b4f976c05bf7fcd27d78f5d8d9cf64d96e511ef4

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /home/curl_user/ombi /ombi
COPY --from=builder --chown=0:0 /home/curl_user/storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
