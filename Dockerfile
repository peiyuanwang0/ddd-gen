FROM node:20.14-bullseye

ARG TARGETPLATFORM
RUN if [ "$TARGETPLATFORM" = "linux/amd64" ]; then ARCHITECTURE=amd64; elif [ "$TARGETPLATFORM" = "linux/arm/v7" ]; then ARCHITECTURE=arm; elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then ARCHITECTURE=aarch64; else ARCHITECTURE=amd64; fi \
    && wget -v "https://github.com/nushell/nushell/releases/download/0.93.0/nu-0.93.0-${ARCHITECTURE}-linux-gnu-full.tar.gz" -O "/tmp/nu-0.93.0-${ARCHITECTURE}-linux-gnu-full.tar.gz" \
    && tar xzf "/tmp/nu-0.93.0-${ARCHITECTURE}-linux-gnu-full.tar.gz" -C /usr/local/bin/ --strip-components 1 \
    && chmod +x /usr/local/bin/nu* \
    && rm -rf "/tmp/nu-0.93.0-${ARCHITECTURE}-linux-gnu-full.tar.gz"

WORKDIR /gen

CMD ["tail", "-f", "/dev/null"]