FROM java:8-jre-alpine
MAINTAINER findcoo <thirdlif2@gmail.com>
ENV KAFKA_VERSION=0.11.0.0 \
    SCALA_VERSION=2.11

ENV DIR_NAME=kafka_${SCALA_VERSION}-${KAFKA_VERSION}

RUN apk add --no-cache make bash && bash

COPY Makefile ./
RUN make install \
  && mv $DIR_NAME ./kafka \
  && mv Makefile /kafka/

WORKDIR kafka
COPY config ./config/
RUN touch test.txt

CMD ["make", "broker1"]
