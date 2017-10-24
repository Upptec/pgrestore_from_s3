FROM alpine:3.6
MAINTAINER Lars Krantz

ENV TEMP_RESTORE_DIR /restoretemp
RUN mkdir $TEMP_RESTORE_DIR

RUN apk -Uv add python py-pip \
 && apk -UvX http://dl-4.alpinelinux.org/alpine/edge/main add postgresql \
 && apk -UvX http://dl-4.alpinelinux.org/alpine/edge/main add gzip \
 && apk -UvX http://dl-4.alpinelinux.org/alpine/edge/main add bash \
 && pip install --upgrade pip \
 && pip install awscli \
 && apk --purge -v del py-pip \
 && rm -rf /var/cache/apk/*
ADD ./restore_from_s3 /

ENTRYPOINT ["/restore_from_s3"]
