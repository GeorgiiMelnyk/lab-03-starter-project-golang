FROM golang:1.19-alpine AS build

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -a -ldflags '-extldflags "-static"' -o build/fizzbuzz

FROM gcr.io/distroless/static-debian12

COPY --from=build /app/build/fizzbuzz /fizzbuzz

ENTRYPOINT ["/fizzbuzz"]