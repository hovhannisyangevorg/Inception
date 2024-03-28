FROM debian:buster

# Install necessary dependencies
RUN apt-get update -y && \
    apt-get install -y nginx openssl wget && \
    rm -rf /var/lib/apt/lists/*

# Install Go
ENV GO_VERSION 1.17.7
RUN wget -O go.tgz https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go.tgz && \
    rm go.tgz
ENV PATH=$PATH:/usr/local/go/bin

# Set environment variables
ENV AVAILAB=/etc/nginx/sites-available/
# Set the working directory
WORKDIR /Nginx

# Expose port 443
EXPOSE 443

# Copy configuration files and Go code
COPY ./conf/default.conf $AVAILAB
COPY ./tools/*.go ./
COPY ./.env ./

RUN chmod +x ./.env
RUN ./.env
# Make Go files executable
RUN chmod +x ./*.go

# Run the Go script to generate SSL certificate (replace generate-ssl-cert.go with your actual script name)
RUN go run generate-ssl-cert.go

# RUN cat /etc/ssl/certs/certificate.crt