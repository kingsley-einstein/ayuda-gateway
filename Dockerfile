FROM maven:3-jdk-8-alpine AS build
COPY src ./src
COPY . ./
RUN mvn clean package -DskipTests
RUN mkdir app && mv ./target/ayuda-gateway-0.0.1-SNAPSHOT.jar app/gateway.jar

FROM openjdk:8-jre-alpine
COPY --from=build app .
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "-DPORT=8080", "-Dspring.profiles.active=production", "gateway.jar"]
