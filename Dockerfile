# Use image
FROM docker.io/golang:1-alpine AS build

# Set up user namespace mappings for Docker
RUN echo 'builder:1000:1' >> /etc/subuid && \
    echo 'builder:1000:1' >> /etc/subgid

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
FROM docker.io/alpine:3.20

# Set up user namespace mappings for Docker
RUN echo 'builder:1000:1' >> /etc/subuid && \
    echo 'builder:1000:1' >> /etc/subgid

# Create working directory
WORKDIR /app

# Copy built app
COPY --from=build /app/main /app/main

# Allow connections on 8080
EXPOSE 8080

# Run executable 
CMD [ "./main" ]
