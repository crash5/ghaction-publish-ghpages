FROM alpine/git:latest

COPY script.sh /

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
