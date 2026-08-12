FROM ghcr.io/containerpak/gtk:main

ADD --checksum=sha256:0e855ffd22d407e18ab5fdb575fed5f01ca119a3f91993c5f0213f15ac80b400 https://github.com/moonlight-stream/moonlight-qt/releases/download/v6.1.0/Moonlight-6.1.0-x86_64.AppImage /tmp/source

RUN apt-get update && \
    apt-get install -y --no-install-recommends fuse3 libasound2t64 libopus0 libpulse0 libsdl2-2.0-0 && \
    chmod +x /tmp/source && cd /tmp && ./source --appimage-extract >/dev/null && cp -a /tmp/squashfs-root/usr/. /usr/ && install -m 0755 /tmp/squashfs-root/AppRun /usr/bin/moonlight && \
    cpak-clean-junk
