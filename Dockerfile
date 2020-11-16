FROM alpine:latest as builder
RUN apk update && apk add --no-cache alpine-sdk linux-headers zlib-dev openssl-dev gperf cmake
COPY . /telegram-bot-api
WORKDIR /telegram-bot-api/build
RUN cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=.. .. && \
    cmake --build . --target install -- -j`nproc`


FROM alpine:latest
RUN apk update && apk add --no-cache libstdc++
COPY --from=builder /telegram-bot-api/bin/telegram-bot-api /usr/bin/telegram-bot-api
ENTRYPOINT telegram-bot-api --api-id=${API_ID} --api-hash=${API_HASH}