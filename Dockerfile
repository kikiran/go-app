##Stage 1: Base image
FROM golang:1.22.5 AS builder

WORKDIR /app

COPY go.mod .

RUN go mod download

COPY . .

RUN go build -o main .

##Stage 2: Final Image

FROM gcr.io/distroless/base

WORKDIR /app

COPY --from=builder /app/main .

COPY --from=builder /app/static ./static

CMD ["/app/main"]



