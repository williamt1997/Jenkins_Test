# Use image
FROM golang:1-alpine AS build
# Create working directory 
WORKDIR /app
# Copy files to working directory
COPY go.mod go.sum ./
# Download packages
RUN go mod download
# Copy rest of files
COPY . .
# Create executable
RUN go build -o main .

# Use image
FROM alpine:3.20
# Create working directory
WORKDIR /app
# Copy built app
COPY --from=build /app/main /app/main
# Allow connections on 8080
EXPOSE 8080
# Run executable 
CMD [ "./main" ]

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz
