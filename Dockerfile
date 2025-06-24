# -------- STAGE 1: Build --------
FROM maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /build
COPY demo /build/demo
WORKDIR /build/demo

RUN mvn clean package -DskipTests

# -------- STAGE 2: Run --------
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /build/demo/target/*.jar app.jar

EXPOSE 8082
ENTRYPOINT ["java", "-jar", "app.jar"]
