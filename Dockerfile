FROM curlimages/curl:7.82.0@sha256:c1c1cda72ab8c306390fc05518bf4d42148564978326d078f65d546858d139cb AS builder

# renovate: datasource=github-releases depName=Ombi-app/Ombi
ENV OMBI_VERSION=v4.16.11

RUN curl -L -o /home/curl_user/ombi.tar.gz "https://github.com/Ombi-app/Ombi/releases/download/${OMBI_VERSION}/linux-x64.tar.gz" \
&& mkdir /home/curl_user/ombi /home/curl_user/storage \
&& tar xvf /home/curl_user/ombi.tar.gz -C /home/curl_user/ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:7.0@sha256:9b109ddf1673d7094ff080a8162461f7e968978e9585cb60a218a4ebdf6dea76

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /home/curl_user/ombi /ombi
COPY --from=builder --chown=0:0 /home/curl_user/storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
