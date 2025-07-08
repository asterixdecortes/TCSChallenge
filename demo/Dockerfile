# First step. Compiling using Maven
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Copy the files needed to run the project. The mvn one will copy the wrapper, this way we won't need maven installed
COPY .mvn/ .mvn
# Project configuration
COPY mvnw pom.xml ./
# Source code
COPY src ./src

# Generates .jar in target/
RUN chmod +x ./mvnw && ./mvnw clean package -DskipTests

# Second step. Running. This image will be lighter than JDK as it will only include Java Runtime
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copies .jar compiled from the first step and renames it
COPY --from=builder /app/target/*.jar app.jar

# This docker will listen on port 8080, to expose it on your PC use docker run -p
EXPOSE 8080

# Define the default command when executing the container
ENTRYPOINT ["java", "-jar", "app.jar"]
