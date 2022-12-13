FROM curlimages/curl:7.85.0@sha256:9fab1b73f45e06df9506d947616062d7e8319009257d3a05d970b0de80a41ec5 AS builder

# renovate: datasource=github-releases depName=Ombi-app/Ombi
ENV OMBI_VERSION=v4.33.0

RUN curl -L -o /home/curl_user/ombi.tar.gz "https://github.com/Ombi-app/Ombi/releases/download/${OMBI_VERSION}/linux-x64.tar.gz" \
&& mkdir /home/curl_user/ombi /home/curl_user/storage \
&& tar xvf /home/curl_user/ombi.tar.gz -C /home/curl_user/ombi/

FROM mcr.microsoft.com/dotnet/runtime-deps:7.0@sha256:ae91cd61f955aff607406ed965940dc6fff0dbacc6f13b7f4fc533f619de1153

LABEL org.opencontainers.image.source https://github.com/Nothing4You/ombi-docker

COPY --from=builder --chown=0:0 /home/curl_user/ombi /ombi
COPY --from=builder --chown=0:0 /home/curl_user/storage /storage

WORKDIR /ombi

ENTRYPOINT ["/ombi/Ombi", "--storage", "/storage"]
