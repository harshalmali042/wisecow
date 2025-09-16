# Use Ubuntu 20.04
FROM ubuntu:20.04

# Avoid tzdata interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install all dependencies
RUN apt-get update && \
    apt-get install -y fortune-mod cowsay netcat && \
    rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy your script into container
COPY wisecow.sh .

# Make script executable
RUN chmod +x wisecow.sh

# Expose the port
EXPOSE 4499

# Run the script
CMD ["./wisecow.sh"]
