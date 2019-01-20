FROM alpine
RUN apk update && \
    apk upgrade && \
    apk add --no-cache bash git openssh
COPY entrypoint /usr/bin/entrypoint
ENTRYPOINT [ "entrypoint" ]