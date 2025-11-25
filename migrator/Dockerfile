FROM golang:1.25

WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go application into a binary
RUN go build -o app .

# Use the built binary as the entry point
CMD ["./app"]