# Use the official Vector base image
FROM timberio/vector:latest-debian

# Create a directory in the container for Vector's configuration
WORKDIR /etc/vector

# Copy the Vector configuration file into the container
COPY config/vector.toml /etc/vector/vector.toml

# Expose the Vector UI port (if enabled in vector.toml)
EXPOSE 8686

# Run Vector with the configuration file
CMD ["vector", "--config", "/etc/vector/vector.toml"]
