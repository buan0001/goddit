FROM golang:1.25

WORKDIR /app

# pre-copy/cache go.mod for pre-downloading dependencies and only redownloading them in subsequent builds if they change
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application source code
COPY . .

# Build the Go application into a binary
RUN go build -o bin .

# Use the built binary as the entry point
CMD ["/app/bin"]

# FROM golang:1.25

# ENV PROJECT_DIR=/app \
#     GO111MODULE=on \
#     CGO_ENABLED=0

# WORKDIR /app

# RUN mkdir "/build"

# RUN go install github.com/githubnemo/CompileDaemon

# COPY . .

# RUN go mod tidy

# ENTRYPOINT CompileDaemon -build="go build -o /build/app" -command="/build/app"

# FROM golang:1.25

# WORKDIR /app

# RUN go install github.com/air-verse/air@latest

# COPY . .

# ENTRYPOINT ["air"]