# Use Ubuntu base image
FROM ubuntu:22.04

# Install dependencies
RUN apt-get update && apt-get install -y openjdk-11-jdk wget curl unzip && rm -rf /var/lib/apt/lists/*

# Download Tomcat from a stable mirror
RUN wget -q "https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.17/bin/apache-tomcat-10.1.17.tar.gz" \
    && mkdir -p /opt/tomcat \
    && tar -xzf apache-tomcat-10.1.17.tar.gz -C /opt/tomcat --strip-components=1 \
    && rm apache-tomcat-10.1.17.tar.gz \
    && chmod +x /opt/tomcat/bin/*.sh

# Set working directory
WORKDIR /opt/tomcat

# Copy war file
COPY Amazon.war /opt/tomcat/webapps/

# Expose port
EXPOSE 8080

# Start Tomcat
ENTRYPOINT ["sh", "bin/catalina.sh", "run"]

