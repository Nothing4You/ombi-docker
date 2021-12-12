ARG OMBI_PACKAGE=https://github.com/Ombi-app/Ombi/releases/download/v4.0.1446/linux-x64.tar.gz

FROM curlimages/curl:7.80.0 AS builder

ARG OMBI_PACKAGE

RUN curl -L -o /home/curl_user/ombi.tar.gz "${OMBI_PACKAGE}" \
&& mkdir /home/curl_user/ombi /home/curl_user/storage \
&& tar xvf /home/curl_user/ombi.tar.gz -C /home/curl_user/ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:5.0

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /home/curl_user/ombi /ombi
COPY --from=builder --chown=0:0 /home/curl_user/storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
