ARG OMBI_PACKAGE=https://github.com/Ombi-app/Ombi/releases/download/v4.0.1135/linux-x64.tar.gz

FROM alpine:3.13.2 AS builder

ARG OMBI_PACKAGE

RUN apk add --no-cache curl ca-certificates tar \
&&  curl -L -o /ombi.tar.gz "${OMBI_PACKAGE}" \
&& mkdir /ombi /storage \
&& tar xvf /ombi.tar.gz -C /ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:5.0

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /ombi /ombi
COPY --from=builder --chown=0:0 /storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
