FROM golang:latest AS builder
WORKDIR /build
COPY . .
ENV CGO_ENABLED=0
RUN go build -ldflags "-s -w" -trimpath -o puppetdb-exporter .

FROM scratch AS runtime
COPY --from=builder /build/puppetdb-exporter /puppetdb-exporter
COPY ./puppetdb-facts.yaml /puppetdb-facts.yaml
ENTRYPOINT ["/puppetdb-exporter"]
