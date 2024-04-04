FROM golang:1.22.1 as builder

WORKDIR /home/anton/devops/03/
COPY . .
RUN make build

FROM scratch
WORKDIR /
COPY --from=builder /home/anton/devops/03/kbot .
COPY --from=alpine:latest /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
ENTRYPOINT ["./kbot"]