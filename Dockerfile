FROM java:8-jre-alpine
MAINTAINER findcoo <thirdlif2@gmail.com>

RUN apk add --no-cache make

COPY Makefile ./
RUN make install

WORKDIR kafka
COPY config ./

CMD ["bash"]
