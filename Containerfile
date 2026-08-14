FROM ubuntu:26.04 AS source

ADD --checksum=sha256:0e855ffd22d407e18ab5fdb575fed5f01ca119a3f91993c5f0213f15ac80b400 https://github.com/moonlight-stream/moonlight-qt/releases/download/v6.1.0/Moonlight-6.1.0-x86_64.AppImage /tmp/source

RUN chmod 0755 /tmp/source && \
    cd /tmp && \
    ./source --appimage-extract >/dev/null && \
    mkdir -p /out/usr/bin && \
    cp -a /tmp/squashfs-root/usr/. /out/usr/ && \
    install -m 0755 /tmp/squashfs-root/AppRun /out/usr/bin/moonlight

FROM ghcr.io/containerpak/gtk3:main

COPY --from=source /out/usr/ /usr/

RUN apt-get update && \
    apt-get install -y --no-install-recommends libasound2t64 libopus0 libpulse0 libsdl2-2.0-0 && \
    cpak-clean-junk
