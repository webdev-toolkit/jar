########################### stage 1 ###########################
# Start FROM the node:alpine official image as a parent image which has Node.js LTS.
FROM node:current-slim as node

# Set the working directory to specify that all subsequent actions should be taken from the directory /usr/src/app in your image filesystem (never the host’s filesystem).
WORKDIR /usr/src/app

# Copy the rest of your app's source code from your host to your image filesystem.
COPY src/main/frontend/ .

# Run the command inside your image filesystem.
RUN npm install

# Run Prod Build inside your image filesystem
RUN npm run build-prod

########################### stage 2 ###########################
FROM openjdk:13-jdk-alpine as build
WORKDIR /workspace/app

COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .
COPY src src

RUN ./mvnw -e install -DprodDockerBuild
RUN mkdir -p target/dependency && (cd target/dependency; jar -xf ../*.jar)

########################### stage 3 ###########################
FROM openjdk:13-jdk-alpine
VOLUME /tmp

ARG DEPENDENCY=/workspace/app/target/dependency
COPY --from=build ${DEPENDENCY}/BOOT-INF/lib /app/lib
COPY --from=build ${DEPENDENCY}/META-INF /app/META-INF
COPY --from=build ${DEPENDENCY}/BOOT-INF/classes /app
COPY --from=node /usr/src/app/dist/frontend /app/static
ENTRYPOINT ["java","-cp","app:app/lib/*", "in.webdevtoolkit.backend.BackendApplication"]

########################### End ###########################

