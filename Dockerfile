
# Use Maven official image as the build stage
FROM maven:3.8-openjdk-17-slim AS build
WORKDIR /app

# Copy the project files to the container
COPY . .

# Build the project and skip running tests
RUN ./mvnw clean package -DskipTests

# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy only the built artifact and nothing else
COPY --from=build /app/target/*.jar app.jar

# Copy the custom ca certificate into the container
COPY ./certs/custom_ca_certs.pem /tmp/custom_ca_certs.pem

# Import the certificate into the JVM's cacerts keystore
RUN keytool -import -noprompt -trustcacerts -alias mycert -file /tmp/custom_ca_certs.pem -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit || true


# Expose the port the application runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
