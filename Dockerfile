# Useful commands to deploy the now-app project Jar file

# Maven commands
#mvn clean install -U
#mvn clean install -U -DskipTests

# Docker Hub configurations

# Login Docker Hub

#docker login
#docker login -u "adailsilva" -p "password" docker.io
#docker login -u "adailsilva" -p "password" https://docker.io/

# Pattern
#docker build --tag <username>/<repo-name>:<tag> [more --flags...]
#docker buildx build --tag <username>/<repo-name>:<tag> [more --flags...]

# Deploy Local (Always generate a new jar first with maven - Command: 'mvn clean install -U -DskipTests')
#docker build --tag adailsilva/now-app_platform_linux-x86_64:latest --no-cache . 
#docker buildx build --platform 'linux/arm64' --tag adailsilva/now-app_platform_linux-arm64:latest --no-cache . 

# Deploy Remote (Always generate a new jar first with maven - Command: 'mvn clean install -U -DskipTests')
#docker build --tag adailsilva/now-app_platform_linux-x86_64:latest --no-cache --push . 
#docker buildx build --platform 'linux/arm64' --tag adailsilva/now-app_platform_linux-arm64:latest --no-cache --push . 

# Push image
#docker push adailsilva/now-app_platform_linux-x86_64:latest


# Logout Docker Hub
#docker logout docker.io
#docker logout https://docker.io/


# Deploy Local
#docker pull adailsilva/now-app_platform_linux-x86_64:latest
#docker pull adailsilva/now-app_platform_linux-arm64:latest

#docker run --name=now-app -p 8081:8081/tcp -p 8081:8081/udp adailsilva/now-app_platform_linux-x86_64:latest
#docker run --name=now-app -p 8081:8081/tcp -p 8081:8081/udp adailsilva/now-app_platform_linux-arm64:latest


# Summary of commands to Deploy Now application (without --push):
# cd /home/adailsilva/Apps/sts-4.22.1.RELEASE_workspace/now/ && \
# mvn clean install -U -DskipTests && \
# docker build --tag adailsilva/now-app_platform_linux-x86_64:latest --no-cache . && \
# docker-compose up --build -d

# Summary of commands to Deploy Now application (with --push):
# docker login -u "adailsilva" -p "password" docker.io && \
# cd /home/adailsilva/Apps/sts-4.22.1.RELEASE_workspace/now/ && \
# mvn clean install -U -DskipTests && \
# docker build --tag adailsilva/now-app_platform_linux-x86_64:latest --no-cache --push . && \
# docker-compose up --build -d


# Maven Build
FROM maven:3.8.3-openjdk-17 AS builder
COPY pom.xml /home/adailsilva/Apps/sts-4.22.1.RELEASE_workspace/now/
COPY src /home/adailsilva/Apps/sts-4.22.1.RELEASE_workspace/now/src/
RUN --mount=type=cache,target=/home/adailsilva/.m2 mvn -f /home/adailsilva/Apps/sts-4.22.1.RELEASE_workspace/now/pom.xml clean package -DskipTests

# Run
FROM openjdk:17.0.1-jdk-slim
COPY --from=builder /home/adailsilva/Apps/sts-4.22.1.RELEASE_workspace/now/target/now-0.0.1-SNAPSHOT.jar now-app.jar
EXPOSE 8080/tcp
EXPOSE 8080/udp
#ENTRYPOINT ["java", "-jar", "now-app.jar"]
ENTRYPOINT ["java", "-Xmx2048M", "-jar", "now-app.jar"]
