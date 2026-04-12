FROM binwiederhier/ntfy:v2.19.2

RUN apk add --no-cache bash curl yq

COPY scripts/docker_entrypoint.sh /usr/local/bin/docker_entrypoint.sh
COPY scripts/check-web.sh /usr/local/bin/check-web.sh
RUN chmod +x /usr/local/bin/docker_entrypoint.sh /usr/local/bin/check-web.sh

EXPOSE 80

ENTRYPOINT ["/usr/local/bin/docker_entrypoint.sh"]
