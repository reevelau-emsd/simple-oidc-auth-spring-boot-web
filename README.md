# Simple OIDC auth spring boot web

This demo project showcases the integration of Keycloak OIDC with a Spring Boot servlet application using Spring Security 6.3. It demonstrates a secure web application flow where users can authenticate via Keycloak and view their OIDC access token claims.

## Features

- **Index Page**: Contains login and logout buttons for anonymous users.
- **Authenticated Session**: Once authenticated, the page displays the keys and values from the OIDC access token claims.

## Prerequisites

Ensure you have Java 17 or newer installed to run the application.

## Environment Variables

The application requires the following environment variables to be set before starting:

- `KEYCLOAK_SERVER_URL`: URL of the Keycloak server.
- `KEYCLOAK_REALM`: Keycloak realm name.
- `KEYCLOAK_CLIENT_ID`: Client ID for the OIDC client.
- `KEYCLOAK_CLIENT_SECRET`: Secret associated with the client ID.
- `REDIRECT_URI`: URI to redirect after authentication.

## Starting the Application

To start the application, run the following command in the terminal:

```bash
export KEYCLOAK_SERVER_URL=<Your keycloak auth endpoint> \
export KEYCLOAK_REALM=<Your keycloak realm> \
export KEYCLOAK_CLIENT_ID=<Your keycloak client id> \
export KEYCLOAK_CLIENT_SECRET=<Your keycloak client secret> \
export REDIRECT_URI='{baseUrl}/login/oauth2/code/{registrationId}' \
./mvnw clean package spring-boot:run
```

## Handling Self-Signed TLS Certificates

If your Keycloak instance uses a self-signed TLS certificate, you will need to add the certificate to the JVM's CA certificate store. Follow the steps in the provided Dockerfile which demonstrates how to use the `keytool` command to import the certificate.

```bash
keytool -import -noprompt -trustcacerts -alias mycert -file /tmp/custom_ca_certs.pem -keystore $JAVA_HOME/lib/security/cacerts -storepass changeit
```

## Docker build and run

Run the following command to build the docker image.

```bash
docker build -t simple-oidc-auth-spring-boot-web:latest .
```

Run the following to start a continer that runs the demo app.

```base
docker run --name oidc \
    -e KEYCLOAK_SERVER_URL=<Your keycloak auth endpoint> \
    -e KEYCLOAK_REALM=<Your keycloak realm> \
    -e KEYCLOAK_CLIENT_ID=<Your keycloak client id> \
    -e KEYCLOAK_CLIENT_SECRET=<Your keycloak client secret> \
    -e REDIRECT_URI='{baseUrl}/login/oauth2/code/{registrationId}' \
    -p 8080:8080 java-oidc:latest
```

## Contributing

If you'd like to contribute to the project, please fork the repository and issue a pull request with your proposed changes.

