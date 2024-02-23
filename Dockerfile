FROM docker.io/debian:bullseye AS builder

RUN apt-get update -y && \
    apt-get install -y texlive texlive-formats-extra make git

WORKDIR /build/

COPY . /build/

RUN make

FROM docker.io/nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /build/csh-slack.pdf /usr/share/nginx/html/csh-slack.pdf

