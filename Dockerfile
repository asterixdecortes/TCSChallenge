# First step. compile using Maven
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Copy Maven config and source
COPY pom.xml ./
COPY src ./src

# Download dependencies and build jar
RUN apk add --no-cache maven && \
    mvn clean package -DskipTests

# Second step. run only image
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Copy the compiled JAR from the previous stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port
EXPOSE 8080

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]
